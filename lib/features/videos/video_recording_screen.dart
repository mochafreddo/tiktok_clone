import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  static const String routeName = 'postVideo';
  static const String routeURL = '/upload';

  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _isSelfieMode = false;

  // Indicate there's no camera for IOS debug mode
  late final bool _noCamera = kDebugMode && Platform.isIOS;

  late FlashMode _flashMode;
  late CameraController _cameraController;

  // Animation Controllers
  late final AnimationController _buttonAnimationController;
  late final AnimationController _progressAnimationController;

  // Animation for recording button
  late final Animation<double> _buttonAnimation;

  @override
  void initState() {
    super.initState();

    // Initiate animations
    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _buttonAnimation = Tween(
      begin: 1.0,
      end: 1.3,
    ).animate(_buttonAnimationController);

    _progressAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    if (!_noCamera) {
      initPermissions();
    } else {
      setState(() {
        _hasPermission = true;
      });
    }

    WidgetsBinding.instance.addObserver(this);
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  // Function to request and verify permissions
  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();
    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    }
  }

  // Function to initialize camera
  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
      // enableAudio: false, // for iOS emulator
    );

    await _cameraController.initialize();

    // only for iOS.
    // iOS에서 영상을 녹화할 때, 가끔 영상과 오디오 싱크가 맞지 않는 경우가 생긴다.
    await _cameraController.prepareForVideoRecording();
    _flashMode = _cameraController.value.flashMode;

    setState(() {});
  }

  // Function to switch selfie mode
  Future<void> _toggleSelfieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  // Function to set flash mode
  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  // Function to start recording
  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;
    await _cameraController.startVideoRecording();
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  // Function to stop recording
  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
    final video = await _cameraController.stopVideoRecording();
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  // Function to pick video
  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    if (!_noCamera) {
      _cameraController.dispose();
    }
    super.dispose();
  }

  // Lifecycle events
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (_noCamera) return;
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  // Widget for flash mode
  IconButton flashModeIcon(FlashMode flashMode) {
    return IconButton(
      color: _flashMode == flashMode ? Colors.amber.shade200 : Colors.white,
      onPressed: () => _setFlashMode(flashMode),
      icon: Icon(
        switch (flashMode) {
          FlashMode.off => Icons.flash_off_rounded,
          FlashMode.always => Icons.flash_on_rounded,
          FlashMode.auto => Icons.flash_auto_rounded,
          FlashMode.torch => Icons.flashlight_on,
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: !_hasPermission
            ? const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Initializing...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  if (!_noCamera && _cameraController.value.isInitialized)
                    CameraPreview(_cameraController),
                  const Positioned(
                    top: Sizes.size40,
                    left: Sizes.size20,
                    child: CloseButton(color: Colors.white),
                  ),
                  if (!_noCamera)
                    Positioned(
                      top: Sizes.size20,
                      right: Sizes.size20,
                      child: Column(
                        children: [
                          IconButton(
                            color: Colors.white,
                            onPressed: _toggleSelfieMode,
                            icon: const Icon(
                              Icons.cameraswitch,
                            ),
                          ),
                          Gaps.v10,
                          flashModeIcon(FlashMode.off),
                          Gaps.v10,
                          flashModeIcon(FlashMode.always),
                          Gaps.v10,
                          flashModeIcon(FlashMode.auto),
                          Gaps.v10,
                          flashModeIcon(FlashMode.torch),
                        ],
                      ),
                    ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTapDown: _startRecording,
                          onTapUp: (details) => _stopRecording(),
                          child: ScaleTransition(
                            scale: _buttonAnimation,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: Sizes.size80 + Sizes.size14,
                                  height: Sizes.size80 + Sizes.size14,
                                  child: CircularProgressIndicator(
                                    color: Colors.red.shade400,
                                    strokeWidth: Sizes.size6,
                                    value: _progressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size80,
                                  height: Sizes.size80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: IconButton(
                              onPressed: _onPickVideoPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.images,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
