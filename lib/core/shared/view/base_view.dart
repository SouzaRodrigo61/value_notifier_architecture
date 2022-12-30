import 'package:flutter/material.dart';

import '../../middleware/feedback_layout_config.dart';

abstract class BaseView {
  void showSnackBar(SnackBar snackBar) {}

  void showSnackbarError(FeedbackLayoutConfig config) {}

  void showSnackbarWarning(FeedbackLayoutConfig config) {}

  void showFeedbackScreen(FeedbackLayoutConfig config) {}
}
