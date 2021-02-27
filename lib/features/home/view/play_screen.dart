import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/features/home/model/leaderboard.dart';
import 'package:roll_a_dice/features/home/view_model/leader_board_viewmodel.dart';

class PlayGameScreen extends StatefulWidget {
  @override
  _PlayGameScreenState createState() => _PlayGameScreenState();
}

class _PlayGameScreenState extends State<PlayGameScreen> {
  LeaderboardModel leaderboardModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Roll Dice!'),
        ),
        body: Consumer<LeaderBoardViewModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
                child: StreamBuilder(
                    stream: model.fetchLeaderBoardByUser(context),
                    builder: (context, snapshot) {
                      if ((snapshot != null &&
                          snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data.length > 0)) {
                        leaderboardModel = snapshot.data[0];
                      }

                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.videogame_asset,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1),
                                            text: "Score: ",
                                          ),
                                          TextSpan(
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1),
                                            text: (snapshot != null &&
                                                    snapshot.hasData &&
                                                    snapshot.data != null &&
                                                    snapshot.data.length > 0)
                                                ? snapshot.data[0].totalScore
                                                    .toString()
                                                : "0",
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.timelapse_rounded,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1),
                                            text: "Remaining: ",
                                          ),
                                          TextSpan(
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1),
                                            text: (snapshot != null &&
                                                    snapshot.hasData &&
                                                    snapshot.data != null &&
                                                    snapshot.data.length > 0)
                                                ? snapshot.data[0]
                                                        .availableChances
                                                        .toString() +
                                                    "/10"
                                                : "0/10",
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/' +
                                    model.diceImages[model.randomDice],
                                height: 150,
                                width: 150,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 60),
                            child: leaderboardModel != null &&
                                    leaderboardModel.availableChances <= 0
                                ? Text(
                                    "You have successfully completed the Game!",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                : RaisedButton(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30),
                                    onPressed: () {
                                      model.rollDice(context);
                                    },
                                    child: Text('Roll Dice'),
                                  ),
                          )
                        ],
                      );
                    }));
          },
        ));
  }
}
