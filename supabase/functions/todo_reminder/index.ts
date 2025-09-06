// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

// Setup type definitions for built-in Supabase Runtime APIs
import "jsr:@supabase/functions-js/edge-runtime.d.ts"
import { createClient } from "https://esm.sh/@supabase/supabase-js@2";
// Environment variables
const SUPABASE_URL = Deno.env.get("SUPABASE_URL")!;
const SUPABASE_SERVICE_ROLE_KEY = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY")!;
const FCM_SERVER_KEY = Deno.env.get("FCM_SERVER_KEY")!;

const supabase = createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY);

// Helper to convert deadline string like "4:44 AM" to today's Date object
function getTodayDateForTime(timeString: string) {
  const [time, modifier] = timeString.split(' ');
  let [hours, minutes] = time.split(':').map(Number);

  if (modifier === 'PM' && hours !== 12) hours += 12;
  if (modifier === 'AM' && hours === 12) hours = 0;

  const now = new Date();
  return new Date(
    now.getFullYear(),
    now.getMonth(),
    now.getDate(),
    hours - 1,
    minutes,
    0,
    0
  );
}

Deno.serve(async (req) => {
  const now = new Date();

  // Fetch todos where not completed and notification not sent
  const { data: todos, error: todosError } = await supabase
    .from("Todos")
    .select("id, title, user_id, deadline, is_noti_sent, is_completed")
    .eq("is_completed", false)
    .eq("is_noti_sent", false);

    if (todosError) {
      console.error("Error fetching todos:", todosError.message);
      return new Response("Error fetching todos", { status: 500 });
    }

    if (!todos || todos.length === 0) {
      return new Response("No due todos", { status: 200 });
    }

    for (const todo of todos) {
      if (!todo.deadline) continue;

      const todoDeadline = getTodayDateForTime(todo.deadline);

      if (now >= todoDeadline) {
        // Get user's FCM token from Users table
        const { data: user, error: userError } = await supabase
          .from("Users")
          .select("fcm_token")
          .eq("id", todo.user_id)
          .single();

        if (userError || !user || !user.fcm_token) {
          console.warn(`No FCM token for user_id ${todo.user_id}, skipping`);
          continue;
        }

        // Notification title and description
        const notifTitle = "Todo Deadline";
        const notifDesc = `Your todo "${todo.title}" is now due!`;

        // Send notification using Firebase Cloud Messaging Server Key
        // const fcmRes = await fetch("https://fcm.googleapis.com/fcm/send", {
        //   method: "POST",
        //   headers: {
        //     "Authorization": `key=${FCM_SERVER_KEY}`,
        //     "Content-Type": "application/json",
        //   },
        //   body: JSON.stringify({
        //     to: user.fcm_token,
        //     notification: {
        //       title: notifTitle,
        //       body: notifDesc,
        //     },
        //     data: {
        //       todoId: todo.id,
        //     },
        //   }),
        // });

        // if (!fcmRes.ok) {
        //   console.error(`Failed to send notification for todo ${todo.id}`, await fcmRes.text());
        //   continue;
        // }

        // Insert notification record in Notifications table
        const { error: notificationError } = await supabase
          .from("Notifications")
          .insert([
            {
              noti_title: notifTitle,
              noti_desc: notifDesc,
              user_id: todo.user_id,
            },
          ]);

          console.warn('Noti added..!');


        if (notificationError) {
          console.error(`Failed to insert notification for todo ${todo.id}`, notificationError.message);
        }

        // Mark todo as notified
        const { error: updateError } = await supabase
          .from("Todos")
          .update({ is_noti_sent: true })
          .eq("id", todo.id);

        if (updateError) {
          console.error(`Failed to update todo ${todo.id}`, updateError.message);
        }
      }
    }

    return new Response("Processed todos", { status: 200 });
})

/* To invoke locally:

  1. Run `supabase start` (see: https://supabase.com/docs/reference/cli/supabase-start)
  2. Make an HTTP request:

  curl -i --location --request POST 'http://127.0.0.1:54321/functions/v1/todo_reminder' \
    --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0' \
    --header 'Content-Type: application/json' \
    --data '{"name":"Functions"}'

*/
