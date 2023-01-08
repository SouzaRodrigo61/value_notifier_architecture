import 'package:flutter/material.dart';

import '../../core/layout/layout_page_feedback.dart';
import '../../core/middleware/feedback_layout_config.dart';

class ErrorConfig {
  late String title;
  late String message;
  late String actionText;

  ErrorConfig({
    this.title = "Erro",
    this.message = "Erro no generico",
    this.actionText = "Fechar",
  });
}

class ErrorPage extends StatelessWidget {
  final VoidCallback actionHandler;
  final ErrorConfig config;

  const ErrorPage({
    Key? key,
    required this.actionHandler,
    required this.config,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutPageFeedback(
      config: FeedbackLayoutConfig(
        title: config.title,
        message: config.message,
        primaryButton: Button(
          text: config.actionText,
          action: actionHandler,
        ),
        shouldPop: true,
        type: FeedbackType.error,
      ),
      onPop: () {},
    );
  }
}
