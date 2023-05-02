import 'package:bookly_app/presentation/resources/assets_manager.dart';
import 'package:bookly_app/presentation/resources/color_manager.dart';
import 'package:bookly_app/presentation/resources/constants_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

showSnackBar(String text, BuildContext context,
    {Color color = ColorManager.error}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      text,
      style: Theme.of(context).textTheme.labelSmall,
    ),
    backgroundColor: color,
    duration: const Duration(seconds: AppConstants.snackBarDelay),
  ));
}

Widget showImage(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    fit: BoxFit.cover,
    errorWidget: (context, error, stackTrace) {
      return Image.asset(
        ImageAssets.error,
        fit: BoxFit.cover,
      );
    },
  );
}

Future<void> delayAndDo(
    {required int seconds, required Function function}) async {
  await Future.delayed(
    Duration(seconds: seconds),
    () {
      function.call();
    },
  );
}
