import 'package:result_dart/result_dart.dart';

import '../../../../core/environment/env.dart';
import '../../infra/service/home_service.dart';
import '../../contract/home_contract.dart';

class HomeUseCasesImpl extends HomeUseCases {
  HomeUseCasesImpl(super.env);

  @override
  AsyncResult<String, String> fetchProduct() async {
    switch (env.envronment) {
      case Env.live:
        return HomeService.live();
      default:
        return HomeService.mockSuccess();
    }
  }
}
