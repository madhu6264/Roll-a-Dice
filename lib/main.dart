import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roll_a_dice/features/auth/view/login_screen.dart';
import 'package:roll_a_dice/features/auth/view/sign_up_screen.dart';
import 'package:roll_a_dice/utils/flavors_config.dart';

import 'features/auth/view_model/auth_view_model.dart';
import 'features/home/view/home_screen.dart';
import 'features/home/view_model/leader_board_viewmodel.dart';
import 'features/settings/view/settings_screen.dart';
import 'features/splash/view/splash_screen.dart';

Future<void> main() async {
  Constants.setEnvironment(Environment.PROD);

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => LeaderBoardViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Constants.THEME,
        routes: {
          '/': (context) => SplashScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUpScreen(),
          '/home': (context) => HomeScreen(),
          '/settings': (context) => SettingsScreen()
        },
      ),
    ),
  );
}
