import 'package:result_dart/result_dart.dart';

import '../contract/home_domain_contract.dart';

class HomeUseCasesImpl with HomeUseCases {
  @override
  AsyncResult<String, String> fetchProduct() async {
    await Future.delayed(const Duration(seconds: 1));
    return const Success(
      "Working Clean Code with State pattern",
    );
  }
}
