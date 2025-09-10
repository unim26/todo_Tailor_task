# Todo Reminder App

A full-stack application that helps users keep track of their tasks by sending push notifications when deadlines approach. The backend uses Supabase for data storage and authentication, and Firebase Cloud Messaging (FCM) for notifications. The frontend is built with Flutter.

---

## Features

- User authentication via Supabase
- Store and manage todo tasks with deadlines
- Automated push notifications for upcoming deadlines
- Supports light and dark themes for better user experience (default to system)
- Backend built with Node.js for scalable notification scheduling

---

## Getting Started

### Prerequisites

- Node.js and npm installed
- Flutter SDK installed
- Supabase project setup with tables and API keys
- Firebase project configured with FCM and service account

### Setup

1. **Clone the repository**

```
git clone https://github.com/unim26/todo_Tailor_task.git
cd todo_Tailor_task
```


2. **Backend**  
- Navigate to `server/` directory  
- Create a `.env` file with Supabase and Firebase credentials  
- Run:  
  ```
  npm install
  node server.js
  ```

3. **Frontend**  
- Navigate to `client/todo/` directory  
- Run:  
  ```
  flutter pub get
  flutter run
  ```
- Configure your Supabase and Firebase keys in the Flutter app as needed

---

## Environment Variables

Create a `.env` file in the backend (`server/`) folder with:

```
SUPABASE_URL=your-supabase-url
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
GOOGLE_SERVICE_ACCOUNT_JSON='your-firebase-service-account-json-string'
```


*Note:* Store your Firebase service account JSON securely; do not commit it to GitHub.

---

## Deployment

- Backend can be deployed on cloud platforms like Render or AWS.  
- Remember to configure environment variables in the cloud environment.  
- Set the **Root Directory** to `/server` when deploying backend code on Render.

---

## Usage

- Add your todos with deadlines in the Flutter app.  
- The backend checks deadlines periodically and sends notifications via FCM.  
- Notifications include sounds and vibrations for better engagement.  




## Acknowledgments

- [Supabase](https://supabase.com) for the backend services  
- [Firebase](https://firebase.google.com) for push notifications  
- Flutter community for continuous support and great packages

---

