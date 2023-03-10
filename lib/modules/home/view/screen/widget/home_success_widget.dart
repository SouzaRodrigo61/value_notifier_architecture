import 'package:flutter/material.dart';

import '../../../../../core/shared/notifier/valuenotifier_delegate.dart';
import '../../../../../design/theme/media_query.dart';
import '../../controller/state/home_state.dart';

class HomeSuccess extends ValueNotifierDelegateWidget<SuccessHomeState> {
  HomeSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    final size = sized(context);
    return SizedBox(
      width: size.width,
      height: size.height,
      child: SafeArea(
        child: Text(datasource.text),
      ),
    );
  }
}
