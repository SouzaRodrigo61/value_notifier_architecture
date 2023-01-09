import 'package:result_dart/result_dart.dart';

import '../../../core/shared/contracts/core_contracts.dart';

abstract class HomeUseCases extends UseCase {
  HomeUseCases(super.env);

  AsyncResult<String, String> fetchProduct();
}
