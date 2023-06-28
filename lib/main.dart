import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/settings/settings_screen.dart';

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
      localizationsDelegates: const [
        // 여기서 delegate란 일종의 번역 파일들로 생각하면 된다.
        // Flutter에는 텍스트가 기본적으로 들어가 있는 위젯들이 있다.
        // Flutter는 그런 위젯들의 번역이 이미 해놓았다.
        // 그래서 아래처럼 Flutter가 기본으로 가지고 있는 위젯들에 대한 번역들을 include 하는 것.
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      // 앱이 어떤 언어를 지원하는 지 알려줘야 한다.
      // ref: IANA Language Subtag Registry
      supportedLocales: const [
        Locale("en"),
        Locale("ko"),
        Locale("es"),
      ],
      themeMode: ThemeMode.system, // ThemeMode.system: 시스템의 테마를 따라간다.
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,

        // This [TextTheme] provides color
        // but not geometry (font size, weight, etc).
        textTheme: Typography.blackMountainView,

        // textTheme: GoogleFonts.itimTextTheme(),
        /* textTheme: TextTheme(
          displayLarge: GoogleFonts.openSans(
            fontSize: 96,
            fontWeight: FontWeight.w300,
            letterSpacing: -1.5,
          ),
          displayMedium: GoogleFonts.openSans(
            fontSize: 60,
            fontWeight: FontWeight.w300,
            letterSpacing: -0.5,
          ),
          displaySmall: GoogleFonts.openSans(
            fontSize: 48,
            fontWeight: FontWeight.w400,
          ),
          headlineMedium: GoogleFonts.openSans(
            fontSize: 34,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          headlineSmall: GoogleFonts.openSans(
            fontSize: 24,
            fontWeight: FontWeight.w400,
          ),
          titleLarge: GoogleFonts.openSans(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.15,
          ),
          titleMedium: GoogleFonts.openSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.15,
          ),
          titleSmall: GoogleFonts.openSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.1,
          ),
          bodyLarge: GoogleFonts.roboto(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
          bodyMedium: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
          labelLarge: GoogleFonts.roboto(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            letterSpacing: 1.25,
          ),
          bodySmall: GoogleFonts.roboto(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
          ),
          labelSmall: GoogleFonts.roboto(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            letterSpacing: 1.5,
          ),
        ), */
        scaffoldBackgroundColor: Colors.white,
        /* bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade50,
        ), */
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
          surfaceTintColor: Colors.white,
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
        ),
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.black,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey.shade500,
        ),
        listTileTheme: const ListTileThemeData(
          iconColor: Colors.black,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        tabBarTheme: TabBarTheme(
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey.shade700,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Color(0xFFE9435A),
        ),
        textTheme: Typography.whiteMountainView,
        /* textTheme: GoogleFonts.itimTextTheme(
          ThemeData(
            brightness: Brightness.dark,
          ).textTheme,
        ), */
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.grey.shade900,
          backgroundColor: Colors.grey.shade900,
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: Sizes.size16 + Sizes.size2,
            fontWeight: FontWeight.w600,
          ),
          actionsIconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
          iconTheme: IconThemeData(
            color: Colors.grey.shade100,
          ),
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: Colors.grey.shade900,
        ),
        primaryColor: const Color(0xFFE9435A),
      ),

      // home: const SignUpScreen(),
      // home: const MainNavigationScreen(),
      // home: const ActivityScreen(),
      // home: const LayoutBuilderCodeLab(),
      home: const SettingsScreen(),
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
