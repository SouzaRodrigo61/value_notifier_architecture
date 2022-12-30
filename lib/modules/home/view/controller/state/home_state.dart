abstract class HomeState {}

class StartHomeState extends HomeState {}

class SuccessHomeState extends HomeState {
  final String text;

  SuccessHomeState(this.text);
}

class ErrorHomeState extends HomeState {
  final String error;

  ErrorHomeState(this.error);
}

class LoadingHomeState extends HomeState {}
