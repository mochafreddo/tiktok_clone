import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class PostVideoButton extends StatelessWidget {
  final bool isLongPress;

  const PostVideoButton({
    super.key,
    required this.isLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Positioned widget은 Stack 내부의 element를 위치시킨다.
        // Positioned들은 Stack 안에서 정해진 크기가 있어야 한다.
        // 기준점이 있어야 한다.
        Positioned(
          right: isLongPress ? 30 : 20,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isLongPress ? 40 : 30,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
          ),
        ),
        Positioned(
          left: isLongPress ? 30 : 20,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: isLongPress ? 40 : 30,
            width: 25,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isLongPress ? 40 : 30,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size12,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
              Sizes.size6,
            ),
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: Colors.black,
              size: isLongPress ? Sizes.size24 : Sizes.size16 + Sizes.size2,
            ),
          ),
        )
      ],
    );
  }
}
