import 'package:flutter/material.dart';

class MapTheme {
  static String theme = '';
  Future loadTheme(BuildContext context) async {
    theme = await DefaultAssetBundle.of(context)
        .loadString('assets/json/google_map_theme.json');
  }
}
