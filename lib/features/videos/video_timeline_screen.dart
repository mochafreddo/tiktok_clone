import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  int _itemCount = 4;

  final PageController _pageController =
      PageController(); // PageView를 제어하기 위한 컨트롤러

  final Duration _scrollDuration = const Duration(milliseconds: 250);
  final Curve _scrollCurve = Curves.linear;

  // List<Color> colors = [
  //   Colors.blue,
  //   Colors.red,
  //   Colors.yellow,
  //   Colors.teal,
  // ];

  void _onPageChanged(int page) {
    // animateToPage를 호출하면 페이지가 애니메이션으로 이동한다.
    _pageController.animateToPage(
      page,
      duration: _scrollDuration,
      curve: _scrollCurve,
    );

    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4;

      // colors.addAll([
      //   Colors.blue,
      //   Colors.red,
      //   Colors.yellow,
      //   Colors.teal,
      // ]);

      setState(() {}); // setState를 호출하면 PageView가 다시 그려진다.
    }
  }

  void _onVideoFinished() {
    return;
    // 틱톡에서 자동으로 다음 영상으로 넘어가지 않는 것을 확인하여 기능 사용하지 않음.
    /* _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    ); */
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    // 아래는 fake future
    return Future.delayed(
      const Duration(seconds: 5),
    );
    // 여기서는 원래 API 요청을 보내던가 해야함.
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
    return RefreshIndicator(
      onRefresh: _onRefresh,
      // onRefresh는 Future를 반환해야 한다. (혹은 async)
      displacement: 50, // RefreshIndicator가 보여지는 위치
      edgeOffset: 20, // RefreshIndicator가 보여지기 시작하는 위치
      color: Theme.of(context).primaryColor,
      child: PageView.builder(
        // PageView.builder를 사용하는 이유는 페이지가 많아지면 메모리를 많이 사용하기 때문이다.
        controller: _pageController, // PageView를 제어하기 위한 컨트롤러
        scrollDirection: Axis.vertical, // 페이지가 세로로 스크롤되게 한다.
        onPageChanged: _onPageChanged, // 페이지가 바뀔 때마다 호출된다.
        itemCount: _itemCount, // 페이지의 개수를 지정한다.
        itemBuilder: (context, index) => VideoPost(
          onVideoFinished: _onVideoFinished,
          index: index,
        ),
      ),
    );
  }
}
