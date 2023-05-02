import 'package:bookly_app/data/network/failure.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:bookly_app/domain/repository/repository.dart';
import 'package:bookly_app/domain/usecase/base_usecase.dart';
import 'package:dartz/dartz.dart';

class SearchUseCase
    implements BaseUseCase<SearchUseCaseInput, List<BookInfoModel>> {
  final Repository _repository;

  SearchUseCase(this._repository);
  @override
  Future<Either<Failure, List<BookInfoModel>>> execute(SearchUseCaseInput searchInput) async {
    return _repository.getSearchedBooks(searchInput.searchedBook,
        pageNumber: searchInput.pageNumber);
  }
}

class SearchUseCaseInput {
  final String searchedBook;
  final int pageNumber;

  SearchUseCaseInput(this.searchedBook, this.pageNumber);
}
