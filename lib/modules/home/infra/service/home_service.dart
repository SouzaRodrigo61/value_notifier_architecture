import 'package:result_dart/result_dart.dart';

mixin HomeService {
  static AsyncResult<String, String> live() async {
    return const Success("success");
  }

  static AsyncResult<String, String> mockFailure() async {
    await Future.delayed(const Duration(seconds: 1));
    return const Failure(
      "Failure, witness abstract class pattern",
    );
  }

  static AsyncResult<String, String> mockSuccess() async {
    await Future.delayed(const Duration(seconds: 1));
    return const Success(
      "Success, witness abstract class pattern",
    );
  }
}
