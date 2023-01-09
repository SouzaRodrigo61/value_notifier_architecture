import '../../environment/env.dart';

abstract class UseCase {
  final Envronment env;

  UseCase(this.env);
}
