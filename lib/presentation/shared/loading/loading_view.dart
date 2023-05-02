import 'package:bookly_app/presentation/resources/color_manager.dart';
import 'package:flutter/material.dart';


class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
