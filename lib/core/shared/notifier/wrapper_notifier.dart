import 'package:flutter/material.dart';

abstract class WrapperState<T> extends ValueNotifier<T> {
  WrapperState(super.value);

  void emit(T state) {
    value = state;
  }
}
