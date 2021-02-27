import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/features/auth/view_model/auth_view_model.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    Key key,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var model = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0, left: 16, top: 16, bottom: 8),
              child: Text(
                'Account Info',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            ),
            Material(
              elevation: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Text(
                      "Name:",
                    ),
                    title: Text(
                      model.userModel.firstName +
                          " " +
                          model.userModel.lastName,
                    ),
                  ),
                ],
              ),
            ),
            Material(
              elevation: 2,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    leading: Text(
                      "Email:",
                    ),
                    title: Text(
                      model.userModel.email,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity),
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'Signout',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  textColor: Colors.white,
                  splashColor: Theme.of(context).primaryColor,
                  onPressed: () async =>
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signOut(context),
                  padding: EdgeInsets.only(top: 12, bottom: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      side: BorderSide(color: Theme.of(context).primaryColor)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 40.0, left: 40.0, top: 40),
              child: Center(
                child: Text(
                  "Version: " +
                      model.packageInfo.version +
                      " | Build: " +
                      model.packageInfo.buildNumber,
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
