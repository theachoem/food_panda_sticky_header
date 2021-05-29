import 'package:flutter/material.dart';
import 'package:food_panda_sticky_header/example_data.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:food_panda_sticky_header/colors.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  late AutoScrollController scrollController;
  late TabController tabController;

  final double expandedHeight = 500.0;
  final PageData data = ExampleData.data;
  final double collapsedHeight = kToolbarHeight;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: data.categories.length, vsync: this);
    scrollController = AutoScrollController();
    scrollController.addListener(_listener);
  }

  void _listener() {
    double reachCollapsed = expandedHeight - collapsedHeight - 48;
    if (scrollController.offset <= reachCollapsed) {
      if (tabController.indexIsChanging == true) return;
      tabController.animateTo(0);
    }
  }

  void onCollapsed(bool value) {
    if (this.isCollapsed == value) return;
    setState(() => this.isCollapsed = value);
  }

  @override
  void dispose() {
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: scheme.background,
      body: CustomScrollView(
        controller: scrollController,
        slivers: [
          FAppBar(
            data: data,
            context: context,
            scrollController: scrollController,
            expandedHeight: expandedHeight,
            collapsedHeight: collapsedHeight,
            isCollapsed: isCollapsed,
            onCollapsed: onCollapsed,
            tabController: tabController,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                data.categories.length,
                (index) {
                  final category = data.categories[index];
                  return CategorySectionWidget(
                    scrollController: scrollController,
                    tabController: tabController,
                    category: category,
                    index: index,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FAppBar extends SliverAppBar {
  final PageData data;
  final BuildContext context;
  final bool isCollapsed;
  final double expandedHeight;
  final double collapsedHeight;
  final AutoScrollController scrollController;
  final TabController tabController;
  final void Function(bool isCollapsed) onCollapsed;

  FAppBar({
    required this.data,
    required this.context,
    required this.isCollapsed,
    required this.expandedHeight,
    required this.collapsedHeight,
    required this.scrollController,
    required this.onCollapsed,
    required this.tabController,
  }) : super(elevation: 4.0, pinned: true, forceElevated: true);

  @override
  Color? get backgroundColor => scheme.surface;

  @override
  Widget? get leading {
    return FIconButton(iconData: Icons.arrow_back, onPressed: () {});
  }

  @override
  List<Widget>? get actions {
    return [
      FIconButton(iconData: Icons.share_outlined, onPressed: () {}),
      FIconButton(iconData: Icons.info_outline, onPressed: () {}),
    ];
  }

  @override
  Widget? get title {
    var textTheme = Theme.of(context).textTheme;
    return AnimatedOpacity(
      opacity: this.isCollapsed ? 0 : 1,
      duration: const Duration(milliseconds: 250),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "ដឺកជញ្ជូន",
            style: textTheme.subtitle1?.copyWith(color: scheme.onSurface),
          ),
          Text(
            data.deliverTime,
            style: textTheme.caption?.copyWith(
              color: scheme.primary,
              height: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  @override
  PreferredSizeWidget? get bottom {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: Container(
        color: scheme.surface,
        child: TabBar(
          isScrollable: true,
          controller: tabController,
          indicatorPadding: const EdgeInsets.symmetric(horizontal: 16.0),
          indicatorColor: scheme.primary,
          labelColor: scheme.primary,
          unselectedLabelColor: scheme.onSurface,
          indicatorWeight: 3.0,
          tabs: data.categories.map((e) {
            return Tab(text: e.title);
          }).toList(),
          onTap: (int index) {
            scrollController.scrollToIndex(index);
          },
        ),
      ),
    );
  }

  @override
  Widget? get flexibleSpace {
    return LayoutBuilder(
      builder: (
        BuildContext context,
        BoxConstraints constraints,
      ) {
        final top = constraints.constrainHeight();
        final collapsedHight =
            MediaQuery.of(context).viewPadding.top + kToolbarHeight + 48;
        WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
          onCollapsed(collapsedHight != top);
        });

        return FlexibleSpaceBar(
          collapseMode: CollapseMode.pin,
          background: Column(
            children: [
              Stack(
                children: [
                  PromoText(title: data.bannerText),
                  const PandaHead(),
                  Column(
                    children: [
                      HeaderClip(data: data, context: context),
                      const SizedBox(height: 110),
                    ],
                  ),
                ],
              ),
              DiscountCard(
                title: data.optionalCard.title,
                subtitle: data.optionalCard.subtitle,
              ),
            ],
          ),
        );
      },
    );
  }
}

class PandaHead extends StatelessWidget {
  const PandaHead({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -19,
      right: 0.0,
      child: Image.network(
        'https://gtswiki.gt-beginners.net/decal/png/16/52/35/7278450332114355216_1.png',
        width: 150,
        height: 72,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

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
              ),
              if (category.subtitle != null)
                Text(
                  category.subtitle!,
                  style: textTheme.subtitle2?.copyWith(height: 1),
                ),
              const SizedBox(height: 16),
              Column(
                children: List.generate(
                  category.foods.length,
                  (index) {
                    final food = category.foods[index];
                    bool isLastIndex = index == category.foods.length - 1;
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
                                      "មកពី" + food.price,
                                      style: textTheme.caption,
                                    ),
                                    Text(
                                      food.comparePrice,
                                      style: textTheme.caption?.copyWith(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Image.network(
                              food.imageUrl,
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
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

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
            child: Image.network(
              data.backgroundUrl,
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
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: scheme.surface),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      "ដឹកជញ្ឌូន: " + data.deliverTime,
                      style: textTheme.caption?.copyWith(color: scheme.surface),
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

class CustomShape extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    double height = size.height;
    double width = size.width;
    var path = Path();
    path.lineTo(0, height - 30);
    path.quadraticBezierTo(width / 2, height, width, height - 30);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) => true;
}

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
