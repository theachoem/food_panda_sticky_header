import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:food_panda_sticky_header/colors.dart';
import 'package:food_panda_sticky_header/example_data.dart';
import 'package:food_panda_sticky_header/widgets/widgets.dart';

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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: data.categories.length, vsync: this);
    scrollController = AutoScrollController();
    scrollController.addListener(_listener);
  }

  void _listener() {
    double reachCollapsed = expandedHeight - collapsedHeight - 48;
    if (tabController.indexIsChanging == true) return;
    if (scrollController.offset <= reachCollapsed) {
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
          buildAppBar(),
          buildBody(),
        ],
      ),
    );
  }

  buildAppBar() {
    return FAppBar(
      data: data,
      context: context,
      scrollController: scrollController,
      expandedHeight: expandedHeight,
      collapsedHeight: collapsedHeight,
      isCollapsed: isCollapsed,
      onCollapsed: onCollapsed,
      tabController: tabController,
    );
  }

  buildBody() {
    return SliverList(
      delegate: SliverChildListDelegate(
        List.generate(data.categories.length, (index) {
          final category = data.categories[index];
          return CategorySection(
            scrollController: scrollController,
            tabController: tabController,
            category: category,
            index: index,
          );
        }),
      ),
    );
  }
}
