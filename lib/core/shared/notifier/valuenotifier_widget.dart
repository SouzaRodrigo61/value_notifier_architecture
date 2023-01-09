import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'valuenotifier_delegate.dart';

//
// TitleValueNotifierWidget
//
/// description: Value Notifier widget e um wrapper para separação em diversas
/// camadas para separar o fluxo em Sucesso, error, loading e empty page.
///
/// Esse wrapper tambem trabalhar com o fluxo do delegate para devolver o valor
/// do children para o parent.
///
/// Esse Delegate do widget e semelhante ao fluxo do que acontece no iOS
/// utilizando o conceito do datasource.
///

class ValueNotifierWidget<T, Success, Error, Loading> extends StatelessWidget {
  const ValueNotifierWidget({
    Key? key,
    required ValueListenable<T> store,
    required ValueNotifierDelegateWidget<Success> success,
    ValueNotifierDelegateWidget<Error>? error,
    ValueNotifierDelegateWidget<Loading>? loading,
    ValueNotifierDelegateWidget? shimmer,
  })  : _store = store,
        _success = success,
        _error = error,
        _loading = loading,
        _shimmer = shimmer,
        super(key: key);

  final ValueListenable<T> _store;
  final ValueNotifierDelegateWidget<Success> _success;
  final ValueNotifierDelegateWidget<Error>? _error;
  final ValueNotifierDelegateWidget<Loading>? _loading;
  final ValueNotifierDelegateWidget? _shimmer;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (context, T state, child) {
        if (state is Error && _error != null) {
          _error!.datasource = state;
          return _error!;
        }

        if (state is Loading && _loading != null) return _loading!;
        if (state is Success) {
          _success.datasource = state;
          return _success;
        }

        if (_shimmer != null) return _shimmer!;

        return Empty();
      },
    );
  }
}

class Empty extends ValueNotifierDelegateWidget {
  Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
