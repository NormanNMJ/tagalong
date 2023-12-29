// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../../reusable_widgets/cache_Image.dart';
import '../../../../reusable_widgets/fab.dart';
import '../../../../reusable_widgets/page_navigator.dart';
import 'tabs/followings.dart';
import 'tabs/moments.dart';
import 'tabs/qoutes.dart';
import 'trendSearchScreen.dart';

class TrendScreen extends StatefulWidget {
  const TrendScreen({super.key});

  @override
  _TrendScreenState createState() => _TrendScreenState();
}

class _TrendScreenState extends State<TrendScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: const CustomFloatingActionButton(),
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                // Open drawer
                Scaffold.of(context).openDrawer();
              },
              child: const CachedImage(
                imageUrl:
                    'https://images.pexels.com/photos/773371/pexels-photo-773371.jpeg?auto=compress&cs=tinysrgb&w=600',
                backgroundColor: Colors.transparent,
                radius: 15,
              ),
            ),
          ),
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Trends',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .apply(color: Theme.of(context).colorScheme.onBackground),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                PageNavigator.navigateToNextPage(
                    context, const TrendSearchScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.trending_up_outlined,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              // ignore: prefer_const_literals_to_create_immutables
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.secondaryContainer),
                  child: TabBar(
                    padding: const EdgeInsets.all(3),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    labelColor: Theme.of(context).colorScheme.onBackground,
                    unselectedLabelColor:
                        Theme.of(context).colorScheme.onBackground,
                    tabs: const [
                      Tab(
                        text: 'Moment',
                      ),
                      Tab(
                        text: 'Qoutes',
                      ),
                      Tab(
                        text: 'Following',
                      ),
                    ],
                  ),
                ),
              ),
               Expanded(
                child: TabBarView(
                 // physics: NeverScrollableScrollPhysics(),
                  children: [
                  Moment(),
                  Qoutes(),
                  FollowingScreen(),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
