import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../../../../core/di/core.dart';
import '../../../../core/layout/layout_page_feedback.dart';
import '../../../../core/layout/layout_page_scope.dart';
import '../../../../core/middleware/feedback_layout_config.dart';
import '../../../../core/shared/view/base_page.dart';
import '../../di/home_module.dart';
import '../contract/home_view_contract.dart';
import '../controller/state/home_state.dart';

class MyHomePage extends BasePage {
  const MyHomePage(Key? key) : super(key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
  late HomeStore _store;

  _MyHomePageState() {
    if (getIt.currentScopeName != HomeModule.scopeName) {
      HomeModule.init();
    }

    _store = getIt();
  }

  @override
  void initState() {
    super.initState();
    _store.fetchData();
  }

  @override
  void dispose() {
    _store.dispose();
    super.dispose();
  }

  _closeApp() {}

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (context, HomeState state, child) {
        return LayoutPageScope(
          appBar: homeAppBar(state: state),
          body: LayoutBuilder(
            builder: (context, constraints) {
              switch (state.runtimeType) {
                case LoadingHomeState:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case SuccessHomeState:
                  final value = state as SuccessHomeState;
                  return Center(
                    child: Text(value.text),
                  );
                case ErrorHomeState:
                  return LayoutPageFeedback(
                    config: FeedbackLayoutConfig(
                      title: "Erro na Home",
                      message: "Erro no fluxo do estado da home",
                      primaryButton: Button(
                        text: "Fechar o app",
                        action: _closeApp,
                      ),
                      shouldPop: true,
                      type: FeedbackType.error,
                    ),
                    onPop: () {},
                  );
                default:
                  return const Text("Generic Page");
              }
            },
          ),
        );
      },
    );
  }

  AppBar? homeAppBar({required HomeState state}) {
    return state is ErrorHomeState
        ? null
        : AppBar(
            title: Text("welcome-text".i18n()),
          );
  }
}
