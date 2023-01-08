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
    required ValueNotifierDelegateWidget<Error> error,
    required ValueNotifierDelegateWidget<Loading> loading,
    required ValueNotifierDelegateWidget emptyState,
  })  : _store = store,
        _success = success,
        _error = error,
        _loading = loading,
        _emptyState = emptyState,
        super(key: key);

  final ValueListenable<T> _store;
  final ValueNotifierDelegateWidget<Success> _success;
  final ValueNotifierDelegateWidget<Error> _error;
  final ValueNotifierDelegateWidget<Loading> _loading;
  final ValueNotifierDelegateWidget _emptyState;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _store,
      builder: (context, T state, child) {
        if (state is Success) {
          _success.datasource = state;
          return _success;
        }
        if (state is Error) {
          _error.datasource = state;
          return _error;
        }
        if (state is Loading) {
          _loading.datasource = state;
          return _loading;
        }

        return _emptyState;
      },
    );
  }
}
