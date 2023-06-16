import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero, // ListTile의 padding을 없애기 위해
          horizontalTitleGap: Sizes.size8, // 타이틀과 leading 사이의 간격
          leading: Stack(
            children: [
              const CircleAvatar(
                radius: Sizes.size24,
                foregroundImage: NetworkImage(
                    "https://avatars.githubusercontent.com/u/76798197?v=4"),
                child: Text("니꼬"),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: Sizes.size17,
                  height: Sizes.size17,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                    border: Border.all(
                      color: Colors.white,
                      width: Sizes.size3,
                    ),
                  ),
                ),
              ),
            ],
          ),
          title: const Text(
            "니꼬",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: const Text("Active now"),
          trailing: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h32,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              )
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              vertical: Sizes.size20,
              horizontal: Sizes.size14,
            ),
            itemBuilder: (context, index) {
              final isMine = index % 2 == 0; // fake
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(Sizes.size14),
                    decoration: BoxDecoration(
                      color:
                          isMine ? Colors.blue : Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(Sizes.size20),
                        topRight: const Radius.circular(Sizes.size20),
                        bottomLeft: isMine
                            ? const Radius.circular(Sizes.size20)
                            : const Radius.circular(Sizes.size5),
                        bottomRight: isMine
                            ? const Radius.circular(Sizes.size5)
                            : const Radius.circular(Sizes.size20),
                      ),
                    ),
                    child: const Text(
                      "This is a message!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size16,
                      ),
                    ),
                  ),
                ],
              );
            },
            separatorBuilder: (context, index) => Gaps.v10,
            itemCount: 10,
          ),
          Positioned(
            bottom: 0,
            width: MediaQuery.of(context).size.width, // 화면의 가로 길이
            child: BottomAppBar(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size18,
                vertical: Sizes.size9,
              ),
              color: Colors.grey.shade200,
              child: Row(
                children: [
                  Expanded(
                    // 화면의 가로 길이를 차지하는 위젯
                    child: SizedBox(
                      height: Sizes.size44,
                      child: TextField(
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                        ),
                        decoration: InputDecoration(
                          hintText: "Send a message...",
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Sizes.size20),
                              topRight: Radius.circular(Sizes.size20),
                              bottomLeft: Radius.circular(Sizes.size20),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.only(
                            left: Sizes.size16,
                          ),
                          suffixIcon: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.faceSmile,
                                color: Colors.grey.shade500,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h14,
                  Container(
                    padding: const EdgeInsets.all(Sizes.size9),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(Sizes.size32),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.paperPlane,
                      color: Colors.white,
                      size: Sizes.size20 + Sizes.size2,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}