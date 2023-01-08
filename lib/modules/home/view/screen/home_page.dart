import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:value_notifier_architecture/design/theme/media_query.dart';

import '../../../../core/di/core.dart';
import '../../../../core/layout/layout_page_scope.dart';
import '../../../../core/shared/notifier/valuenotifier_delegate.dart';
import '../../../../core/shared/view/base_page.dart';
import '../../../../design/views/error_page.dart';
import '../../../../core/shared/notifier/valuenotifier_widget.dart';
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

  @override
  Widget build(BuildContext context) {
    return LayoutPageScope(
      appBar: AppBar(
        elevation: 0,
        title: HomeTitleWidget(store: _store),
      ),
      body: ValueNotifierWidget(
        store: _store,
        success: HomeSuccessFlow(),
        error: HomeErrorFlow(),
        loading: HomeLoadingFlow(),
        emptyState: HomeLoadingFlow(),
      ),
    );
  }
}

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

class HomeSuccessFlow extends ValueNotifierDelegateWidget<SuccessHomeState> {
  HomeSuccessFlow({super.key});

  @override
  Widget build(BuildContext context) {
    final size = sized(context);
    return Container(
      width: size.width,
      height: size.height,
      color: Colors.amber,
      child: Text(datasource.text),
    );
  }
}

class HomeErrorFlow extends ValueNotifierDelegateWidget<ErrorHomeState> {
  HomeErrorFlow({super.key});

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

class HomeLoadingFlow extends ValueNotifierDelegateWidget<LoadingHomeState> {
  HomeLoadingFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
