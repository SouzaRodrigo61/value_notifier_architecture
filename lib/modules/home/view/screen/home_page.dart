import 'package:flutter/material.dart';

import '../../../../core/di/core.dart';
import '../../../../core/layout/layout_page_scope.dart';
import '../../../../core/shared/view/base_page.dart';
import '../../../../core/shared/notifier/valuenotifier_widget.dart';
import '../../di/home_module.dart';
import '../contract/home_view_contract.dart';
import 'widget/home_error_widget.dart';
import 'widget/home_loading_widget.dart';
import 'widget/home_success_widget.dart';
import 'widget/home_title_widget.dart';

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
        success: HomeSuccess(),
        error: HomeError(),
        loading: HomeLoading(),
        emptyState: HomeLoading(),
      ),
    );
  }
}
