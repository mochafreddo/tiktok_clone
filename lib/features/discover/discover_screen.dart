import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
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

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");

  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(
      vsync: this,
      length: tabs.length,
    );
    _tabController.addListener(_handleTabIndex);
    _tabController.animation!.addListener(_handleTabAnimation);
  }

  void _onSearchChanged(String value) {
    print("Searching form $value");
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  /// TabController의 index가 변경될 때마다 호출되는 함수
  void _handleTabIndex() {
    if (mounted) {
      setState(() {});
      if (_tabController.indexIsChanging) {
        FocusScope.of(context).unfocus(); // 키보드가 올라와있을 때 탭을 누르면 키보드가 내려가는 옵션
      }
    }
  }

  /// TabController의 애니메이션이 시작될 때마다 호출되는 함수
  void _handleTabAnimation() {
    if (mounted) {
      if (_tabController.animation!.status == AnimationStatus.forward) {
        FocusScope.of(context).unfocus(); // 키보드가 올라와있을 때 탭을 누르면 키보드가 내려가는 옵션
      }
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _tabController.removeListener(_handleTabIndex);
    _tabController.removeListener(_handleTabAnimation);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // DefaultTabController: TabBar와 TabBarView를 연결해주는 위젯
      length: tabs.length, // tab의 개수
      child: Scaffold(
        resizeToAvoidBottomInset: false, // 키보드가 올라오면 화면이 줄어드는 것을 방지
        appBar: AppBar(
          elevation: 1,
          title: CupertinoSearchTextField(
            controller: _textEditingController,
            onChanged: _onSearchChanged,
            onSubmitted: _onSearchSubmitted,
          ),

          /// AppBar의 bottom은 PreferredSizeWidget이다.
          /// PreferredSizeWidget: 특정한 크기를 가지려고 하지만 자식요소의 크기를 제한(Constrain)하지 않는 위젯
          /// "prefer": 위젯 자체는 특정한 사이즈를 가지려고 하지만 그 위젯 안의 자식요소가 부모요소의 사이즈 제한을 받지 않는다.
          /// preferredsizewidget이 아니더라도 `PreferredSizeWidget(child: Container())`처럼 사용할 수는 있다.
          bottom: TabBar(
            controller: _tabController,
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
          controller: _tabController,
          children: [
            GridView.builder(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              // 키보드가 올라와있을 때 스크롤을 하면 키보드가 내려가는 옵션
              itemCount: 20, // 그리드의 요소 개수
              padding: const EdgeInsets.all(Sizes.size8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                // 그리드의 모양을 결정하는 위젯
                crossAxisCount: 2, // 한 줄에 몇 개의 요소를 넣을 것인지
                crossAxisSpacing: Sizes.size10, // 요소 사이의 간격
                mainAxisSpacing: Sizes.size10, // 요소 사이의 간격
                childAspectRatio: 9 / 20, // 요소의 가로 세로 비율
              ), // gridDelegate: 그리드의 모양을 결정하는 위젯
              // delegate는 controller와는 좀 다르고, 약간 assistant 같은 거.
              itemBuilder: (context, index) => Column(
                children: [
                  Container(
                    clipBehavior: Clip.hardEdge,
                    // AspectRatio의 이미지가 부모요소의 영역을 벗어나면 Clip.hardEdge로 인해 이미지가 잘린다.
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Sizes.size4),
                    ),
                    child: AspectRatio(
                      // AspectRatio: 자식요소의 가로 세로 비율을 정해주는 위젯
                      aspectRatio: 9 / 16, // 가로 세로 비율
                      child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover, // 이미지가 화면에 꽉 차도록
                          placeholder:
                              "assets/images/placeholder.jpg", // 이미지가 로딩되기 전에 보여줄 이미지
                          image:
                              "https://images.unsplash.com/photo-1685718069436-86dfcf717c9f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1764&q=80"),
                    ),
                  ),
                  Gaps.v10,
                  const Text(
                    "This is a very long caption for my tiktok that im upload just now currently",
                    overflow: TextOverflow.ellipsis, // 글자가 너무 길면 ...으로 표시
                    maxLines: 2, // 최대 줄 수
                    style: TextStyle(
                      fontSize: Sizes.size16 + Sizes.size2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gaps.v8,
                  DefaultTextStyle(
                    // DefaultTextStyle: 자식요소의 텍스트 스타일을 정해주는 위젯
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w600,
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 12,
                          backgroundImage: NetworkImage(
                              "https://avatars.githubusercontent.com/u/76798197?v=4"),
                        ),
                        Gaps.h4,
                        const Expanded(
                          child: Text(
                            "My avatar is going to be very long",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Gaps.h4,
                        FaIcon(
                          FontAwesomeIcons.heart,
                          size: Sizes.size16,
                          color: Colors.grey.shade600,
                        ),
                        Gaps.h2,
                        const Text(
                          "2.5M",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
