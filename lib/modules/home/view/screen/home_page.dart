import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:rive/rive.dart';
import 'package:value_notifier_architecture/design/theme/media_query.dart';

import '../../../../core/di/core.dart';
import '../../../../core/layout/layout_page_scope.dart';
import '../../../../core/shared/view/base_page.dart';
import '../../../../design/components/animated_button.dart';
import '../../../../design/components/blur_widget.dart';
import '../../di/home_module.dart';
import '../contract/home_view_contract.dart';
import 'widget/sign_in_dialog.dart';

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

  late StreamSubscription<bool> _keyboardSubscription;

  bool _keyboardVisibility = false;
  bool isShowSignInDialog = false;

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

    var keyboardVisibilityController = KeyboardVisibilityController();

    _keyboardSubscription = keyboardVisibilityController.onChange.listen(
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
    _keyboardSubscription.cancel();
    _buttonAnimationController.dispose();
    _store.dispose();
    super.dispose();
  }

  tapStartCourse() {
    _buttonAnimationController.isActive = true;

    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        setState(() {
          isShowSignInDialog = true;
        });
        showCustomDialog(
          context,
          onValue: (_) {
            setState(() {
              isShowSignInDialog = false;
            });
          },
        );
      },
    );
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
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            duration: const Duration(milliseconds: 260),
            child: SafeArea(
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
