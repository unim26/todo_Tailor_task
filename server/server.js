import express from 'express';
import { createClient } from '@supabase/supabase-js';
import admin from 'firebase-admin';
import cron from 'node-cron';
import dotenv from 'dotenv';

dotenv.config();
//Helper
const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);


//parsing json 
const serviceAccount = JSON.parse(process.env.GOOGLE_SERVICE_ACCOUNT_JSON);

//intializing firebase admin
admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const app = express();
app.use(express.json());

//root path it will be  used  for awake call
app.use('/',(req,res) => {
  console.log('Awake call from client');
  res.status(200).send({"message":"Running"});
});

// Helper to convert deadline string ("4:44 AM") to today's Date object
function getTodayDateForTime(timeString) {
  //get time from string
  const [time, modifier] = timeString.split(' ');
  let [hours, minutes] = time.split(':').map(Number);
  if (modifier === 'PM' && hours !== 12) hours += 12;
  if (modifier === 'AM' && hours === 12) hours = 0;

  //get dealyTime from string 
  let [dealyTime, horm] = time.split(' ').map(Number);

  const now = new Date();   

  //the given time will be as user wants to be get notified so we will set it one hour before so that we can notify user before an hour
  if(horm == 'H'){
    return new Date(
      now.getFullYear(), now.getMonth(), now.getDate(),
      hours - dealyTime, minutes, 0, 0
    );
  } else if(horm == 'M'){
    return new Date(
      now.getFullYear(), now.getMonth(), now.getDate(),
      hours, minutes - dealyTime, 0, 0
    );
  }
}

// Cron job to run every minute
cron.schedule('* * * * *', async () => {

  const { data: todos, error } = await supabase
    .from('Todos')
    .select('id, title, user_id, deadline, is_noti_sent, is_completed,delay')
    .eq('is_completed', false)
    .eq('is_noti_sent', false);

  if (error) {
    console.error('Error fetching todos:', error);
    return;
  }
  if (!todos || todos.length === 0) {
    return;
  }

  const now = new Date();

  for (const todo of todos) {
    if (!todo.deadline) continue;
    const todoDeadline = getTodayDateForTime(todo.deadline);

    if (now >= todoDeadline) {
      const { data: user, error: userError } = await supabase
        .from('Users')
        .select('fcm_token')
        .eq('id', todo.user_id)
        .single();

      if (userError || !user || !user.fcm_token) {
        console.warn(`No FCM token for user_id ${todo.user_id}, skipping`);
        continue;
      }
      
      //we have arry of fcm tokens so loop over all fcm tokens and send to each
      for(const fcmToken of user.fcm_token){
        const message = {
          token: fcmToken,
          notification: {
            title: '⏰ Todo Deadline!',
            body: `⚡ Time’s ticking! Finish your todo -  ${todo.title} \n before it’s too late! ⏳`,
          },
          android:{
            notification: {
              channelId: "todo_reminders",
              sound: "default",
              defaultVibrateTimings: true,
            },
          },
          data: {
            todoId: todo.id.toString(),
          },
        };
  
        try {
         
          await admin.messaging().send(message);
  
          
  
         
        } catch (sendError) {
          console.error('Error sending notification:', sendError);
        }
      
      }
      // Insert notification record
        // await supabase.from('Notifications').insert({
        //   user_id: todo.user_id,
        //   noti_title: 'Todo Deadline',
        //   noti_desc: `Your todo "${todo.title}" is now due!`,
        //   created_at: new Date().toISOString(),
        // });

        // Update todo as notified
        await supabase.from('Todos').update({ is_noti_sent: true }).eq('id', todo.id);
    }
  }
});

app.listen(3000, () => {
  console.log('Notification backend for todo is running');
});
