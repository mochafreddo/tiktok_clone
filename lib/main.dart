import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/main_navigation/main_navigation_screen.dart';

void main() async {
  /// Flutter framework를 이용해 앱이 시작하기 전에 state를 어떤 식으로든 바꾸고 싶다면 engine 자체와 engine과 widget의 연결을 확실하게 초기화시켜야 한다.
  /// 이렇게 하면 모든 widget들이 engine과 연결된 것을 확실하게 보장해줄 수 있다.
  /// WidgetsFlutterBinding: This is the glue that binds the framework to the Flutter engine.
  /// ensureInitialized(): You only need to call this method if you need the binding to be initialized before calling [runApp].
  WidgetsFlutterBinding.ensureInitialized();

  /// 앱이 시작하기 전에 화면 방향을 portrait로 고정시킨다.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  /// 앱이 시작하기 전에 상태바의 색상을 검은색으로 고정시킨다.
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark,
  );

  runApp(const TikTokApp());
}

class TikTokApp extends StatelessWidget {
  const TikTokApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 제거
      title: 'TikTok Clone',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color(0xFFE9435A),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A), // 커서 색상
          // selectionColor: Color(0xFFE9435A), // 선택된 영역의 배경색
        ),
        splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // home: const SignUpScreen(),
      home: const MainNavigationScreen(),
      // home: const ActivityScreen(),
      // home: const LayoutBuilderCodeLab(),
    );
  }
}

/* class LayoutBuilderCodeLab extends StatelessWidget {
  const LayoutBuilderCodeLab({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width / 2,
        child: LayoutBuilder(
          builder: (context, constraints) => Container(
            // constraints: BoxConstraints box가 커질 수 있는 최대치를 알려준다.
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            color: Colors.teal,
            child: Center(
              child: Text(
                "${size.width} / ${constraints.maxWidth}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 98,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
} */
