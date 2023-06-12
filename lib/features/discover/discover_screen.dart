import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // DefaultTabController: TabBar와 TabBarView를 연결해주는 위젯
      length: tabs.length, // tab의 개수
      child: Scaffold(
        appBar: AppBar(
          elevation: 1,
          title: const Text('Discover'),
          // PreferredSizeWidget: 특정한 크기를 가지려고 하지만 자식요소의 크기를 제한(Constrain)하지 않는 위젯
          // "prefer": 위젯 자체는 특정한 사이즈를 가지려고 하지만 그 위젯 안의 자식요소가 부모요소의 사이즈 제한을 받지 않는다.
          // preferredsizewidget이 아니더라도 `PreferredSizeWidget(child: Container())`처럼 사용할 수는 있다.
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory, // 탭을 눌렀을 때 효과를 없애는 방법
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
            ),
            isScrollable: true,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: Sizes.size16,
            ),
            indicatorColor: Colors.black,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.grey.shade500,
            tabs: [
              for (var tab in tabs) Tab(text: tab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (var tab in tabs)
              Center(
                child: Text(
                  tab,
                  style: const TextStyle(fontSize: Sizes.size28),
                ),
              )
          ],
        ),
      ),
    );
  }
}
