import '../../../../core/shared/notifier/wrapper_notifier.dart';
import '../controller/state/home_state.dart';

mixin HomeStore on WrapperState<HomeState> {
  Future fetchData();
}
