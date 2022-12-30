import 'package:value_notifier_architecture/modules/home/domain/usecases/home_use_case.dart';

import '../../../core/di/core.dart';
import '../domain/contract/home_domain_contract.dart';
import '../view/contract/home_view_contract.dart';
import '../view/controller/store/home_store.dart';

class HomeModule {
  HomeModule._();

  static const String scopeName = 'HomeModule';

  static void init() {
    getIt.pushNewScope(
      scopeName: scopeName,
      init: (getIt) {
        getIt.registerLazySingleton<HomeUseCases>(
          () => HomeUseCasesImpl(),
        );

        getIt.registerLazySingleton<HomeStore>(
          () => HomeStoreImpl(getIt()),
        );
      },
    );
  }

  static void popScope() {
    getIt.popScope();
  }
}
