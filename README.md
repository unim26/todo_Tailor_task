

````markdown
# Todo App with Supabase Authentication and database, Firestore & Firebase Cloud Messaging

This is a **Flutter-based Todo App** that integrates **Supabase** for user authentication and database, and **Firebase Cloud Messaging (FCM)** for sending notifications about todo deadlines.

## Features

- **Supabase Authentication**: Sign up/login using google account.
- **Supabase Database**: Store and manage todos with deadlines.
- **Firebase Cloud Messaging (FCM)**: Receive notifications 1 hour before a todo’s deadline.

## Steps to Use

### Step 1: Clone the Repository

```bash
git clone https://github.com/unim26/todo-app.git
cd todo-app
````

### Step 2: Install Dependencies

Make sure you have **Flutter** installed. Then run:

```bash
flutter pub get
```

### Step 3: Set Up Firebase and Supabase

1. **Firebase Setup**:

   * Create a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   * Enable Firestore and Firebase Cloud Messaging (FCM).
   * Download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS) and add them to your project.

2. **Supabase Setup**:

   * Create a project on [Supabase](https://supabase.io/).
   * Enable authentication (email/password).
   * Set up a table `todos` with the following fields:

     * `id` (Primary Key)
     * `user_id` (Foreign Key from Supabase `auth.users`)
     * `title`
     * `description`
     * `deadline` (Timestamp)
     * `is_completed` (Boolean)

3. **Configure Firebase and Supabase**:

   * Replace the Firebase and Supabase credentials in the Flutter project (in the respective config files).

### Step 4: Run the App

After setting everything up, you can run the app using:

```bash
flutter run
```

### Step 5: Build and Release

For Android:

```bash
flutter build apk
```

For iOS:

```bash
flutter build ios
```

```


```

