import 'package:flutter/material.dart';

mixin ValueNotifierDelegate<T> {
  late final T datasource;
}

abstract class ValueNotifierDelegateWidget<T> extends StatelessWidget
    with ValueNotifierDelegate<T> {
  ValueNotifierDelegateWidget({super.key});
}
