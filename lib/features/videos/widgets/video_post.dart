import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;

  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinished,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  // with: 다중 상속을 지원하는 키워드
  // SingleTickerProviderStateMixin:
  // current tree가 활성화된 동안만(위젯이 화면에 보일 때만) tick하는 단일 ticker를 제공
  // Ticker는 시계라고 생각하면 도움이 된다. 이 시계는 function을 애니메이션의 프레임마다 실행. 애니메이션에 callback을 제공해준다.
  // Ticker class는 애니메이션의 매 프레임마다 callback을 호출.
  // 화면에 위젯이 없는데도 Ticker가 남아있으면 안 됨. 그러면 화면에 위젯이 없어도 미친듯이 callback을 호출.
  // 그래서 current tree가 활성화된 동안만, 즉, 위젯이 화면에 보일 때만 tick하는 단일 ticker를 제공하는 것.
  // TickerProviderStateMixin: 여러 개의 Ticker를 생성. multiple animation controller.
  // SingleProviderStateMixin: single animation controller.

  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  bool _isPaused = false;

  bool _showFullText = false;

  /*
   * 비디오가 변경될 때마다 호출되는 콜백이다.
   * 비디오가 끝나면 onVideoFinished 콜백을 호출한다.
   */
  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    // _videoPlayerController.play();
    await _videoPlayerController.setLooping(true); // 비디오가 끝나면 다시 처음부터 재생한다.
    _videoPlayerController.addListener(_onVideoChange); // 비디오가 변경될 때마다 호출된다.
    setState(() {}); // 비디오가 준비되면 화면을 다시 그린다.
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this,
      // vsync: 위젯이 안 보일 때는 애니메이션이 작동하지 않도록 한다.
      // SingleTickerProviderStateMixin을 사용해야 한다.
      // this는 _VideoPostState 위젯(SingleTickerProviderStateMixin를 상속하는)을 의미한다.

      lowerBound: 1.0, // 애니메이션의 끝 값
      upperBound: 1.5, // 애니메이션의 시작 값
      value: 1.5, // 애니메이션의 시작 값
      duration: _animationDuration, // 애니메이션의 지속 시간
    );

    // build를 호출하는 첫 번째 방법
    /*
    _animationController.addListener(() {
      // 애니메이션의 값이 변경될 때마다 호출된다.
      setState(() {}); // setState를 호출하면 애니메이션의 값이 변경될 때마다 위젯이 다시 그려진다.
    });
    */
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      // 화면에 보이는데 비디오가 재생되지 않는다면
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      // 화면에 보이지 않는데 비디오가 재생된다면
      _onTogglePause(); // 일시정지한다.
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse(); // 애니메이션을 역재생한다.
    } else {
      _videoPlayerController.play();
      _animationController.forward(); // 애니메이션을 재생한다.
    }
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    } // 비디오가 재생 중이면 일시정지한다.

    await showModalBottomSheet(
      context: context,
      builder: (context) => const VideoComments(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      // isScrollControlled는 bottom sheet 안에서 ListView를 사용할 것이라면 true로 설정.
    ); // showModalBottomSheet: 화면 아래에서 위로 올라오는 모달 창을 띄운다.
    // showModalBottomSheet의 Future는 유저가 댓글 창을 닫으면 resolve 된다.

    _onTogglePause(); // 비디오를 다시 재생한다.
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      // VisibilityDetector는 위젯이 화면에 보이는지 감지하는 위젯이다.
      key: Key("${widget.index}"), // 각 위젯의 키를 인덱스로 설정한다.
      onVisibilityChanged: _onVisibilityChanged, // 화면에 보이는지 감지하는 콜백을 설정한다.
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: AnimatedBuilder(
                  animation:
                      _animationController, // _animationController의 변화를 감지한다.
                  builder: (context, child) {
                    // animationController의 값이 변할 때마다 실행됨
                    return Transform.scale(
                      scale: _animationController.value,
                      child: child, // 아래 AnimatedOpacity 위젯이 child가 된다.
                    );
                  },
                  child: AnimatedOpacity(
                    opacity: _isPaused ? 1 : 0,
                    duration: _animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size52,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 25,
            left: 15,
            width: MediaQuery.of(context).size.width - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "@Geoffrey",
                  style: TextStyle(
                    fontSize: Sizes.size20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v10,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        "Face Massage Roller Made Of Jade Material. This face massage roller, known for its cooling and healing properties, revitalizes the skin, reducing puffiness and wrinkles. Its dual-ended design allows for precise application on various areas of the face. With consistent use, one can expect to see a more youthful and vibrant complexion.",
                        style: const TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.white,
                        ),
                        maxLines: _showFullText ? null : 2,
                        // maxLines를 null로 설정하면 텍스트가 모두 표시된다.
                        overflow: _showFullText
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                        // TextOverflow.visible로 설정하면 텍스트가 모두 표시된다.
                        // TextOverflow.ellipsis로 설정하면 텍스트가 잘린다.
                      ),
                    ),
                    Gaps.h5,
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _showFullText = !_showFullText;
                        });
                      },
                      child: Text(
                        _showFullText ? "See less" : "See more",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 25,
            right: 15,
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  foregroundImage: NetworkImage(
                      "https://avatars.githubusercontent.com/u/76798197?v=4"),
                  child: Text("Geoffrey"),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "2.9M",
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: () => _onCommentsTap(context),
                  child: const VideoButton(
                    icon: FontAwesomeIcons.solidComment,
                    text: "33K",
                  ),
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
