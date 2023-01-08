import 'package:flutter/material.dart';

import '../../../../../core/shared/notifier/valuenotifier_delegate.dart';
import '../../../../../design/views/error_page.dart';
import '../../controller/state/home_state.dart';

class HomeError extends ValueNotifierDelegateWidget<ErrorHomeState> {
  HomeError({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorPage(
      config: ErrorConfig(
        title: "Apresentação do erro",
        message: datasource.error,
      ),
      actionHandler: () {},
    );
  }
}
