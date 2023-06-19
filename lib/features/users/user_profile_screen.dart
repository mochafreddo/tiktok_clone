import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        // DefaultTabController: TabBar와 TabBarView를 연결해주는 위젯
        length: 2, // length: TabBar의 탭 개수
        child: NestedScrollView(
          // NestedScrollView: 스크롤이 가능한 위젯
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            // headerSliverBuilder: 스크롤이 가능한 위젯의 헤더를 만들어주는 함수
            return [
              SliverAppBar(
                title: const Text("목화"),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: const FaIcon(
                      FontAwesomeIcons.gear,
                      size: Sizes.size20,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      foregroundImage: NetworkImage(
                          "https://avatars.githubusercontent.com/u/76798197?v=4"),
                      child: Text("목화"),
                    ),
                    Gaps.v20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "@목화",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Sizes.size18,
                          ),
                        ),
                        Gaps.h5,
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          size: Sizes.size16,
                          color: Colors.blue.shade500,
                        )
                      ],
                    ),
                    Gaps.v24,
                    SizedBox(
                      height: Sizes.size48,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildCountText("37", "Following"),
                          _buildVerticalDivider(),
                          _buildCountText("10.5M", "Followers"),
                          _buildVerticalDivider(),
                          _buildCountText("149.3M", "Likes"),
                        ],
                      ),
                    ),
                    Gaps.v14,
                    FractionallySizedBox(
                      // FractionallySizedBox: father의 너비와 높이에 의존해서 너비와 높이를 가진다.
                      widthFactor: 0.33, // widthFactor: father의 너비에 대한 비율
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: Sizes.size12,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(Sizes.size4),
                          ),
                        ),
                        child: const Text(
                          "Follow",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Gaps.v14,
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Sizes.size32,
                      ),
                      child: Text(
                        "All highlights and where to watch live matches on FIFA+ I wonder how it would loook",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v14,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.link,
                          size: Sizes.size12,
                        ),
                        Gaps.h4,
                        Text(
                          "https://github.com/mochafreddo",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Gaps.v20,
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: PersistentTabBar(),
                pinned: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                itemCount: 20,
                padding: EdgeInsets.zero,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // crossAxisCount: 한 줄에 들어갈 아이템의 개수
                  crossAxisSpacing:
                      Sizes.size2, // crossAxisSpacing: 아이템들의 가로 간격
                  mainAxisSpacing: Sizes.size2, // mainAxisSpacing: 아이템들의 세로 간격
                  childAspectRatio: 9 / 14,
                ),
                itemBuilder: (context, index) => Column(
                  children: [
                    AspectRatio(
                      // AspectRatio: child의 가로 세로 비율을 설정할 수 있다.
                      aspectRatio: 9 / 14, // aspectRatio: 가로 세로 비율
                      child: FadeInImage.assetNetwork(
                          fit: BoxFit.cover,
                          placeholder: "assets/images/placeholder.jpg",
                          image:
                              "https://images.unsplash.com/photo-1685718069436-86dfcf717c9f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1764&q=80"),
                    ),
                  ],
                ),
              ),
              const Center(
                child: Text("Page two"),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountText(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return VerticalDivider(
      // VerticalDivider는 특정 높이를 가진 father를 필요로 한다.
      // VerticalDivider는 father의 높이를 가져다가 사용하기 때문.
      width: Sizes.size32,
      thickness: Sizes.size1, // thickness: 선의 두께
      indent: Sizes.size14, // indent: 시작점에서의 간격
      endIndent: Sizes.size14, // endIndent: 끝점에서의 간격
      color: Colors.grey.shade400,
    );
  }
}
