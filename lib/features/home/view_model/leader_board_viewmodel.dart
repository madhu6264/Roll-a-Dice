import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:roll_a_dice/features/home/model/leaderboard.dart';
import 'package:roll_a_dice/services/api_repository.dart';

class LeaderBoardViewModel extends ChangeNotifier {
  Repository _firebaseRepo;

  Stream<List<LeaderboardModel>> leaderboardData;

  Stream<LeaderboardModel> myScoreCard;

  var diceImages = ['d1.png', 'd2.png', 'd3.png', 'd4.png', 'd5.png', 'd6.png'];
  int randomDice = Random().nextInt(6);

  int totalScore = 0;
  int attemptsLeft = 0;

  LeaderBoardViewModel() {
    _firebaseRepo = Repository();

    fetchLeaderBoard();
  }

  fetchLeaderBoard() async {
    leaderboardData = _firebaseRepo.getLeaderBorad();
    notifyListeners();
  }

  fetchLeaderBoardByUser(BuildContext context) {
    return _firebaseRepo.getUserScoreboard(context);
  }

  saveScore(BuildContext context, int score, int remainingAttempts) async {
    _firebaseRepo.updateScore(context, score, remainingAttempts);
    notifyListeners();
  }

  rollDice(BuildContext context) {
    randomDice = Random().nextInt(6);
    saveScore(context, randomDice + 1, 10);

    notifyListeners();
  }
}
