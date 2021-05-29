import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/colors.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 16.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 20,
      ),
      decoration: BoxDecoration(
        color: scheme.primary,
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            scheme.primary.withOpacity(0.08),
            BlendMode.dstATop,
          ),
          image: AssetImage('assets/images/pattern.png'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: textTheme.subtitle1
                ?.copyWith(color: scheme.surface, fontWeight: FontWeight.w600),
          ),
          Text(
            subtitle,
            style: textTheme.bodyText2?.copyWith(
              color: scheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}
