import 'package:flutter/material.dart';

class Offline extends StatelessWidget {
  const Offline({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.red,
        padding: const EdgeInsets.all(10),
        child: const SafeArea(
          child: Text(
            "Device is Offline",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
