import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/application.dart';
import 'core/locators.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  setupLocators();
  runApp(const Application());
}
