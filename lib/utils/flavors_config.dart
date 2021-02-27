import 'package:flutter/material.dart';

enum Environment { DEV, STAGING, PROD }

class Constants {
  static Map<String, dynamic> _config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        _config = _Config.devConfig;
        break;
      case Environment.STAGING:
        _config = _Config.stagingConfig;
        break;
      case Environment.PROD:
        _config = _Config.prodConfig;
        break;
    }
  }

  static get APP_NAME {
    return _config[_Config.APP_NAME];
  }

  static get THEME {
    return _config[_Config.THEME];
  }

  static get BADGE {
    return _config[_Config.BADGE];
  }
}

class _Config {
  static const APP_NAME = "APP_NAME";
  static const THEME = "THEME";
  static const BADGE = "BADGE";

  static Map<String, dynamic> devConfig = {
    APP_NAME: "Roll A Dice(DEV)",
    THEME: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    BADGE: "Dev",
  };

  static Map<String, dynamic> stagingConfig = {
    APP_NAME: "Roll A Dice(STAGING)",
    THEME: ThemeData(
      primarySwatch: Colors.red,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    BADGE: "Staging",
  };

  static Map<String, dynamic> prodConfig = {
    APP_NAME: "Roll A Dice",
    THEME: ThemeData(
      primarySwatch: Colors.green,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    BADGE: "prod"
  };
}
