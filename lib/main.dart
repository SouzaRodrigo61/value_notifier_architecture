import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'app/app_widget.dart';
import 'core/di/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const CoreModule(true).init();

  bool result = await InternetConnectionChecker().hasConnection;

  runApp(
    MyApp(isoffline: result),
  );
}
