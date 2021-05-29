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
        splashColor: Colors.transparent,
        onPressed: () {},
        icon: Container(
          height: 48,
          width: 48,
          decoration: buildBoxDecoration(),
          child: Icon(
            iconData,
            color: scheme.primary,
            size: 20,
          ),
        ),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.circle,
      color: scheme.surface,
    );
  }
}
