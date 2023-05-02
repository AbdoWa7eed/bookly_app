import 'package:bookly_app/app/di.dart';
import 'package:bookly_app/presentation/book_datails/book_details_view.dart';
import 'package:bookly_app/presentation/home/view/home_view.dart';
import 'package:bookly_app/presentation/resources/constants_manager.dart';
import 'package:bookly_app/presentation/resources/strings_managet.dart';
import 'package:bookly_app/presentation/search/view/search_view.dart';
import 'package:bookly_app/presentation/splash/splash_view.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String splashRoute = '/';
  static const String homeRoute = '/home';
  static const String bookDetailsRoute = '/bookDetails';
  static const String searchRoute = '/search';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        initAppModule();
        return fadeTransitionRoute(
            page: const SplashView(), settings: settings);
      case Routes.homeRoute:
        initHomeModule();
        return fadeTransitionRoute(page: const HomeView(), settings: settings);
      case Routes.bookDetailsRoute:
        return fadeTransitionRoute(
            page: const BookDetailsView(), settings: settings);
      case Routes.searchRoute:
        initSearchModule();
        return fadeTransitionRoute(
            page: const SearchView(), settings: settings);
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteFound),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }

  static Route<dynamic> fadeTransitionRoute(
      {required Widget page, required RouteSettings settings}) {
    return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionDuration:
            const Duration(milliseconds: AppConstants.pageAnimationDuration),
        transitionsBuilder: (context, animation, animationTime, c) =>
            FadeTransition(opacity: animation, child: c));
  }
}
