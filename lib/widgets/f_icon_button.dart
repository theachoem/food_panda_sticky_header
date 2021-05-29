import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/colors.dart';

class FIconButton extends StatelessWidget {
  const FIconButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.isCollapsed,
  }) : super(key: key);

  /// init `iconSize = 20`
  /// when isCollapsed iconSize will be scaled to 24
  final bool isCollapsed;

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
          child: Center(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              alignment: Alignment.center,
              transformAlignment: Alignment.center,
              transform: Matrix4.identity()..scale(isCollapsed ? 1.0 : 1.25),
              child: Icon(
                iconData,
                color: scheme.primary,
                size: 20,
              ),
            ),
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
