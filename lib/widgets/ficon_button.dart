import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/colors.dart';
import 'package:food_panda_sticky_header/widgets/ftap_effect.dart';

class FIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final double size;
  final Color? iconColor;
  final EdgeInsets padding;
  final String? tooltip;
  final Color? backgroundColor;

  const FIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.onLongPress,
    this.size = 20,
    this.iconColor,
    this.padding = const EdgeInsets.all(8),
    this.tooltip,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget icon = IconTheme.merge(
      data: IconThemeData(color: iconColor ?? Theme.of(context).colorScheme.primary, size: size),
      child: this.icon,
    );

    Widget button = Material(
      type: backgroundColor == null ? MaterialType.transparency : MaterialType.circle,
      color: backgroundColor,
      child: buildPlatformWrapper(
        context: context,
        child: icon,
      ),
    );

    if (tooltip != null) {
      button = Tooltip(
        message: tooltip ?? '',
        child: button,
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      child: button,
    );
  }

  Widget buildPlatformWrapper({
    required Widget child,
    required BuildContext context,
  }) {
    switch (Theme.of(context).platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return InkWell(
          customBorder: const CircleBorder(),
          onTap: onPressed,
          onLongPress: onLongPress,
          child: Padding(
            padding: padding,
            child: child,
          ),
        );
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
        return FTapEffect(
          onTap: onPressed,
          onLongPressed: onLongPress,
          child: Padding(
            padding: padding,
            child: child,
          ),
        );
    }
  }
}
