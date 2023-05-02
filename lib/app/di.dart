import 'package:bookly_app/data/data_source/local_data_source.dart';
import 'package:bookly_app/data/data_source/remote_data_source.dart';
import 'package:bookly_app/data/network/app_api.dart';
import 'package:bookly_app/data/network/dio_factory.dart';
import 'package:bookly_app/data/network/network_info.dart';
import 'package:bookly_app/data/repository/repository_impl.dart';
import 'package:bookly_app/domain/repository/repository.dart';
import 'package:bookly_app/domain/usecase/home_usecase.dart';
import 'package:bookly_app/domain/usecase/search_usecase.dart';
import 'package:bookly_app/presentation/home/cubit/cubit.dart';
import 'package:bookly_app/presentation/search/cubit/cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final instance = GetIt.instance;

void initAppModule() async {
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  Dio dio = await instance<DioFactory>().getDio();

  instance
      .registerLazySingleton<AppServiceClient>(() => AppServiceClientImpl(dio));

  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl());

  instance.registerLazySingleton<Repository>(() => RepositoryImpl(
      instance<RemoteDataSource>(),
      instance<LocalDataSource>(),
      instance<NetworkInfo>()));
}

void initHomeModule() {
  if (!GetIt.I.isRegistered<GetFeaturedBooksUseCase>()) {
    instance.registerFactory<GetFeaturedBooksUseCase>(
        () => GetFeaturedBooksUseCase(instance<Repository>()));
  }

  if (!GetIt.I.isRegistered<GetNewestBooksUseCase>()) {
    instance.registerFactory<GetNewestBooksUseCase>(
        () => GetNewestBooksUseCase(instance<Repository>()));
  }

  if (!GetIt.I.isRegistered<HomeCubit>()) {
    instance.registerLazySingleton<HomeCubit>(() => HomeCubit());
  }
}

void initSearchModule() {
  if (!GetIt.I.isRegistered<SearchUseCase>()) {
    instance.registerFactory<SearchUseCase>(
        () => SearchUseCase(instance<Repository>()));
  }
  if (!GetIt.I.isRegistered<SearchCubit>()) {
    instance.registerLazySingleton<SearchCubit>(() => SearchCubit());
  }
}
