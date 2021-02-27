import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:package_info/package_info.dart';
import 'package:roll_a_dice/features/auth/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:roll_a_dice/features/home/view/home_screen.dart';
import 'package:roll_a_dice/services/api_repository.dart';
import 'package:roll_a_dice/utils/helper.dart';

class AuthProvider with ChangeNotifier {
  UserModel userModel;
  User firebaseUserInfo;
  StreamSubscription userAuthSub;
  Repository _firebaseRepo;

  PackageInfo packageInfo;

  AuthProvider() {
    _firebaseRepo = Repository();
    userAuthSub =
        FirebaseAuth.instance.authStateChanges().listen((firebaseUser) async {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $firebaseUser');

      firebaseUserInfo = firebaseUser;
      userModel = await _firebaseRepo.getCurrentUser(firebaseUser.uid);
      notifyListeners();
    }, onError: (e) {
      print('AuthProvider - FirebaseAuth - onAuthStateChanged - $e');
    });
    getAppInfo();
  }

  getAppInfo() async {
    packageInfo = await PackageInfo.fromPlatform();

    print(packageInfo.toString());
    notifyListeners();
  }

  bool get isAuthenticated {
    return firebaseUserInfo != null;
  }

  login(BuildContext context, String email, String password) async {
    try {
      showProgress(context, 'Logging in, please wait...', false);

      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } on auth.FirebaseAuthException catch (exception) {
      hideProgress();
      switch ((exception).code) {
        case "invalid-email":
          showAlertDialog(
              context, 'Couldn\'t Authenticate', 'Email address is malformed.');
          break;
        case "wrong-password":
          showAlertDialog(context, 'Couldn\'t Authenticate', 'Wrong password.');
          break;
        case "user-not-found":
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'No user corresponding to the given email address.');
          break;
        case "user-disabled":
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'This user has been disabled.');
          break;
        case 'too-many-requests':
          showAlertDialog(context, 'Couldn\'t Authenticate',
              'Too many requests, Please try again later.');
          break;
      }
      print(exception.toString());
      return null;
    } catch (e) {
      hideProgress();
      showAlertDialog(
          context, 'Couldn\'t Authenticate', 'Login failed. Please try again.');
      print(e.toString());
    }
  }

  signUp(BuildContext context, String email, String password, String firstName,
      String lastName) async {
    showProgress(context, 'Creating new account, Please wait...', false);
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim());

      UserModel user = UserModel(
        email: email.trim(),
        firstName: firstName,
        userID: result.user.uid,
        lastName: lastName,
      );
      await _firebaseRepo.createUser(user);

      hideProgress();

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
    } on auth.FirebaseAuthException catch (error) {
      hideProgress();

      String message = 'Couldn\'t sign up';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email already in use, Please login to continue!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'Password must be more than 5 characters';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
        default:
          break;
      }

      showAlertDialog(context, 'Failed', message);
      print(error.toString());
    } catch (e) {
      hideProgress();
      showAlertDialog(context, 'Failed', 'Couldn\'t sign up');
    }
  }

  void signOut(BuildContext context) {
    FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

  @override
  void dispose() {
    if (userAuthSub != null) {
      userAuthSub.cancel();
      userAuthSub = null;
    }
    super.dispose();
  }
}
