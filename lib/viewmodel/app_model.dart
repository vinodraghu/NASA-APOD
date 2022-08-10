
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nasa_apod/helper/themepreferences.dart';
import 'package:nasa_apod/model/nasa_apod_model.dart';


class AppModel extends ChangeNotifier {
  bool? _isDark;
  ThemePreferences? _preferences;
  bool get isDark => _isDark ?? false;
  List<NasaApodModel> jsonResponseData = [];

  AppModel() {
    _isDark = false;
    _preferences = ThemePreferences();
    getPreferences();
    parseJsonFromAssets();
  }

  Future parseJsonFromAssets() async {
    var assetsPath = 'assets/json/data.json';
    print('--- Parse json from: $assetsPath');
    //setState(ViewState.Busy);

    await Future.delayed(const Duration(seconds: 2));
    final jsonData = await rootBundle
        .loadString(assetsPath)
        .then((jsonStr) =>json.decode(jsonStr));

    jsonResponseData = List<NasaApodModel>.from(jsonData.map((x) => NasaApodModel.fromJson(x)));

    print('data: ' + jsonResponseData.toString());
    notifyListeners();
  }
//Switching themes in the flutter apps - Flutterant
  set isDark(bool value) {
    _isDark = value;
    _preferences?.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences?.getTheme();
    notifyListeners();
  }
}