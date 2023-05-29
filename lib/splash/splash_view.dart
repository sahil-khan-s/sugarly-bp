import 'package:bpcheck/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import '../config/app_assets.dart';
import '../pages/login/login_screen.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        child: SplashScreenView(
          navigateRoute: LoginScreen(),
          imageSize: 150,
          duration: 200,
          speed: 500,
          imageSrc: AppAssets.icSplash,
          textType: TextType.ColorizeAnimationText,
          textStyle: const TextStyle(fontSize: 40.0),
          colors: const [Colors.purple, Colors.blue, Colors.yellow, Colors.red],
          backgroundColor: AppColors.primaryColor,
        ),
      ),
    );
  }
}
