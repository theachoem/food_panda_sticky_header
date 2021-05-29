import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/colors.dart';

class FIconButton extends StatelessWidget {
  const FIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
  }) : super(key: key);

  final IconData iconData;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scheme.surface,
          ),
          child: Center(
            child: Icon(
              iconData,
              color: scheme.primary,
              size: 20,
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }
}
