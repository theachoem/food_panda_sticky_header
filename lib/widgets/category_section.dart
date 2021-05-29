import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/helper/helper.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:food_panda_sticky_header/colors.dart';
import 'package:food_panda_sticky_header/example_data.dart';

class CategorySectionWidget extends StatelessWidget {
  const CategorySectionWidget({
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
    var textTheme = Theme.of(context).textTheme;
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
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          margin: const EdgeInsets.only(bottom: 16),
          color: scheme.surface,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                category.title,
                style: textTheme.headline6,
                strutStyle: Helper.buildStrutStyle(textTheme.headline6),
              ),
              const SizedBox(height: 8.0),
              if (category.subtitle != null)
                Text(
                  category.subtitle!,
                  style: textTheme.subtitle2,
                  strutStyle: Helper.buildStrutStyle(textTheme.subtitle2),
                ),
              const SizedBox(height: 16),
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
        ),
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
                  ],
                ),
              ],
            ),
            FadeInImage.assetNetwork(
              placeholder: "",
              image: food.imageUrl,
              width: 64,
            ),
          ],
        ),
        if (!isLastIndex)
          const Divider(height: 16.0)
        else
          const SizedBox(height: 8.0)
      ],
    );
  }
}
