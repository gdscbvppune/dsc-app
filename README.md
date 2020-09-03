<h1 align="center">
  <span><h3>DSC Web-App</h3></span>

  <p align="center">
    <a href="https://flutter.dev/"><img src="https://img.shields.io/badge/Built with-flutter-blue?style=for-the-badge" alt="flutter"/></a>
    <a href="https://github.com/dscbvppune/dsc/commits/master/"><img src="https://img.shields.io/github/last-commit/dscbvppune/dsc?style=for-the-badge" alt="last commit"/></a>
    <a href="https://github.com/dscbvppune/dsc/blob/master/LICENSE"><img src="https://img.shields.io/badge/License-MIT-purple?style=for-the-badge" alt="license"/></a>
  </p>
</h1>

<p align="center">
  <img src="/docs/images/drawer.jpg" width="32%" alt="drawer"/>
  <img src="/docs/images/home1.jpg" width="34%" alt="home"/>
  <img src="/docs/images/about.jpg" width="32%" alt="about"/>
  <img src="/docs/images/events.jpg" width="32%" alt="events"/>
  <img src="/docs/images/home2.jpg" width="34%" alt="home"/>
  <img src="/docs/images/coc.jpg" width="32%" alt="code of conduct"/>
</p>

---

## Overview

This project aims at making websites easier to manage. We at **DSC BVP Pune** noticed that many DSC's have outdated websites or do not even have an existing website. In order to solve this issue, we came up with a solution where maintainers could easily manage their websites using a mobile app.

## Features

| Feature                 | Description                                                                                |
| ----------------------- | ------------------------------------------------------------------------------------------ |
| **Built using Flutter** | The App is built exclusively in Flutter, while the adjoining website is built using Vue.js |
| **Portability**         | This Web-App can be used as a template by other Student Clubs                              |
| **User Experience**     | User-friendly and reliable, as well as handy and easy to use                               |
| **Auto Initialize**     | App automatically initalizes databases for un-initialized and/or new DSC websites          |
| **Powered by Firebase** | Cloud Firestore of Firebase provides solutions for storage issues                          |

## Getting Started

1. [Fork](https://github.com/dscbvppune/dsc/fork) our repository and clone it locally.
2. Open the repo in [VSCode](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio).
3. Open [Firebase Console](https://console.firebase.google.com/) and create a new project.
4. Connect your mobile-app project, either Android or iOS, with Firebase.
5. For Android refer to Firebase docs: [Add Firebase to your Android project](https://firebase.google.com/docs/android/setup?authuser=0).
6. For iOS refer to the Firebase docs: [Add Firebase to your iOS project](https://firebase.google.com/docs/ios/setup?authuser=0).
7. After setup has been done, Connect your phone to PC or MAC via USB.
8. Build the application in the IDE which you use for Flutter development or run `flutter run --release` on your console.
9. For setting up Firestore refer to the documentation below.
10. Great! Now your app is ready to go.
11. Enter the gmail ID of your DSC(admin) account that will have create, delete and update rights.
12. Add details of your team members, events organized by your DSC and the Code of Conduct of your DSC.
13. For Android users: If you want to build the apk: Run `flutter build apk --release` in your console.
14. For iOS users : Run 'flutter build ios' in your console of Xcode. Refer [Create a build archive](https://flutter.dev/docs/deployment/ios#create-a-build-archive) for detailed info.

### Setting up on Firestore

#### Setting security rules on Firestore

Create a Firestore Database in production mode, and add the following security rules to the database, to add authentication for only specific people to be able to update details on Firestore:

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

#### Setting security rules on Firebase Storage

Enable the Firebase Storage, and add the following security rules to the database, to add authentication for only specific people to be able to add / update media to the storage bucket:

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

## Technology Stacks

#### Frontend Stacks

- Flutter

#### Backend Stacks

- Firebase

## Directory Structure

```
dsc
├── android
│    └── *
├── assets
│   ├── fonts
│   │   └── *
│   ├── icons
│   │   └── *
│   ├── images
│   │   └── *
│   ├── logos
│   │   └── *
│   ├── svg
│   │   └── *
│   └── json
│       └── *
├── docs
│   └── images
│       └── *
├── ios
│   └── *
├── lib
│   ├── pages
│   │   ├── achievementsPage.dart
│   │   ├── addEvent.dart
│   │   ├── addGuidelines.dart
│   │   ├── addMember.dart
│   │   ├── cocPage.dart
│   │   ├── editHomePage.dart
│   │   ├── eventDescription.dart
│   │   ├── eventsPage.dart
│   │   ├── homePage.dart
│   │   ├── imageExpand.dart
│   │   ├── loginPage.dart
│   │   ├── manageCOC.dart
│   │   ├── memberDetails.dart
│   │   ├── splashPage.dart
│   │   └── teamPage.dart
│   ├── services
│   │   ├── authHandler.dart
│   │   ├── authService.dart
│   │   ├── buttonBuilder.dart
│   │   ├── databaseHandler.dart
│   │   └── pageHandler.dart
│   └── main.dart
└── test
    └── *
```

#### Function of each file

| File                                                       | Function                                                  |
| ---------------------------------------------------------- | --------------------------------------------------------- |
| [achievementsPage.dart](/lib/pages/achievementsPage.dart)  | Displaying achievements of DSC (WIP)                      |
| [addEvent.dart](/lib/pages/addGuidelines.dart)             | Page for adding events                                    |
| [addGuidelines.dart](/lib/pages/addGuidelines.dart)        | Page for adding guidelines for your DSC                   |
| [addMember.dart](/lib/pages/addMember.dart)                | Page for adding team members of your DSC                  |
| [cocPage.dart](/lib/pages/cocPage.dart)                    | Code of Conduct page of your DSC                          |
| [editHomePage.dart](/lib/pages/editHomePage.dart)          | Page for editing homepage of your DSC's website           |
| [eventDescription.dart](/lib/pages/eventDescription.dart)  | Description page for events                               |
| [eventsPage.dart](/lib/pages/eventsPage.dart)              | Pages for displaying all events of your DSC               |
| [homePage.dart](/lib/pages/homePage.dart)                  | Home page of the app                                      |
| [imageExpand.dart](/lib/pages/imageExpand.dart)            | Page to display expanded view of an image asset           |
| [loginPage.dart](/lib/pages/loginPage.dart)                | Login page of the app for signing-in with google          |
| [manageCOC.dart](/lib/pages/manageCOC.dart)                | Page for altering code of conduct of your DSC             |
| [memberDetails.dart](/lib/pages/memberDetails.dart)        | Adding details of your team                               |
| [splashPage.dart](/lib/pages/splashPage.dart)              | Temporary loading page with circular progress indicator   |
| [teamPage.dart](/lib/pages/teamPage.dart)                  | Page for displaying your DSC                              |
| [authHandler.dart](/lib/services/authHandler.dart)         | Dart file for user auth detection                         |
| [authService.dart](/lib/services/authService.dart)         | Dart file for google and firebase login                   |
| [buttonBuilder.dart](/lib/services/buttonBuilder.dart)     | Dart file for building stretchable raised buttons         |
| [databaseHandler.dart](/lib/services/databaseHandler.dart) | Dart file for handling databases for both website and app |
| [pageHandler.dart](/lib/services/pageHandler.dart)         | Dart file for handling navigation of pages                |
| [main.dart](/lib/main.dart)                                | Entry point of the material app that calls authHandler    |

## Contributors

<table>
<tbody>
  <tr width="100%">
    <td align="center">
      <a href="https://github.com/Abhi011999">
        <img width="150" src="https://avatars2.githubusercontent.com/u/27683952?s=400&v=4"><br>
        @Abhi011999
      </a> <br>
      <strong>Abhishek Dubey</strong><br>
      &bull; &bull; &bull;<br>
      <a href="mailto:abhi.dubey011999@gmail.com">E-Mail</a>
    </td>
    <td align="center">
      <a href="https://github.com/Nishchayverma">
        <img width="150" src="https://avatars1.githubusercontent.com/u/55492465?s=400&v=4"><br>
        @Nishchayverma
      </a> <br>
      <strong>Nishchay Verma</strong><br>
      &bull; &bull; &bull;<br>
      <a href="mailto:nishchayverma20@gmail.com">E-Mail</a>
    </td>
    <td align="center">
      <a href="https://github.com/priyanshu-01">
        <img width="150" src="https://avatars3.githubusercontent.com/u/56172661?s=400&v=4"><br>
        @priyanshu-01
      </a> <br>
      <strong>Priyanshu Agarwal</strong><br>
      &bull; &bull; &bull;<br>
      <a href="mailto:priyanshu.agarwal88@gmail.com">E-Mail</a>
    </td>
    <td align="center">
      <a href="https://github.com/codesparsh">
        <img width="150" src="https://avatars2.githubusercontent.com/u/43840499?s=400&v=4"><br>
        @codesparsh
      </a> <br>
      <strong>Sparsh Tandon</strong><br>
      &bull; &bull; &bull;<br>
      <a href="mailto:snowmansparsh4@gmail.com">E-Mail</a>
    </td>
  </tr>
</tbody>
</table>

## App Usage Information

Hi, there! If you liked this project and are using it for your DSC's community then kindly fill [this](https://github.com/dscbvppune/dsc-app/issues/new?assignees=Abhi011999&labels=usage+info&template=app-usage-information.md&title=%5BINFO%5D) usage info issue and submit it. We'll love to hear your feedback!

## Contributing

See [CONTRIBUTING.md](/CONTRIBUTING.md)

## Support

- If you have any issues, feel free to hit us up at [dscbvppune@gmail.com](mailto:dscbvppune@gmail.com).
- You can also put up queries on GitHub Issues [here](https://github.com/dscbvppune/dsc-app/issues).

## License

> This project is licensed under the MIT License - see the [LICENSE](/LICENSE) file for details.
