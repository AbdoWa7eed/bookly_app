import 'package:bookly_app/app/di.dart';
import 'package:bookly_app/presentation/home/cubit/cubit.dart';
import 'package:bookly_app/presentation/resources/routes_manager.dart';
import 'package:bookly_app/presentation/resources/theme_manager.dart';
import 'package:bookly_app/presentation/search/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => instance<HomeCubit>()..getInitialData()),
        BlocProvider(
            create: (context) => instance<SearchCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashRoute,
        theme: getApplicationTheme(),
      ),
    );
  }
}
