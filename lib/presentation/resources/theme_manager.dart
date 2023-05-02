import 'package:bookly_app/presentation/resources/color_manager.dart';
import 'package:bookly_app/presentation/resources/font_manager.dart';
import 'package:bookly_app/presentation/resources/styles_manager.dart';
import 'package:bookly_app/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      appBarTheme: const AppBarTheme(
        titleSpacing: AppPadding.p14,
        backgroundColor: ColorManager.backgroundColor,
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: ColorManager.backgroundColor,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      textTheme: TextTheme(
        bodyMedium:
            getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s18),
        bodyLarge:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s20),
        bodySmall:
            getMediumStyle(color: ColorManager.gray, fontSize: FontSize.s14),
        labelMedium:
            getBoldStyle(color: ColorManager.white, fontSize: FontSize.s20),
        labelSmall:
            getMediumStyle(color: ColorManager.white, fontSize: FontSize.s16),
        titleSmall:
            getRegularStyle(color: ColorManager.white, fontSize: FontSize.s14),
        titleMedium:
            getSemiBoldStyle(color: ColorManager.white, fontSize: FontSize.s14),
        titleLarge: getGtRegularStyle(
            color: ColorManager.white, fontSize: FontSize.s20),
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s18),
            borderSide: const BorderSide(color: ColorManager.white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s18),
            borderSide: const BorderSide(color: ColorManager.white)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s18),
            borderSide: const BorderSide(color: ColorManager.error)),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSize.s18),
            borderSide: const BorderSide(color: ColorManager.white)),
        labelStyle:
            getMediumStyle(color: ColorManager.white, fontSize: FontSize.s16),
      ));
}
