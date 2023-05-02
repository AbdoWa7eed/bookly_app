import 'package:bookly_app/presentation/resources/assets_manager.dart';
import 'package:bookly_app/presentation/resources/color_manager.dart';
import 'package:bookly_app/presentation/resources/constants_manager.dart';
import 'package:bookly_app/presentation/resources/routes_manager.dart';
import 'package:bookly_app/presentation/resources/strings_managet.dart';
import 'package:bookly_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _goNext();
  }

  _initAnimation() {
    _animationController = AnimationController(
        vsync: this,
        duration:
            const Duration(seconds: AppConstants.splashAnimationDuration));

    _animation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animationController.forward();
  }

  _goNext() {
    Future.delayed(
      const Duration(seconds: AppConstants.splashDelay),
      () {
        Navigator.of(context).pushReplacementNamed(Routes.homeRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(ImageAssets.logo,
                height: AppSize.s45, width: AppSize.s45),
            const SizedBox(
              height: AppSize.s12,
            ),
            FadeTransition(
              opacity: _animation,
              child: Text(AppStrings.splashText,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
