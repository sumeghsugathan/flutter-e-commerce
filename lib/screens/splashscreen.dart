import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nikeapp/components/check_user.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset("assets/Lottie/Shoes.json"),
          ),
          const Text(
            "NIKE",
            style: TextStyle(
                fontSize: 38, fontWeight: FontWeight.bold, letterSpacing: 2),
          )
        ],
      ),
      nextScreen: const CheckUser(),
      splashIconSize: 400,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
