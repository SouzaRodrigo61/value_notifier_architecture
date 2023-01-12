import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'sign_in_form.dart';

bool keyboardIsVisible(BuildContext context) {
  return !(MediaQuery.of(context).viewInsets.bottom == 0.0);
}

void showCustomDialog(BuildContext context, {required ValueChanged onValue}) {
  showGeneralDialog(
    context: context,
    barrierLabel: "Barrier",
    barrierDismissible: true,
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, __, ___) {
      return const SignIn();
    },
    transitionBuilder: (_, anim, __, child) {
      Tween<Offset> tween;
      if (anim.status == AnimationStatus.reverse) {
        tween = Tween(begin: const Offset(0, 1), end: Offset.zero);
      } else {
        tween = Tween(begin: const Offset(0, -1), end: Offset.zero);
      }

      return SlideTransition(
        position: tween.animate(
          CurvedAnimation(parent: anim, curve: Curves.easeInOut),
        ),
        child: FadeTransition(
          opacity: anim,
          child: child,
        ),
      );
    },
  ).then(onValue);
}

class SignIn extends StatefulWidget {
  const SignIn({
    Key? key,
  }) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  late StreamSubscription<bool> keyboardSubscription;
  bool _keyboardVisibility = false;

  @override
  void initState() {
    super.initState();

    var keyboardVisibilityController = KeyboardVisibilityController();

    keyboardSubscription = keyboardVisibilityController.onChange.listen(
      (bool visible) {
        Future.delayed(
          Duration(milliseconds: _keyboardVisibility ? 300 : 0),
          () => setState(() => _keyboardVisibility = visible),
        );
      },
    );
  }

  @override
  void dispose() {
    keyboardSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 16,
        right: 16,
        top: _keyboardVisibility ? 60 : 100,
        bottom: _keyboardVisibility ? 0 : 150,
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            offset: const Offset(0, 30),
            blurRadius: 60,
          ),
          const BoxShadow(
            color: Colors.black45,
            offset: Offset(0, 30),
            blurRadius: 60,
          ),
        ],
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              children: [
                const Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: 34,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    "Access to 240+ hours of content. Learn design and code, by building real apps with Flutter and Swift.",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SignInForm(),
                AnimatedOpacity(
                  opacity: _keyboardVisibility == false ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Visibility(
                    visible: _keyboardVisibility == false,
                    child: Row(
                      children: const [
                        Expanded(
                          child: Divider(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _keyboardVisibility == false ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Visibility(
                    visible: _keyboardVisibility == false,
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        "Sign up with Email, Apple or Google",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: _keyboardVisibility == false ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: Visibility(
                    visible: _keyboardVisibility == false,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            "assets/icons/email_box.svg",
                            height: 64,
                            width: 64,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            "assets/icons/apple_box.svg",
                            height: 64,
                            width: 64,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.zero,
                          icon: SvgPicture.asset(
                            "assets/icons/google_box.svg",
                            height: 64,
                            width: 64,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Visibility(
              visible: _keyboardVisibility == false,
              child: Positioned(
                left: 0,
                right: 0,
                bottom: -32,
                child: AnimatedOpacity(
                  opacity: _keyboardVisibility == false ? 1.0 : 0.0,
                  duration: const Duration(seconds: 1),
                  child: const CircleAvatar(
                    radius: 16,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
