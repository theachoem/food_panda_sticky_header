import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/helper/helper.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:food_panda_sticky_header/colors.dart';
import 'package:food_panda_sticky_header/example_data.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({
    Key? key,
    required this.scrollController,
    required this.tabController,
    required this.category,
    required this.index,
  }) : super(key: key);

  final AutoScrollController scrollController;
  final TabController tabController;
  final Category category;
  final int index;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ValueKey(index),
      onVisibilityChanged: (VisibilityInfo info) {
        if (tabController.indexIsChanging == true) return;
        if (info.visibleFraction == 1) tabController.animateTo(index);
      },
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: scrollController,
        child: buildSectionTile(context),
      ),
    );
  }

  Container buildSectionTile(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      margin: const EdgeInsets.only(bottom: 16),
      color: scheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  if (category.isHotSale)
                    Container(
                      margin: const EdgeInsets.only(right: 4.0),
                      child: Icon(
                        Icons.whatshot,
                        color: scheme.primary,
                        size: 20.0,
                      ),
                    ),
                  Text(
                    category.title,
                    style: textTheme.headline6,
                    strutStyle: Helper.buildStrutStyle(textTheme.headline6),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              if (category.subtitle != null)
                Text(
                  category.subtitle!,
                  style: textTheme.subtitle2,
                  strutStyle: Helper.buildStrutStyle(textTheme.subtitle2),
                ),
              const SizedBox(height: 16),
            ],
          ),
          Column(
            children: List.generate(
              category.foods.length,
              (index) {
                final food = category.foods[index];
                bool isLastIndex = index == category.foods.length - 1;
                return buildFoodTile(
                  food: food,
                  context: context,
                  isLastIndex: isLastIndex,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Column buildFoodTile({
    required Food food,
    required BuildContext context,
    required bool isLastIndex,
  }) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  food.name,
                  style: textTheme.subtitle1,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      "មកពី" + food.price + " ",
                      style: textTheme.caption,
                      strutStyle: Helper.buildStrutStyle(textTheme.caption),
                    ),
                    Text(
                      food.comparePrice,
                      strutStyle: Helper.buildStrutStyle(textTheme.caption),
                      style: textTheme.caption?.copyWith(
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    if (food.isHotSale)
                      Container(
                        padding: const EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: scheme.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Icon(
                          Icons.whatshot,
                          color: scheme.primary,
                          size: 16.0,
                        ),
                      ),
                  ],
                ),
              ],
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/transparent.png',
              image: food.imageUrl,
              width: 64,
            ),
          ],
        ),
        if (!isLastIndex) const Divider(height: 16.0) else const SizedBox(height: 8.0)
      ],
    );
  }
}
