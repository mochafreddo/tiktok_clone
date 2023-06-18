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
      // CustomScrollView: 스크롤 가능한 위젯
      slivers: [
        // slivers 안에는 wedget을 그냥 갖다넣을 수 없다.
        // slivers를 그냥 '스크롤 가능한 구역'이라고 생각하면 된다.
        SliverAppBar(
          // snap: true,
          // floating: true,
          // pinned: true,
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
        const SliverToBoxAdapter(
          // SliverToBoxAdapter: 박스 위젯을 슬리버로 감싸는 위젯
          child: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.red,
                radius: 20,
              ),
            ],
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
        SliverPersistentHeader(
          // SliverPersistentHeader: 스크롤을 해도 사라지지 않는 헤더
          delegate: CustomDelegate(),
          // pinned: true,
          floating: true,
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

class CustomDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: Colors.indigo,
      child: const FractionallySizedBox(
        // FractionallySizedBox: 자식 위젯의 크기를 비율로 지정
        // 부모로부터 최대한 많은 공간을 차지
        heightFactor: 1, // heightFactor: 높이 비율
        child: Center(
          child: Text(
            "Title!!!!!",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 150;
  // maxExtent: 헤더의 최대 높이

  @override
  double get minExtent => 80;
  // minExtent: 헤더의 최소 높이

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    // shouldRebuild: 헤더를 다시 빌드해야 하는지 여부를 반환
    // true를 반환하면 헤더를 다시 빌드
    // false를 반환하면 헤더를 다시 빌드하지 않음
    return false;
  }
}
