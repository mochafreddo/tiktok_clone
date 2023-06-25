import 'package:flutter/material.dart';

/// Returns true if the current theme mode of the app is dark mode.
bool isDarkMode(BuildContext context) =>
    MediaQuery.of(context).platformBrightness == Brightness.dark;
