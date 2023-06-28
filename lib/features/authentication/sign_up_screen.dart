import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/authentication/login_screen.dart';
import 'package:tiktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tiktok_clone/features/authentication/username_screen.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:tiktok_clone/utils.dart';
// import 'package:flutter_gen/gen_l10n/intl_generated.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(Localizations.localeOf(context));
    }

    return OrientationBuilder(
      builder: (context, orientation) {
        /* if (orientation == Orientation.landscape) {
          return const Scaffold(
            body: Center(
              child: Text("Plz rotate ur phone."),
            ),
          );
        } */
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size40,
              ),
              child: Column(
                children: [
                  Gaps.v80,
                  Text(
                    // 'Sign Up for Tiktok',
                    // AppLocalizations.of(context)!.signUpTitle('TikTok'),
                    S.of(context).signUpTitle('TikTok'), // intl_generated.dart
                    /* style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.red,
                        ), */
                    /* style: GoogleFonts.abrilFatface(
                      textStyle: const TextStyle(
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.w700,
                      ),
                    ), */
                    style: const TextStyle(
                      fontSize: Sizes.size24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gaps.v20,
                  Opacity(
                    opacity: 0.7,
                    child: Text(
                      S.of(context).signUpSubtitle,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Gaps.v40,
                  if (orientation == Orientation.portrait) ...[
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.user),
                      text: S.of(context).emailPasswordButton,
                      target: const UsernameScreen(),
                    ),
                    Gaps.v16,
                    AuthButton(
                      icon: const FaIcon(FontAwesomeIcons.apple),
                      text: S.of(context).appleButton,
                      target: const UsernameScreen(),
                    ),
                    Gaps.v16,
                    const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.facebook),
                      text: "Continue with Facebook",
                      target: UsernameScreen(),
                    ),
                    Gaps.v16,
                    const AuthButton(
                      icon: FaIcon(FontAwesomeIcons.google),
                      text: "Continue with Google",
                      target: UsernameScreen(),
                    ),
                  ],
                  if (orientation == Orientation.landscape)
                    Row(
                      children: [
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.user),
                            text: S.of(context).emailPasswordButton,
                            target: const UsernameScreen(),
                          ),
                        ),
                        Gaps.h16,
                        Expanded(
                          child: AuthButton(
                            icon: const FaIcon(FontAwesomeIcons.apple),
                            text: S.of(context).appleButton,
                            target: const UsernameScreen(),
                          ),
                        ),
                        Gaps.h16,
                        const Expanded(
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.facebook),
                            text: "Continue with Facebook",
                            target: UsernameScreen(),
                          ),
                        ),
                        Gaps.h16,
                        const Expanded(
                          child: AuthButton(
                            icon: FaIcon(FontAwesomeIcons.google),
                            text: "Continue with Google",
                            target: UsernameScreen(),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            color: isDarkMode(context)
                ? Theme.of(context).appBarTheme.backgroundColor
                : Colors.grey.shade50,
            child: Padding(
              padding: const EdgeInsets.only(
                top: Sizes.size32,
                bottom: Sizes.size64,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(S.of(context).alreadyHaveAnAccount),
                  Gaps.h5,
                  GestureDetector(
                    onTap: () => _onLoginTap(context),
                    child: Text(
                      S.of(context).logIn,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
