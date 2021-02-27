import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/features/home/view_model/leader_board_viewmodel.dart';
import 'package:roll_a_dice/features/settings/view/settings_screen.dart';
import 'package:roll_a_dice/utils/flavors_config.dart';

import 'play_screen.dart';
import 'leaderboard_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Offstage(),
        title: Text(Constants.APP_NAME),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Settings',
            onPressed: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => SettingsScreen()));
            },
          ),
        ],
      ),
      body: Consumer<LeaderBoardViewModel>(
        builder: (context, model, child) {
          return StreamBuilder(
              stream: model.leaderboardData,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return LeaderboardCard(details: snapshot.data[index]);
                    },
                  );
                }
              });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (BuildContext context) {
                    return new PlayGameScreen();
                  },
                  fullscreenDialog: true));
        },
        icon: Icon(Icons.gamepad),
        label: Text("Start Game"),
      ),
    );
  }
}
