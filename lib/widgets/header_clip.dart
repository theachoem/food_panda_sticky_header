import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/widgets/widgets.dart';
import 'package:food_panda_sticky_header/colors.dart';
import 'package:food_panda_sticky_header/example_data.dart';

class HeaderClip extends StatelessWidget {
  const HeaderClip({
    Key? key,
    required this.data,
    required this.context,
  }) : super(key: key);

  final PageData data;
  final BuildContext context;

  @override
  Widget build(BuildContext _) {
    final textTheme = Theme.of(context).textTheme;
    return ClipPath(
      clipper: CustomShape(),
      child: Stack(
        children: [
          Container(
            height: 275,
            color: scheme.primary,
            child: FadeInImage.assetNetwork(
              placeholder: "",
              image: data.backgroundUrl,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            height: 275,
            color: scheme.secondary.withOpacity(0.7),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + kToolbarHeight,
            ),
            child: Column(
              children: [
                Text(
                  data.title,
                  style: textTheme.headline5?.copyWith(
                    color: scheme.surface,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4.0,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: scheme.surface),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "ដឹកជញ្ឌូន: " + data.deliverTime,
                      style: textTheme.caption?.copyWith(color: scheme.surface),
                      strutStyle: StrutStyle(forceStrutHeight: true),
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: scheme.surface,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      data.rate.toString(),
                      style: textTheme.caption?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.surface,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      "(" + data.rateQuantity.toString() + ")",
                      style: textTheme.caption?.copyWith(
                        color: scheme.surface,
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
