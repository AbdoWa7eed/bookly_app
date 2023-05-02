import 'package:bookly_app/app/constants.dart';
import 'package:bookly_app/data/data_source/local_data_source.dart';
import 'package:bookly_app/data/data_source/remote_data_source.dart';
import 'package:bookly_app/data/mapper/mapper.dart';
import 'package:bookly_app/data/network/error_handler.dart';
import 'package:bookly_app/data/network/network_info.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:bookly_app/data/network/failure.dart';
import 'package:bookly_app/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(
      this._remoteDataSource, this._localDataSource, this._networkInfo);

  @override
  Future<Either<Failure, List<BookInfoModel>>> getFeaturedBooks(
      {int pageNumber = 0}) async {
    try {
      final data = _localDataSource.getFeaturedBooks(pageNumber: pageNumber);
      if (data.isNotEmpty) {
        return Right(data);
      }
      if (await _networkInfo.isConnected) {
        final response =
            await _remoteDataSource.getFeaturedBooks(pageNumber: pageNumber);
        if (response != null) {
          var books = response.map((e) => e.toDomain()).toList();
          _localDataSource.saveBooks(Constants.featuredBooksKey, books);
          return Right(books);
        } else {
          return Left(
              Failure(ApiInternalStatus.FAILURE, ResponseMessage.DEFAULT));
        }
      } else {
        return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
      }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<BookInfoModel>>> getNewestBooks(
      {int pageNumber = 0}) async {
    try {
      final data = _localDataSource.getNewestBooks(pageNumber: pageNumber);
      if (data.isNotEmpty) {
        return Right(data);
      }
        final response =
            await _remoteDataSource.getNewestBooks(pageNumber: pageNumber);
        if (response != null) {
          var books = response.map((e) => e.toDomain()).toList();
          _localDataSource.saveBooks(Constants.newestBooksKey, books);
          return Right(books);
        } else {
          return Left(
              Failure(ApiInternalStatus.FAILURE, ResponseMessage.DEFAULT));
        }
    } catch (error) {
      return Left(ErrorHandler.handle(error).failure);
    }
  }

  @override
  Future<Either<Failure, List<BookInfoModel>>> getSearchedBooks(
      String searchedBook,
      {int pageNumber = 0}) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getSearchedBooks(searchedBook,
            pageNumber: pageNumber);
        if (response != null) {
          return Right(response.map((e) => e.toDomain()).toList());
        } else {
          return Left(
              Failure(ApiInternalStatus.FAILURE, ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
