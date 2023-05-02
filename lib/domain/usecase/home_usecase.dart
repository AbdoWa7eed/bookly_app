import 'package:bookly_app/data/network/failure.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:bookly_app/domain/repository/repository.dart';
import 'package:bookly_app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class GetFeaturedBooksUseCase implements BaseUseCase<int, List<BookInfoModel>> {
  final Repository _repository;

  GetFeaturedBooksUseCase(this._repository);
  @override
  Future<Either<Failure, List<BookInfoModel>>> execute(
      [int pageNumber = 0]) async {
    return _repository.getFeaturedBooks(pageNumber: pageNumber);
  }
}

class GetNewestBooksUseCase implements BaseUseCase<int, List<BookInfoModel>> {
  final Repository _repository;

  GetNewestBooksUseCase(this._repository);
  @override
  Future<Either<Failure, List<BookInfoModel>>> execute(
      [int pageNumber = 0]) async {
    return _repository.getFeaturedBooks(pageNumber: pageNumber);
  }
}
