import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rive/rive.dart';
import 'package:value_notifier_architecture/design/theme/media_query.dart';

import '../../../../core/di/core.dart';
import '../../../../core/layout/layout_page_scope.dart';
import '../../../../core/shared/view/base_page.dart';
import '../../../../design/components/animated_button.dart';
import '../../../../design/components/blur_widget.dart';
import '../../di/home_module.dart';
import '../contract/home_view_contract.dart';

// import '../../../../core/shared/notifier/valuenotifier_widget.dart';
// import 'widget/home_error_widget.dart';
// import 'widget/home_loading_widget.dart';
// import 'widget/home_success_widget.dart';
// import 'widget/home_title_widget.dart';

class MyHomePage extends BasePage {
  const MyHomePage(Key? key) : super(key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<MyHomePage> {
  late HomeStore _store;
  late RiveAnimationController _buttonAnimationController;

  _MyHomePageState() {
    if (getIt.currentScopeName != HomeModule.scopeName) {
      HomeModule.init();
    }

    _store = getIt();
  }

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = OneShotAnimation("active", autoplay: false);
    _store.fetchData();
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    _store.dispose();
    super.dispose();
  }

  tapStartCourse() {
    _buttonAnimationController.isActive = true;
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 620,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
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
                      Row(
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
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 24),
                        child: Text(
                          "Sign up with Email, Apple or Google",
                          style: TextStyle(color: Colors.black54),
                        ),
                      ),
                      Row(
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
                    ],
                  ),
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: -48,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
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
    ).then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    final size = sized(context);
    return LayoutPageScope(
      body: Stack(
        children: [
          Positioned(
            left: 100,
            bottom: 200,
            width: size.width * 1.7,
            child: Image.asset(
              "assets/backgrounds/Spline.png",
            ),
          ),
          const BlurWidget(sigmaY: 10, seeContent: false),
          const RiveAnimation.asset(
            "assets/rive/shapes.riv",
          ),
          const BlurWidget(sigmaX: 30, sigmaY: 30),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: 260,
                    child: Column(
                      children: const [
                        Text(
                          "Learn design & code",
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: "Poppins",
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.",
                        ),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  AnimatedButton(
                    buttonAnimationController: _buttonAnimationController,
                    press: tapStartCourse,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(CupertinoIcons.arrow_right),
                        SizedBox(width: 8),
                        Text(
                          "Start the course",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Text(
                      "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "email",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SvgPicture.asset(
                    "assets/icons/email.svg",
                  ),
                ),
              ),
            ),
          ),
          const Text(
            "Password",
            style: TextStyle(
              color: Colors.black54,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 16),
            child: TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: SvgPicture.asset(
                    "assets/icons/password.svg",
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              elevation: 0,
              animationDuration: const Duration(milliseconds: 500),
              backgroundColor: const Color(0xFFF77D8E),
              minimumSize: const Size(double.infinity, 56),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                ),
              ),
            ),
            icon: const Icon(CupertinoIcons.arrow_right),
            label: const Text("Sign in"),
          ),
        ],
      ),
    );
  }
}

// ValueNotifierWidget(
//   store: _store,
//   success: HomeSuccess(),
//   error: HomeError(),
//   loading: HomeLoading(),
// ),
