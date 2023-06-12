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
            GridView.builder(
              itemCount: 20, // 그리드의 요소 개수
              padding: const EdgeInsets.all(Sizes.size8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 한 줄에 몇 개의 요소를 넣을 것인지
                crossAxisSpacing: Sizes.size10, // 요소 사이의 간격
                mainAxisSpacing: Sizes.size10, // 요소 사이의 간격
                childAspectRatio: 9 / 16, // 요소의 가로 세로 비율
              ), // gridDelegate: 그리드의 모양을 결정하는 위젯
              // delegate는 controller와는 좀 다르고, 약간 assistant 같은 거.
              itemBuilder: (context, index) => Container(
                color: Colors.teal,
                child: Center(
                  child: Text("$index"),
                ),
              ), // itemBuilder: 그리드의 각 요소를 만드는 위젯
            ),
            for (var tab in tabs.skip(1))
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
