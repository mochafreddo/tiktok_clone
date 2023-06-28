import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  bool _isWriting = false;

  final ScrollController _scrollController = ScrollController();

  void _onClosePressed() {
    Navigator.of(context).pop(); // 현재 화면을 pop
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus(); // 키보드가 올라와 있으면 내려가게 한다.
    setState(() {
      _isWriting = false;
    }); // 키보드가 내려가면 _isWriting을 false로 바꾼다.
  }

  void _startWriting() {
    setState(() {
      _isWriting = true;
    }); // 키보드가 올라오면 _isWriting을 true로 바꾼다.
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = isDarkMode(context);

    return Container(
      height: size.height * 0.80, // 80%의 높이를 차지
      clipBehavior:
          Clip.hardEdge, // clipBehavior: child가 부모의 영역을 벗어나는 경우 어떻게 처리할지 정하는 속성
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.size14),
      ),
      child: Scaffold(
        backgroundColor: isDark ? null : Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: isDark ? null : Colors.grey.shade50,
          automaticallyImplyLeading: false,
          title: Text(
            S.of(context).commentTitle(987987, 987987),
          ),
          actions: [
            IconButton(
              onPressed: _onClosePressed,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller:
                    _scrollController, // 스크롤바를 사용하려면 ScrollController를 사용해야 한다.
                child: ListView.separated(
                  controller:
                      _scrollController, // 스크롤바를 사용하려면 ScrollController를 사용해야 한다.
                  padding: const EdgeInsets.only(
                    top: Sizes.size10,
                    bottom: Sizes.size96 + Sizes.size20,
                    left: Sizes.size16,
                    right: Sizes.size16,
                  ),
                  separatorBuilder: (context, index) => Gaps.v10,
                  itemCount: 20,
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: isDark ? Colors.grey.shade500 : null,
                        child: const Text("목화"),
                      ),
                      Gaps.h10,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Geoffrey",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Sizes.size14,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Gaps.v3,
                            const Text(
                                "This breathtaking artwork truly captures the essence of beauty and evokes a sense of awe.")
                          ],
                        ),
                      ),
                      Gaps.h10,
                      Column(
                        children: [
                          FaIcon(
                            FontAwesomeIcons.heart,
                            size: Sizes.size20,
                            color: Colors.grey.shade500,
                          ),
                          Gaps.v3,
                          Text(
                            "52.2K",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0, // BottomAppBar를 화면 하단에 고정
                width: size.width,
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.size16,
                      right: Sizes.size16,
                      top: Sizes.size10,
                      bottom: Sizes.size48,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey.shade500,
                          foregroundColor: Colors.white,
                          child: const Text("목화"),
                        ),
                        Gaps.h10,
                        Expanded(
                          child: SizedBox(
                            // TextField의 높이를 고정하기 위해 SizedBox로 감싸줌
                            height: Sizes.size44,
                            child: TextField(
                              onTap:
                                  _startWriting, // 텍스트 필드를 누르면 키보드가 올라오면서 _startWriting 함수가 실행됨
                              expands: true,
                              minLines: null, // 최소 줄 수
                              maxLines: null, // 최대 줄 수
                              textInputAction: TextInputAction
                                  .newline, // 키보드의 완료 버튼을 다음 줄로 바꿔줌
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Write a comment...",
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.circular(Sizes.size12),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: isDark
                                    ? Colors.grey.shade800
                                    : Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: Sizes.size12,
                                  horizontal: Sizes.size10,
                                ),
                                suffixIcon: Padding(
                                  padding: const EdgeInsets.only(
                                    right: Sizes.size14,
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.at,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: isDark
                                            ? Colors.grey.shade500
                                            : Colors.grey.shade900,
                                      ),
                                      Gaps.h14,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _stopWriting,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        // bottomNavigationBar: BottomAppBar()
        // bottomNavigationBar를 사용하면 키보드가 들어갈 때 bottomNavigationBar가 다시 나타남. (밑에서부터 슬라이스업)
        // 키보드가 나와있을 때 기본적으로 숨겨져 있음.
      ),
    );
  }
}
