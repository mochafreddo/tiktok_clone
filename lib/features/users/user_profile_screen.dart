import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';
import 'package:tiktok_clone/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends StatefulWidget {
  final String username;

  const UserProfileScreen({
    super.key,
    required this.username,
  });

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      body: SafeArea(
        child: DefaultTabController(
          // DefaultTabController: TabBar와 TabBarView를 연결해주는 위젯
          length: 2, // length: TabBar의 탭 개수
          child: NestedScrollView(
            // NestedScrollView: 스크롤이 가능한 위젯
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              // headerSliverBuilder: 스크롤이 가능한 위젯의 헤더를 만들어주는 함수
              return [
                SliverAppBar(
                  title: Text(widget.username),
                  // backgroundColor: Colors.black,
                  actions: [
                    IconButton(
                      onPressed: _onGearPressed,
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
                      Gaps.v20,
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
                          Text(
                            "@${widget.username}",
                            style: const TextStyle(
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
                        height: Sizes.size52,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: Sizes.size96 + Sizes.size96,
                            height: Sizes.size48,
                            // padding: const EdgeInsets.symmetric(
                            //   vertical: Sizes.size12,
                            // ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Sizes.size3),
                              ),
                            ),
                            child: const Text(
                              "Follow",
                              style: TextStyle(
                                fontSize: Sizes.size16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Gaps.h4,
                          Container(
                            width: Sizes.size48,
                            height: Sizes.size48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Sizes.size3),
                              ),
                            ),
                            child: const FaIcon(FontAwesomeIcons.youtube),
                          ),
                          Gaps.h4,
                          Container(
                            width: Sizes.size48,
                            height: Sizes.size48,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Sizes.size3),
                              ),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.caretDown,
                              size: Sizes.size14,
                            ),
                          ),
                        ],
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
                  itemCount: 21,
                  padding: EdgeInsets.zero,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: Sizes.size2,
                    mainAxisSpacing: Sizes.size2,
                    childAspectRatio: 9 / 14,
                  ),
                  itemBuilder: (context, index) => Stack(
                    children: [
                      AspectRatio(
                        // AspectRatio: child의 가로 세로 비율을 설정할 수 있다.
                        aspectRatio: 9 / 14, // aspectRatio: 가로 세로 비율
                        child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/images/placeholder.jpg",
                            image:
                                "https://cdn.pixabay.com/photo/2023/06/12/01/22/lotus-8057438_1280.jpg"),
                      ),
                      const Positioned(
                        bottom: Sizes.size7,
                        left: Sizes.size7,
                        child: Row(
                          children: [
                            FaIcon(
                              FontAwesomeIcons.play,
                              size: Sizes.size12,
                              color: Colors.white,
                            ),
                            Gaps.h5,
                            Text(
                              "4.1M",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (index == 0)
                        Positioned(
                          top: Sizes.size7,
                          left: Sizes.size7,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(Sizes.size3),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: Sizes.size3,
                                horizontal: Sizes.size5,
                              ),
                              child: Text(
                                "Pinned",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Sizes.size10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
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
      ),
    );
  }

  Widget _buildCountText(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
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
