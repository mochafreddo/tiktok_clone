import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
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
  // 애니메이션을 사용하기 위해 mixin을 추가한다.

  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  final Duration _animationDuration = const Duration(milliseconds: 200);

  late final AnimationController _animationController;

  bool _isPaused = false;

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
    _videoPlayerController.play();
    setState(() {}); // 비디오가 준비되면 화면을 다시 그린다.
    _videoPlayerController.addListener(_onVideoChange); // 비디오가 변경될 때마다 호출된다.
  }

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();

    _animationController = AnimationController(
      vsync: this, // vsync를 this로 설정한다.
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
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      // 화면에 보이고 비디오가 재생 중이지 않다면
      _videoPlayerController.play();
    }
  }

  void _togglePause() {
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
              onTap: _togglePause,
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
        ],
      ),
    );
  }
}
