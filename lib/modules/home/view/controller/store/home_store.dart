import 'package:result_dart/result_dart.dart';

import '../../../../../core/shared/notifier/wrapper_notifier.dart';

import '../../../contract/home_contract.dart';
import '../../contract/home_view_contract.dart';
import '../state/home_state.dart';

class HomeStoreImpl extends WrapperState<HomeState> with HomeStore {
  final HomeUseCases useCases;
  HomeStoreImpl(this.useCases) : super(StartHomeState());

  @override
  Future fetchData() async {
    emit(LoadingHomeState());
    await useCases
        .fetchProduct()
        .map(SuccessHomeState.new)
        .mapError(ErrorHomeState.new)
        .fold(emit, emit);
  }
}
