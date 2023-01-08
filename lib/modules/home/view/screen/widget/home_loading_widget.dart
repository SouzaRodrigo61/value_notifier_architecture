import 'package:flutter/material.dart';

import '../../../../../core/shared/notifier/valuenotifier_delegate.dart';
import '../../controller/state/home_state.dart';

class HomeLoading extends ValueNotifierDelegateWidget<LoadingHomeState> {
  HomeLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
