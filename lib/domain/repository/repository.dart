import 'package:bookly_app/data/network/failure.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, List<BookInfoModel>>> getFeaturedBooks({int pageNumber = 0});

  Future<Either<Failure, List<BookInfoModel>>> getNewestBooks({int pageNumber = 0});

  Future<Either<Failure, List<BookInfoModel>>> getSearchedBooks(String searchedBook , {int pageNumber = 0});

}
