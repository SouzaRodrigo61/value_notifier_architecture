import 'package:flutter/cupertino.dart';
import 'package:rive/rive.dart';

class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    Key? key,
    required RiveAnimationController buttonAnimationController,
    required this.press,
    required Widget child,
    String riveAsset = "assets/rive/button.riv",
    String text = "Start the course",
  })  : _buttonAnimationController = buttonAnimationController,
        _riveAsset = riveAsset,
        _content = child,
        super(key: key);

  final RiveAnimationController _buttonAnimationController;
  final VoidCallback press;
  final String _riveAsset;
  final Widget _content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: SizedBox(
        height: 64,
        width: 236,
        child: Stack(
          children: [
            RiveAnimation.asset(
              _riveAsset,
              controllers: [_buttonAnimationController],
            ),
            Positioned.fill(
              // But it's not center
              top: 8,
              child: _content,
            ),
          ],
        ),
      ),
    );
  }
}
