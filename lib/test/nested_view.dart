import 'dart:math';

import 'package:flutter/material.dart';

/// https://stackoverflow.com/questions/54689594/flutter-tabsview-and-nestedscrollview-scroll-issue
///
class NewsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<String> listItems = [];

  final List<String> _tabs = <String>[
    "Featured",
    "Popular",
    "Latest",
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: DefaultTabController(
          length: _tabs.length, // This is the number of tabs.
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              // These are the slivers that show up in the "outer" scroll view.
              return <Widget>[
                SliverOverlapAbsorber(
                  // This widget takes the overlapping behavior of the SliverAppBar,
                  // and redirects it to the SliverOverlapInjector below. If it is
                  // missing, then it is possible for the nested "inner" scroll view
                  // below to end up under the SliverAppBar even when the inner
                  // scroll view thinks it has not been scrolled.
                  // This is not necessary if the "headerSliverBuilder" only builds
                  // widgets that do not overlap the next sliver.
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  sliver: SliverSafeArea(
                    top: false,
                    sliver: SliverAppBar(
                      title: const Text('Books'),
                      floating: true,
                      pinned: true,
                      snap: false,
                      primary: true,
                      forceElevated: innerBoxIsScrolled,
                      bottom: TabBar(
                        // These are the widgets to put in each tab in the tab bar.
                        tabs: _tabs
                            .map((String name) => Tab(text: name))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              // These are the contents of the tab views, below the tabs.
              children: _tabs.map((String name) {
                return _ListView(name: name);
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class _ListView extends StatelessWidget {
  final String name;

  _ListView({
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        print('$name');
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: 30,
        itemExtent: 60.0,
        itemBuilder: (context, index) {
          return Container(
            color: Color((Random().nextDouble() * 0xFFFFFF).toInt() << 0)
                .withOpacity(1.0),
          );
        },
      ),
    );
  }
}

class InnerView extends StatelessWidget {
  final String name;

  InnerView({
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        // This Builder is needed to provide a BuildContext that is "inside"
        // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
        // find the NestedScrollView.
        builder: (BuildContext context) {
          return CustomScrollView(
            // The "controller" and "primary" members should be left
            // unset, so that the NestedScrollView can control this
            // inner scroll view.
            // If the "controller" property is set, then this scroll
            // view will not be associated with the NestedScrollView.
            // The PageStorageKey should be unique to this ScrollView;
            // it allows the list to remember its scroll position when
            // the tab view is not on the screen.
            key: PageStorageKey<String>(name),
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber above.
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(8.0),
                // In this example, the inner scroll view has
                // fixed-height list items, hence the use of
                // SliverFixedExtentList. However, one could use any
                // sliver widget here, e.g. SliverList or SliverGrid.
                sliver: SliverFixedExtentList(
                  // The items in this example are fixed to 48 pixels
                  // high. This matches the Material Design spec for
                  // ListTile widgets.
                  itemExtent: 60.0,
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      // This builder is called for each child.
                      // In this example, we just number each list item.
                      return Container(
                          color: Color(
                                  (Random().nextDouble() * 0xFFFFFF).toInt() <<
                                      0)
                              .withOpacity(1.0));
                    },
                    // The childCount of the SliverChildBuilderDelegate
                    // specifies how many children this inner list
                    // has. In this example, each tab has a list of
                    // exactly 30 items, but this is arbitrary.
                    childCount: 30,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
