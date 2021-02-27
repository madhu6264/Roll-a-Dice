# Roll a Dice Game Built on Flutter with Firebase(MVVM)

This is a **simple game** that can support **Realtime Data & Offline Caching** using Flutter & Firebase.

I call this "**Stream-based** Architecture for Flutter & Firebase **Realtime** Apps".

# Demo
![Demo](gif)

# Features
* Firebase Authentication
* Realtime Data Update with Cloud Firestore
* Maintain app sate
* Offline Capabily
* Supporting flutter build varients like Dev, Staging, Prod
    
## Getting Started
**Note:** Make sure your Flutter environment is [setup](https://flutter.io/getting-started/).

#### Installation

In the command terminal, run the following commands:

    $ git clone 
    $ cd FlatApp-Firebase-Flutter/
    
#### Setup Flutter Firebase integration
Check out the [documentation](https://codelabs.developers.google.com/codelabs/flutter-firebase/#4) to setup Flutter Firebase integration.

##### For Android
In `android/app` folder add your `google-service.json`.
##### For iOS
In `ios/Runner` folder add your `GoogleService-Info.plist`.

##### Start your Flutter project by running the command:
    $ flutter run

# Simulate for iOS
#### Method One
    
    Open the project in Xcode from ios/Runner.xcodeproj.
    Hit the play button.

#### Method Two

    Run the following command in your terminal.
    $ open -a Simulator
    $ flutter run

# Simulate for Android

    Make sure you have an Android emulator installed and running.
    Run the following command in your terminal.
    $ flutter run
    
##### Check out Flutter’s online [documentation](http://flutter.io/) for help getting start with your Flutter project. 



## [License: MIT](LICENSE.md)
