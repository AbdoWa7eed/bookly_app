import 'package:bookly_app/app/di.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:bookly_app/domain/usecase/search_usecase.dart';
import 'package:bookly_app/presentation/search/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());
  final SearchUseCase _searchUseCase = instance<SearchUseCase>();
  bool isLoading = false;
  int pageNumber = 0;

  List<BookInfoModel>? searchedBooks;

  getSearchedData(
      {required String searchedBook, required int pageNumber}) async {
    emit(GetSearchedDataLoadingState());
    (await _searchUseCase.execute(SearchUseCaseInput(searchedBook, pageNumber)))
        .fold((failure) {
      emit(GetSearchedDataErrorState(failure.message));
    }, (searchedData) {
      if (searchedBooks == null) {
        searchedBooks = searchedData;
      } else {
        searchedBooks?.addAll(searchedData);
      }
      emit(GetSearchedDataSuccessState());
    });
  }
}
