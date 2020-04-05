<h1 align="center">Setting up on Cloud Firestore</h1>

### ~> Setting security rules on Firestore

- Create a Firestore Database in production mode, and add the following security rules to the database, to add authentication for only specific people to be able to update details on Firestore:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read;
      allow create, write, update, delete: if request.auth.token.email.matches("dscchapteremailaddress[@]gmail[.]com");
    }
  }
}
```

### ~> Setting security rules on Firebase Storage

- Enable the Firebase Storage, and add the following security rules to the database, to add authentication for only specific people to be able to add / update media to the storage bucket:

```
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read;
      allow write, create, delete, update: if request.auth.token.email.matches("dscchapteremailaddress[@]gmail[.]com");
    }
  }
}
```