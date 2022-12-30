import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../middleware/feedback_layout_config.dart';
import 'layout_page_feedback.dart';

class LayoutPageScope extends StatefulWidget {
  final AppBar? appBar;
  final Widget body;
  final Text? title;
  final Widget? bottomWidget;
  final WillPopCallback? onWillPop;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;

  const LayoutPageScope({
    super.key,
    required this.body,
    this.onBackPressed,
    this.onWillPop,
    this.title,
    this.appBar,
    this.backgroundColor,
    this.bottomWidget,
  });

  @override
  State<LayoutPageScope> createState() => _LayoutPageScopeState();
}

class _LayoutPageScopeState extends State<LayoutPageScope> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  get title => widget.title ?? const Text("Base Layout");

  get appBar => widget.appBar;

  get body => widget.body;

  FeedbackLayoutConfig config = FeedbackLayoutConfig();
  bool errorState = false;

  @override
  initState() {
    super.initState();
    // widget.state.onShowSnackError = (FeedbackLayoutConfig config) {
    //   _showSnackBarError(config);
    // };

    // widget.state.onShowSnackBar = (SnackBar snackBar) {
    //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // };

    // widget.state.onShowSnackWarning = (FeedbackLayoutConfig config) {
    //   // ScaffoldMessenger.of(context).showSnackBar(
    //   //   PBSnackWarning(config.message!,
    //   //       labelButton: config.primaryButton?.text,
    //   //       actionVisible: config.actionVisible,
    //   //       callback: config.primaryButton?.action),
    //   // );
    // };

    // widget.state.onShowFeedbackScreen = (FeedbackLayoutConfig config) {
    //   setState(() {
    //     this.config = config;
    //     errorState = true;
    //   });
    // };
  }

  void _showSnackBarError() {
    // ScaffoldMessenger.of(context).showSnackBar(
    //   PBSnackError(
    //     config.message!,
    //     labelButton: config.primaryButton?.text,
    //     actionVisible: config.actionVisible,
    //     callback: config.primaryButton?.action,
    //   ),
    // );
  }

  _hide() {
    setState(() {
      errorState = false;
    });
  }

  get onBackPressed =>
      widget.onBackPressed ??
      () {
        _pop();
      };

  get onWillPop =>
      widget.onWillPop ??
      () async {
        _pop();
        return false;
      };

  _pop() {
    SystemNavigator.pop();
  }

  _popScreen() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: appBar,
        backgroundColor: widget.backgroundColor ?? Colors.white,
        body: Stack(
          children: [
            Visibility(
              visible: errorState,
              replacement: body,
              child: LayoutPageFeedback(
                onPop: () {
                  config.shouldPop ? _popScreen() : _hide();
                },
                config: config,
              ),
            ),
          ],
        ),
        bottomNavigationBar: widget.bottomWidget,
      ),
    );
  }
}
