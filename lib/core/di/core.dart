import 'package:get_it/get_it.dart';
import 'package:value_notifier_architecture/core/environment/env.dart';

final getIt = GetIt.instance;

class CoreModule {
  final bool _debug;
  final Envronment _env;

  bool get debug => _debug;
  Envronment get env => _env;

  const CoreModule({
    required bool debug,
    required Envronment env,
  })  : _debug = debug,
        _env = env;

  void init() {
    getIt.registerLazySingleton<Envronment>(
      () => Envronment(_env.envronment),
    );
  }
}
