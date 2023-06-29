import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final FaIcon icon;
  final StatefulWidget target;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.target,
  });

  void _onTapFunction(BuildContext context) {
    /* Navigator.of(context).push(
      /* MaterialPageRoute(
        builder: (context) => target,
      ), */
      PageRouteBuilder(
        transitionDuration: const Duration(seconds: 1),
        reverseTransitionDuration: const Duration(seconds: 1),
        pageBuilder: (context, animation, secondaryAnimation) => target,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final offsetAnimation = Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation);
          final opacityAnimation = Tween(
            begin: 0.5,
            end: 1.0,
          ).animate(animation);
          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: opacityAnimation,
              child: child,
            ),
          );
        },
      ),
    ); */
    // Navigator.of(context).pushNamed(UsernameScreen.routeName);
    context.push(UsernameScreen.routeName);
    // context.go(UsernameScreen.routeName);
    // context.push('/users/lynn?show=likes');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapFunction(context),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(Sizes.size14),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontSize: Sizes.size16,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
