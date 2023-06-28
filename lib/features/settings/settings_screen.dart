import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/utils.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = false;

  void _onNotificationsChanged(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    return Localizations.override(
      context: context,
      locale: const Locale("es"),
      child: Scaffold(
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
            children: [
              /* CupertinoSwitch(
                // CupertinoSwitch: iOS 스타일의 스위치
                value: _notifications,
                onChanged: _onNotificationsChanged,
              ), */
              Switch.adaptive(
                // Switch.adaptive(): 플랫폼에 맞는 스위치
                value: _notifications,
                onChanged: _onNotificationsChanged,
              ),
              /* SwitchListTile(
                // SwitchListTile: 스위치를 포함한 리스트 타일
                value: _notifications,
                onChanged: _onNotificationsChanged,
                title: const Text("Enable notifications"),
              ), */
              SwitchListTile.adaptive(
                // SwitchListTile.adaptive(): 플랫폼에 맞는 스위치를 포함한 리스트 타일
                value: _notifications,
                onChanged: _onNotificationsChanged,
                title: const Text("Enable notifications"),
                subtitle: const Text("Enable notifications"),
              ),
              /* Checkbox(
                // Checkbox: 체크박스
                value: _notifications,
                onChanged: _onNotificationsChanged,
              ), */
              CheckboxListTile(
                // CheckboxListTile: 체크박스를 포함한 리스트 타일
                activeColor: Colors.black,
                fillColor: MaterialStateProperty.all(
                    isDark ? Colors.white : Colors.black),
                value: _notifications,
                onChanged: _onNotificationsChanged,
                title: const Text("Enable notifications"),
              ),
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
              ListTile(
                onTap: () async {
                  final date = await showDatePicker(
                    // showDatePicker: 날짜 선택기를 표시하는 함수
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                  );
                  if (kDebugMode) {
                    print(date);
                  }
                  if (!mounted) return;
                  final time = await showTimePicker(
                    // showTimePicker: 시간 선택기를 표시하는 함수
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (kDebugMode) {
                    print(time);
                  }
                  if (!mounted) return;
                  final booking = await showDateRangePicker(
                    // showDateRangePicker: 날짜 범위 선택기를 표시하는 함수
                    context: context, // await 구문 안에 context를 사용하면 에러가 발생한다.
                    firstDate: DateTime(1980),
                    lastDate: DateTime(2030),
                    builder: (context, child) {
                      return Theme(
                        data: ThemeData(
                          appBarTheme: const AppBarTheme(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (kDebugMode) {
                    print(booking);
                  }
                },
                title: const Text("What is your birthday?"),
              ),

              /// iOS version log out.
              ListTile(
                title: const Text("Log out (iOS)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoDialog(
                    // showCupertinoDialog는 팝업창 밖을 눌러도 없어지지 않는다.
                    context: context,
                    builder: (context) => CupertinoAlertDialog(
                      title: const Text("Are you sure?"),
                      content: const Text("Plx dont go"),
                      actions: [
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("No"),
                        ),
                        CupertinoDialogAction(
                          onPressed: () => Navigator.of(context).pop(),
                          isDestructiveAction: true, // red color
                          child: const Text("Yes"),
                        )
                      ],
                    ),
                  );
                },
              ),

              /// Android version log out.
              ListTile(
                title: const Text("Log out (Android)"),
                textColor: Colors.red,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      icon: const FaIcon(FontAwesomeIcons.skull),
                      title: const Text("Are you sure?"),
                      content: const Text("Plx dont go"),
                      actions: [
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const FaIcon(FontAwesomeIcons.car),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Yes"),
                        )
                      ],
                    ),
                  );
                },
              ),

              /// Log out (iOS / Bottom)
              /// showCupertinoModalPopup, CupertinoActionSheet
              ListTile(
                title: const Text("Log out (iOS / Bottom)"),
                textColor: Colors.red,
                onTap: () {
                  showCupertinoModalPopup(
                    // showCupertinoModalPopup는 팝업창 밖을 누르면 창이 없어진다.
                    // showCupertinoDialog는 팝업창 밖을 눌러도 안 닫히고, 창이 위에 열린다.
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                      // CupertinoActionSheet: iOS 스타일의 액션 시트
                      title: const Text("Are you sure?"),
                      message: const Text("Please doooooon gooooooo"),
                      actions: [
                        CupertinoActionSheetAction(
                          isDefaultAction: true, // 글자가 더 굵다.
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Not log out"),
                        ),
                        CupertinoActionSheetAction(
                          isDestructiveAction: true, // red color
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Yes plz."),
                        )
                      ],
                    ),
                  );
                },
              ),
              const AboutListTile(), // AboutListTile: AboutDialog를 표시하는 위젯
            ],
          )),
    );
  }
}
