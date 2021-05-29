import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/colors.dart';

class PromoText extends StatelessWidget {
  const PromoText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 48,
        ),
        width: double.infinity,
        color: scheme.primary.withOpacity(0.1),
        child: Text(
          title,
          style: textTheme.bodyText1?.copyWith(color: scheme.primary),
        ),
      ),
    );
  }
}
