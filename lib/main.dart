import 'package:bookly_app/app/app.dart';
import 'package:bookly_app/app/constants.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookly_app/presentation/shared/bloc_observer.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await _hiveInitializer();
  runApp(MyApp());
}

_hiveInitializer() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BookInfoModelAdapter());
  await Hive.openBox<BookInfoModel>(Constants.featuredBooksKey);
  await Hive.openBox<BookInfoModel>(Constants.newestBooksKey);
}
