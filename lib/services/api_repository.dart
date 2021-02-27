import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/features/auth/model/user.dart';
import 'package:roll_a_dice/features/auth/view_model/auth_view_model.dart';
import 'package:roll_a_dice/features/home/model/leaderboard.dart';

const USERS = 'users';

const LEADER_BOARD = "scores";

class Repository {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  List<UserModel> matches = [];

  Future<UserModel> getCurrentUser(String uid) async {
    DocumentSnapshot userDocument =
        await firestore.collection(USERS).doc(uid).get();
    if (userDocument != null && userDocument.exists) {
      return UserModel.fromJson(userDocument.data());
    } else {
      return null;
    }
  }

  createUser(UserModel user) async {
    await Repository.firestore
        .collection(USERS)
        .doc(user.userID)
        .set(user.toJson())
        .catchError((onError) {
      print(onError);
    });
  }

  Stream<List<LeaderboardModel>> getLeaderBorad() {
    return firestore
        .collection(LEADER_BOARD)
        .where('isGameCompleted', isEqualTo: true)
        .orderBy('totalScore', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LeaderboardModel.fromJson(doc.data()))
            .toList());
  }

  Stream<List<LeaderboardModel>> getUserScoreboard(BuildContext context) {
    AuthProvider authProvider = Provider.of(context, listen: false);

    return firestore
        .collection(LEADER_BOARD)
        .where('userID', isEqualTo: authProvider.userModel.userID)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => LeaderboardModel.fromJson(doc.data()))
            .toList());
  }

  updateScore(BuildContext context, int score, int remainingAttempts) async {
    AuthProvider authProvider = Provider.of(context, listen: false);

    DocumentSnapshot documentSnapshot = await Repository.firestore
        .collection(LEADER_BOARD)
        .doc(authProvider.userModel.userID)
        .get();

    if (documentSnapshot != null && documentSnapshot.exists) {
      await Repository.firestore
          .collection(LEADER_BOARD)
          .doc(authProvider.userModel.userID)
          .set(LeaderboardModel(
                  availableChances:
                      LeaderboardModel.fromJson(documentSnapshot.data())
                              .availableChances -
                          1,
                  fullName: authProvider.userModel.firstName +
                      " " +
                      authProvider.userModel.lastName,
                  isGameCompleted: LeaderboardModel.fromJson(
                                  documentSnapshot.data())
                              .availableChances ==
                          1
                      ? true
                      : false,
                  totalScore: LeaderboardModel.fromJson(documentSnapshot.data())
                          .totalScore +
                      score,
                  userID: authProvider.userModel.userID)
              .toJson())
          .catchError((onError) {
        print(onError);
      });
    } else {
      await Repository.firestore
          .collection(LEADER_BOARD)
          .doc(authProvider.userModel.userID)
          .set(LeaderboardModel(
                  availableChances: 9,
                  fullName: authProvider.userModel.firstName +
                      " " +
                      authProvider.userModel.lastName,
                  isGameCompleted: false,
                  totalScore: score,
                  userID: authProvider.userModel.userID)
              .toJson())
          .catchError((onError) {
        print(onError);
      });
    }
  }
}
