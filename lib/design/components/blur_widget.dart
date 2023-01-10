import 'dart:ui';

import 'package:flutter/material.dart';

class BlurWidget extends StatelessWidget {
  const BlurWidget({
    Key? key,
    double sigmaX = 20,
    double sigmaY = 20,
    bool seeContent = true,
  })  : _sigmaX = sigmaX,
        _sigmaY = sigmaY,
        _seeContent = seeContent,
        super(key: key);

  final double _sigmaX;
  final double _sigmaY;
  final bool _seeContent;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _sigmaX, sigmaY: _sigmaY),
        child: _seeContent ? const SizedBox() : null,
      ),
    );
  }
}
