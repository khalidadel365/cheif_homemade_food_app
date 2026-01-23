import 'package:flutter/material.dart';
import 'package:flutter_fadein/flutter_fadein.dart';
import '../../../../../core/utilities/assets.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeIn(
          duration: const Duration(seconds: 1),
          curve: Curves.easeIn,
          child: Image.asset(
            AssetsData.logo,
            width: 400,
            height: 400,
          ),
        ),
      ),
    );
  }
}
