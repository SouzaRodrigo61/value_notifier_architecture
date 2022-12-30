// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../middleware/feedback_layout_config.dart';
import 'base_view.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage([Key? key, this.args]) : super(key: key);
  final Map<String, dynamic>? args;
}

abstract class BaseState<S extends StatefulWidget> extends State<S>
    with WidgetsBindingObserver
    implements BaseView {
  // late AppConfig appConfig;
  // late Logger logger;
  late bool stateControl;

  void Function(SnackBar snackBar)? onShowSnackBar;

  void Function(FeedbackLayoutConfig config)? onShowSnackError;

  void Function(FeedbackLayoutConfig config)? onShowSnackWarning;

  void Function(FeedbackLayoutConfig config)? onShowFeedbackScreen;

  @mustCallSuper
  void onResume() {}

  @mustCallSuper
  void onPause() {}

  /// Inicializado quando a route é configurada
  /// (No nativo é disparado assim que o flutter engine é iniciado)
  @mustCallSuper
  void onStart() {
    // appConfig = getIt();
    // logger = getIt();
  }

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @mustCallSuper
  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @mustCallSuper
  @override
  void didChangeDependencies() {
    onStart();
    super.didChangeDependencies();
  }

  @override
  Future<bool> didPopRoute() {
    // logger.v("life cycle did pop route");
    return super.didPopRoute();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // logger.v("life cycle status: " + state.toString());
    if (state == AppLifecycleState.paused) {
      onPause();
    } else if (state == AppLifecycleState.resumed) {
      onResume();
    }
  }

  @override
  void showFeedbackScreen(FeedbackLayoutConfig config) {
    onShowFeedbackScreen?.call(config);
  }

  @override
  void showSnackbarError(FeedbackLayoutConfig config) {
    onShowSnackError?.call(config);
  }

  @override
  void showSnackbarWarning(FeedbackLayoutConfig config) {
    onShowSnackWarning?.call(config);
  }

  @override
  void showSnackBar(SnackBar snackBar) {
    onShowSnackBar?.call(snackBar);
  }
}
