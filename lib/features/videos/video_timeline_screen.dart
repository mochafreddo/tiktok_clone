import 'package:flutter/material.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController =
      PageController(); // PageView를 제어하기 위한 컨트롤러

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.teal,
  ];

  void _onPageChanged(int page) {
    // animateToPage를 호출하면 페이지가 애니메이션으로 이동한다.
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );

    // 마지막 페이지에 도달하면 새로운 색상을 추가한다.
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.yellow,
        Colors.teal,
      ]);

      setState(() {}); // setState를 호출하면 PageView가 다시 그려진다.
    }
  }

  @override
  Widget build(BuildContext context) {
    // PageView는 아이템을 한 번에 전부 렌더링한다.
    // return PageView(
    //   // pageSnapping: false, // 페이지가 스냅되지 않게 한다.
    //   scrollDirection: Axis.vertical, // 페이지가 세로로 스크롤되게 한다.
    //   children: [
    //     Container(color: Colors.blue),
    //     Container(color: Colors.teal),
    //     Container(color: Colors.yellow),
    //     Container(color: Colors.pink),
    //   ],
    // );
    return PageView.builder(
      // PageView.builder를 사용하는 이유는 페이지가 많아지면 메모리를 많이 사용하기 때문이다.
      controller: _pageController, // PageView를 제어하기 위한 컨트롤러
      scrollDirection: Axis.vertical, // 페이지가 세로로 스크롤되게 한다.
      onPageChanged: _onPageChanged, // 페이지가 바뀔 때마다 호출된다.
      itemCount: _itemCount, // 페이지의 개수를 지정한다.
      itemBuilder: (context, index) => Container(
        color: colors[index],
        child: Center(
          child: Text(
            "Screen $index",
            style: const TextStyle(
              fontSize: 68,
            ),
          ),
        ),
      ),
    );
  }
}