import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../contract/home_view_contract.dart';
import '../../controller/state/home_state.dart';

class HomeTitleWidget extends StatelessWidget {
  const HomeTitleWidget({
    Key? key,
    required HomeStore store,
  })  : _store = store,
        super(key: key);

  final HomeStore _store;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (context, HomeState state, child) {
        return state is ErrorHomeState
            ? const Text("Error")
            : Text("welcome-text".i18n());
      },
    );
  }
}
