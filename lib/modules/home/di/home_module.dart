import '../../../core/di/core.dart';
import '../../../core/environment/env.dart';
import '../contract/home_contract.dart';
import '../domain/usecases/home_use_case.dart';
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
          () => HomeUseCasesImpl(
            getIt<Envronment>(),
          ),
        );

        getIt.registerLazySingleton<HomeStore>(
          () => HomeStoreImpl(
            getIt<HomeUseCases>(),
          ),
        );
      },
    );
  }

  static void popScope() {
    getIt.popScope();
  }
}
