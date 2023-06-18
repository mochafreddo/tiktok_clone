import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          // snap: true,
          // floating: true,
          pinned: true,
          stretch: true,
          backgroundColor: Colors.teal,
          collapsedHeight: 80,
          expandedHeight: 200,
          flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.blurBackground,
              StretchMode.zoomBackground,
              StretchMode.fadeTitle
            ],
            background: Image.asset(
              "assets/images/placeholder.jpg",
              fit: BoxFit.cover,
            ),
            title: const Text("Hello!"),
          ),
        ),
        SliverFixedExtentList(
          // SliverFixedExtentList: 고정된 크기의 리스트
          delegate: SliverChildBuilderDelegate(
            // SliverChildBuilderDelegate: 리스트 아이템을 생성하는 델리게이트
            childCount: 50, // 아이템 개수
            (context, index) => Container(
              color: Colors.amber[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          itemExtent: 100, // 높이
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            // SliverChildBuilderDelegate: 그리드 아이템을 생성하는 델리게이트
            childCount: 50, // childCount: 아이템 개수
            (context, index) => Container(
              color: Colors.blue[100 * (index % 9)],
              child: Align(
                alignment: Alignment.center,
                child: Text("Item $index"),
              ),
            ),
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            // SliverGridDelegateWithMaxCrossAxisExtent: 가로 방향으로 최대 크기를 가진 그리드
            maxCrossAxisExtent: 100, // maxCrossAxisExtent: 그리드의 최대 크기
            mainAxisSpacing: Sizes.size20,
            crossAxisSpacing: Sizes.size20,
            childAspectRatio: 1, // childAspectRatio: 그리드의 가로 세로 비율
          ),
        )
      ],
    );
  }
}
