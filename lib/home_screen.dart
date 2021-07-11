import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:food_panda_sticky_header/colors.dart';
import 'package:food_panda_sticky_header/example_data.dart';
import 'package:food_panda_sticky_header/widgets/widgets.dart';
import 'package:rect_getter/rect_getter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool isCollapsed = false;
  late AutoScrollController scrollController;
  late TabController tabController;

  final double expandedHeight = 500.0;
  final PageData data = ExampleData.data;
  final double collapsedHeight = kToolbarHeight;

  final listViewKey = RectGetter.createGlobalKey();
  Map<int, dynamic> itemKeys = {};

  // prevent animate to tap on tab bar
  bool pauseRectGetterIndex = false;

  @override
  void initState() {
    tabController = TabController(length: data.categories.length, vsync: this);
    scrollController = AutoScrollController();
    super.initState();
    scrollController.addListener(_listener);
  }

  void _listener() {
    double reachCollapsed = expandedHeight - collapsedHeight - 48;
    if (tabController.indexIsChanging == true) return;
    if (scrollController.offset <= reachCollapsed) {
      tabController.animateTo(0);
    } else if (scrollController.offset >= scrollController.position.maxScrollExtent - 20) {
      tabController.animateTo(tabController.length - 1);
    } else {
      if (pauseRectGetterIndex) return;
      List<int> value = getVisibleItemsIndex();
      int sumIndex = value.reduce((value, element) => value + element);
      tabController.animateTo(sumIndex ~/ value.length);
    }
  }

  void onCollapsed(bool value) {
    if (this.isCollapsed == value) return;
    setState(() => this.isCollapsed = value);
  }

  @override
  void dispose() {
    scrollController.removeListener(_listener);
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: scheme.background,
      body: RectGetter(
        key: listViewKey,
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            buildAppBar(),
            buildBody(),
          ],
        ),
      ),
    );
  }

  List<int> getVisibleItemsIndex() {
    Rect? rect = RectGetter.getRectFromKey(listViewKey);
    List<int> items = [];
    if (rect == null) return items;
    itemKeys.forEach((index, key) {
      var itemRect = RectGetter.getRectFromKey(key);
      if (itemRect != null && !(itemRect.top > rect.bottom || itemRect.bottom < rect.top)) items.add(index);
    });
    return items;
  }

  SliverAppBar buildAppBar() {
    return FAppBar(
      data: data,
      context: context,
      scrollController: scrollController,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      isCollapsed: isCollapsed,
      onCollapsed: onCollapsed,
      tabController: tabController,
      onTap: (int index) {
        pauseRectGetterIndex = true;
        scrollController.scrollToIndex(index).then((value) => pauseRectGetterIndex = false);
      },
    );
  }

  SliverList buildBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(data.categories.length, (index) {
          itemKeys[index] = RectGetter.createGlobalKey();
          return buildCategoryItem(index);
        }),
      ),
    );
  }

  Widget buildCategoryItem(int index) {
    Category category = data.categories[index];
    return RectGetter(
      key: itemKeys[index],
      child: AutoScrollTag(
        key: ValueKey(index),
        index: index,
        controller: scrollController,
        child: CategorySection(category: category),
      ),
    );
  }
}
