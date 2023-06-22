import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        /* body: const Column(children: [
        CloseButton() // CloseButton: 닫기 버튼
      ]), */
        /* body: ListWheelScrollView(
        // ListWheelScrollView: 스크롤 가능한 위젯
        // useMagnifier: true, // useMagnifier: 확대 기능 사용 여부
        // magnification: 1.5, // magnification: 확대 비율
        diameterRatio: 1.5, // diameterRatio: 지름 비율
        offAxisFraction: 2, // offAxisFraction: 스크롤 시 회전하는 정도
        itemExtent: 200, // itemExtent: 각 아이템의 높이
        children: [
          for (var x in [
            1,
            2,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1,
            1
          ])
            FractionallySizedBox(
              widthFactor: 1,
              child: Container(
                color: Colors.teal,
                alignment: Alignment.center,
                child: const Text(
                  "Pick me",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 39,
                  ),
                ),
              ),
            )
        ],
      ), */
        /* body: const Column(
        children: [
          /* CupertinoActivityIndicator(
            // CupertinoActivityIndicator: iOS 스타일의 로딩 표시기
            radius: 40,
            // animating: false,
          ), */
          /* CircularProgressIndicator(), // CircularProgressIndicator: 원형 로딩 표시기 */
          CircularProgressIndicator
              .adaptive(), // CircularProgressIndicator.adaptive(): 플랫폼에 맞는 로딩 표시기
        ],
      ), */
        body: ListView(
          children: const [
            /* ListTile(
              onTap: () => showAboutDialog( // showAboutDialog: AboutDialog를 표시하는 함수
                context: context,
                applicationVersion: "1.0",
                applicationLegalese:
                    "All rights reserved. Please don't copy me.",
              ),
              title: const Text(
                "About",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              subtitle: const Text("About this app....."),
            ), */
            AboutListTile(), // AboutListTile: AboutDialog를 표시하는 위젯
          ],
        ));
  }
}
