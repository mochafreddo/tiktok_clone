import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/discover/discover_screen.dart';
import 'package:tiktok_clone/features/inbox/inbox_screen.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/features/main_navigation/widgets/post_video_button.dart';
import 'package:tiktok_clone/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_recording_screen.dart';
import 'package:tiktok_clone/features/videos/views/video_timeline_screen.dart';
import 'package:tiktok_clone/utils.dart';

// Represents the main navigation screen
class MainNavigationScreen extends StatefulWidget {
  static const routeName = 'mainNavigation';

  final String tab;

  const MainNavigationScreen({
    super.key,
    required this.tab,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  // Difine the tab names
  final List<String> _tabs = [
    'home',
    'discover',
    'xxxx',
    'inbox',
    'profile',
  ];

  late int _selectedIndex = _tabs.indexOf(widget.tab);
  bool _isLongPress = false;

  // Handles the tap events on the tabs.
  void _onTap(int index) {
    context.go('/${_tabs[index]}');
    setState(() {
      _selectedIndex = index;
    });
  }

  // Handles the tap event on the post video button.
  void _onPostVideoButtonTap() {
    context.pushNamed(VideoRecordingScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);

    // Determine the color for the current selected index and theme mode.
    final color = _selectedIndex == 0 || isDark ? Colors.black : Colors.white;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: color,
      body: Stack(
        children: [
          _buildOffstageWidget(const VideoTimelineScreen(), 0),
          _buildOffstageWidget(const DiscoverScreen(), 1),
          _buildOffstageWidget(const InboxScreen(), 3),
          _buildOffstageWidget(
              const UserProfileScreen(username: '목화', tab: ""), 4),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(color),
    );
  }

  // Builds an offstage for the given child widget and index.
  Widget _buildOffstageWidget(Widget child, int index) {
    return Offstage(
      offstage: _selectedIndex != index,
      child: child,
    );
  }

  // Builds the bottom navigation bar.
  Container _buildBottomNavigationBar(Color color) {
    return Container(
      color: color,
      padding: const EdgeInsets.only(bottom: Sizes.size32),
      child: Padding(
        padding: const EdgeInsets.all(Sizes.size12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildNavTab(
                "Home", FontAwesomeIcons.house, FontAwesomeIcons.house, 0),
            _buildNavTab("Discover", FontAwesomeIcons.compass,
                FontAwesomeIcons.solidCompass, 1),
            Gaps.h24,
            _buildPostVideoButton(),
            Gaps.h24,
            _buildNavTab("Inbox", FontAwesomeIcons.message,
                FontAwesomeIcons.solidMessage, 3),
            _buildNavTab("Profile", FontAwesomeIcons.user,
                FontAwesomeIcons.solidUser, 4),
          ],
        ),
      ),
    );
  }

  // Builds a nav tab for the given text, icons and index.
  Widget _buildNavTab(
      String text, IconData icon, IconData selectedIcon, int index) {
    return NavTab(
      text: text,
      isSelected: _selectedIndex == index,
      icon: icon,
      selectedIcon: selectedIcon,
      onTap: () => _onTap(index),
      selectedIndex: _selectedIndex,
    );
  }

  // Builds the post video button.
  Widget _buildPostVideoButton() {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          _isLongPress = true;
        });
      },
      onLongPressUp: () {
        setState(() {
          _isLongPress = false;
        });
        _onPostVideoButtonTap();
      },
      onTap: _onPostVideoButtonTap,
      child: PostVideoButton(
        isLongPress: _isLongPress,
        inverted: _selectedIndex != 0,
      ),
    );
  }
}
