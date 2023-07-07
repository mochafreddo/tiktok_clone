import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tiktok_clone/common/widgets/video_config/video_config.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/widgets/video_button.dart';
import 'package:tiktok_clone/features/videos/widgets/video_comments.dart';
import 'package:tiktok_clone/generated/l10n.dart';
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
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  final Duration _animationDuration = const Duration(milliseconds: 200);

  // Variables
  late final AnimationController _animationController;
  bool _isPaused = false;
  bool _isMuted = false;
  bool _showFullText = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _initAnimationController();
  }

  @override
  void dispose() {
    _disposeControllers();
    super.dispose();
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);

    _initializeMuteStatus();

    _videoPlayerController.addListener(_onVideoChange);
    setState(() {});
  }

  void _initializeMuteStatus() async {
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0.0);
      _isMuted = true;
    }
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: _animationDuration,
    );
  }

  void _disposeControllers() {
    _videoPlayerController.dispose();
    _animationController.dispose();
  }

  void _onVideoChange() {
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinished();
      }
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 &&
        !_isPaused &&
        !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
    if (_videoPlayerController.value.isPlaying && info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  // Toggle pause for video
  void _onTogglePause() {
    if (mounted && _videoPlayerController.value.isInitialized) {
      _videoPlayerController.value.isPlaying ? _pauseVideo() : _playVideo();
      _togglePauseState();
    }
  }

  void _pauseVideo() {
    _videoPlayerController.pause();
    _animationController.reverse();
  }

  void _playVideo() {
    _videoPlayerController.play();
    _animationController.forward();
  }

  void _togglePauseState() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _onCommentsTap(BuildContext context) async {
    if (_videoPlayerController.value.isPlaying) {
      _onTogglePause();
    }

    await _showCommentsSheet(context);

    _onTogglePause();
  }

  Future<void> _showCommentsSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => const VideoComments(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _isMuted ? _muteVideo() : _unmuteVideo();
    });
  }

  void _muteVideo() {
    _videoPlayerController.setVolume(0.0);
  }

  void _unmuteVideo() {
    _videoPlayerController.setVolume(1.0);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          // VideoPlayer
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Container(color: Colors.black),
          ),
          // Video controls
          Positioned.fill(child: GestureDetector(onTap: _onTogglePause)),
          // Video Config: state of autoMute
          Positioned(
            left: 20,
            top: 40,
            child: IconButton(
              icon: FaIcon(
                context.watch<VideoConfig>().isMuted
                    ? FontAwesomeIcons.volumeOff
                    : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
              ),
              onPressed: () {
                context.read<VideoConfig>().toggleIsMuted();
              },
            ),
          ),
          // Play icon animation
          _buildPlayIconAnimation(),
          // Video description
          _buildVideoDescription(),
          // Video actions (like, comment, share)
          _buildVideoActions(context),
        ],
      ),
    );
  }

  // Widget builders
  Positioned _buildPlayIconAnimation() {
    return Positioned.fill(
      child: IgnorePointer(
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.scale(
                scale: _animationController.value,
                child: child,
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
    );
  }

  Positioned _buildVideoDescription() {
    return Positioned(
      bottom: 25,
      left: 15,
      width: MediaQuery.of(context).size.width - 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "@목화",
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
                  overflow: _showFullText
                      ? TextOverflow.visible
                      : TextOverflow.ellipsis,
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
    );
  }

  Positioned _buildVideoActions(BuildContext context) {
    return Positioned(
      bottom: 25,
      right: 15,
      child: Column(
        children: [
          GestureDetector(
            onTap: _toggleMute,
            child: VideoButton(
              icon: _isMuted
                  ? FontAwesomeIcons.volumeXmark
                  : FontAwesomeIcons.volumeHigh,
              text: _isMuted ? "Muted" : "Unmute",
            ),
          ),
          Gaps.v24,
          const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            foregroundImage: NetworkImage(
                'https://avatars.githubusercontent.com/u/76798197?v=4'),
            child: Text('Geoffrey'),
          ),
          Gaps.v24,
          VideoButton(
            icon: FontAwesomeIcons.solidHeart,
            text: S.of(context).likeCount(98798711111987),
          ),
          Gaps.v24,
          GestureDetector(
            onTap: () => _onCommentsTap(context),
            child: VideoButton(
              icon: FontAwesomeIcons.solidComment,
              text: S.of(context).commentCount(65656),
            ),
          ),
          Gaps.v24,
          const VideoButton(
            icon: FontAwesomeIcons.share,
            text: 'Share',
          ),
        ],
      ),
    );
  }
}
