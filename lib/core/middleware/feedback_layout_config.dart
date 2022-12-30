import 'dart:core';

import 'package:flutter_svg/flutter_svg.dart';

import '../shared/utils/utilities.dart';

typedef VoidCallback = dynamic Function();

class FeedbackLayoutConfig {
  String? title;
  String? message;
  Button? primaryButton;
  Button? secondaryButton;
  Button? flatButton;
  bool actionVisible;
  FeedbackType type;
  bool shouldPop;

  FeedbackLayoutConfig(
      {this.message,
      this.title,
      this.primaryButton,
      this.secondaryButton,
      this.flatButton,
      this.type = FeedbackType.error,
      this.actionVisible = false,
      this.shouldPop = false});
}

class Button {
  String? text;
  VoidCallback? action;

  Button({
    this.text = "ResourceStrings.snackbar_button_try_again",
    this.action,
  });
}

enum FeedbackType {
  success,
  waiting,
  warning,
  error,
}

extension FeedbackTypeExtension on FeedbackType {
  SvgPicture get image {
    switch (this) {
      case FeedbackType.success:
        return SvgPicture.asset(
          getImageAssetPath("ic_fallback_success.svg"),
          width: 150,
        );
      case FeedbackType.waiting:
        return SvgPicture.asset(
          getImageAssetPath("ic_fallback_waiting.svg"),
          width: 150,
        );
      case FeedbackType.warning:
        return SvgPicture.asset(
          getImageAssetPath("ic_fallback_alert.svg"),
          width: 150,
        );
      case FeedbackType.error:
        return SvgPicture.asset(
          getImageAssetPath("ic_fallback_error.svg"),
          width: 150,
        );
    }
  }
}
