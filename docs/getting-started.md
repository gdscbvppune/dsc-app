<h1 align="center">Getting Started</h1>

### ~> Preparing Repository :

1. [Fork](https://github.com/dscbvppune/dsc/fork) our repository.
2. Go to your forked repo settings and make it private. **(Most important step, DON'T skip it)**
3. Clone the repository.

### ~> Setting-up app name :

1. Decide an application name in format - `{your_website_domain}.{your_website_name}.{app_name}`.
2. Change the applicationId to your chosen name in `./android/app/build.gradle`.
3. Change it in `./android/app/src/debug/AndroidManifest.xml`.
4. Change it in `./android/app/src/main/AndroidManifest.xml`.
5. Change the directory tree in `./android/app/src/main/kotlin/` folder -
>> **Before -** `./android/app/src/main/kotlin/team/dscbvppune/dsc/MainActivity.kt`
>
>> **After -** `./android/app/src/main/kotlin/{your_website_domain}/{your_website_name}/{app_name}/MainActivity.kt`
6. Change it in `./android/app/src/main/kotlin/{your_website_domain}/{your_website_name}/{app_name}/MainActivity.kt`.

### ~> Setting-up CI Workflow :

1. Open the workflow file - `./.github/workflows/build-release-apk.yml`.
2. Goto the `Generating debug.keystore ...` step and change the `-dname` parameter values according to your needs.

### ~> Setting-up Firebase :

1. Open [Firebase Console](https://console.firebase.google.com/) and create a new project.
2. For Android refer to Firebase docs: [Add Firebase to your Android project](https://firebase.google.com/docs/android/setup?authuser=0).
3. For iOS refer to the Firebase docs: [Add Firebase to your iOS project](https://firebase.google.com/docs/ios/setup?authuser=0).
4. Make sure the package name of the project you entered is exactly the same as that of your app name.
5. Download the `google-services.json` file of your project.
6. Place the `google-services.json` file in `./android/app/` folder.

### ~> Some git magic :

1. Remove the `google-services.json` from `.gitignore` file to make sure that the file gets commited and pushed to remote.
2. Run `git add . && git commit -m "App Init"`. This will save your changes locally. Before running this command, make sure your `git` is setup correctly.
3. Create release tag by running `git tag v1.0`.
4. **Proceeed in this step with CAUTION !**
   Double check that your repo is private then only push to remote.
   Run `git push --tags` to push your tagged changes to remote repo.
5. This will start the workflow automatically as new tag is detected.

### ~> Finishing-up :

1. Wait for appox. 10 minutes or so. In the meantime you can goto the `Actions` tab of your repo and check the workflow progress.
2. After the workflow completes, a release will be there in your releases page.
3. You can find two assets in the release - APK & SHA1 file.
4. Download the SHA1 text file and enter it in your Firebase project settings under `SHA certificate fingerprints` section.

### ~> Setting-up DSC-App :

1. Download your dsc app and install it in your android device.
2. Open the app and login with the gmail ID of your DSC(admin) account that will have create, delete and update rights.
3. App will automatically initialize cloud firestore database for your website.
4. Add details of your team members, events organized by your DSC and the Code of Conduct of your DSC.
5. You're good to go !!

**NOTE : Don't ever make your repository public again, it will expose your Firebase's credentials. You can just delete the repo completely or change the google-services.json in your Firebase project.**

**Read further details in other docs.**
