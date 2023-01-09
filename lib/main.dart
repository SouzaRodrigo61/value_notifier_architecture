import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:value_notifier_architecture/core/environment/env.dart';

import 'app/app_widget.dart';
import 'core/di/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  CoreModule(
    debug: true,
    env: Envronment(Env.mock),
  ).init();

  bool result = await InternetConnectionChecker().hasConnection;

  runApp(
    MyApp(isoffline: result),
  );
}
