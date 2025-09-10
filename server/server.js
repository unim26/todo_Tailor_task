import express from 'express';
import { createClient } from '@supabase/supabase-js';
import admin from 'firebase-admin';
import cron from 'node-cron';
import dotenv from 'dotenv';

dotenv.config();

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_SERVICE_ROLE_KEY);

admin.initializeApp({
  credential: admin.credential.cert(process.env.GOOGLE_APPLICATION_CREDENTIALS),
});

const app = express();
app.use(express.json());

// Helper to convert deadline string ("4:44 AM") to today's Date object
function getTodayDateForTime(timeString) {
  const [time, modifier] = timeString.split(' ');
  let [hours, minutes] = time.split(':').map(Number);
  if (modifier === 'PM' && hours !== 12) hours += 12;
  if (modifier === 'AM' && hours === 12) hours = 0;

  const now = new Date();

  //the given time will be as user wants to be get notified so we will set it one hour before so that we can notify user before an hour
  return new Date(
    now.getFullYear(), now.getMonth(), now.getDate(),
    hours -1, minutes, 0, 0
  );
}

// Cron job to run every minute
cron.schedule('* * * * *', async () => {
  console.log('Checking todos for notifications...');

  const { data: todos, error } = await supabase
    .from('Todos')
    .select('id, title, user_id, deadline, is_noti_sent, is_completed')
    .eq('is_completed', false)
    .eq('is_noti_sent', false);


  if (error) {
    console.error('Error fetching todos:', error);
    return;
  }
  if (!todos || todos.length === 0) {
    console.log('No todos pending.');
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

      const message = {
        token: user.fcm_token,
        notification: {
          title: '⏰ Todo Deadline!',
          body: `⚡ Time’s ticking! Finish your todo -  ${todo.title} before it’s too late! ⏳`,
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

        // Insert notification record
        await supabase.from('Notifications').insert({
          user_id: todo.user_id,
          noti_title: 'Todo Deadline',
          noti_desc: `Your todo "${todo.title}" is now due!`,
          created_at: new Date().toISOString(),
        });

        // Update todo as notified
        await supabase.from('Todos').update({ is_noti_sent: true }).eq('id', todo.id);
      } catch (sendError) {
        console.error('Error sending notification:', sendError);
      }
    }
  }
});

app.listen(3000, () => {
  console.log('Notification backend running on port 3000');
});
