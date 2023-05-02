import 'package:bookly_app/app/di.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:bookly_app/domain/usecase/home_usecase.dart';
import 'package:bookly_app/presentation/home/cubit/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  final GetFeaturedBooksUseCase _featuredBooksUseCase =
      instance<GetFeaturedBooksUseCase>();
  final GetNewestBooksUseCase _newestBooksUseCase =
      instance<GetNewestBooksUseCase>();

  int featuredPageNumber = 0;
  int newestPageNumber = 0;
  bool isLoading = false;

  List<BookInfoModel>? featuredBooks;
  Future<void> getFeaturedBooks({int pageNumber = 0}) async {
    emit(GetFeaturedLoadingStates());
    (await _featuredBooksUseCase.execute(pageNumber)).fold((failure) {
      emit(GetFeaturedErrorStates(failure.message));
    }, (books) {
      if (featuredBooks == null) {
        featuredBooks = books;
      } else {
        featuredBooks?.addAll(books);
      }
      emit(GetFeaturedSuccessStates());
    });
  }

  List<BookInfoModel>? newestBooks;

  Future<void> getNewestBooks({int pageNumber = 0}) async {
    emit(GetNewestLoadingStates());
    (await _newestBooksUseCase.execute(pageNumber)).fold((failure) {
      emit(GetNewestErrorStates(failure.message));
    }, (books) {
      if (newestBooks == null) {
        newestBooks = books;
      } else {
        newestBooks?.addAll(books);
      }
      emit(GetNewestSuccessStates());
    });
  }

  Future<void> getInitialData() async {
    await getFeaturedBooks();
    await getNewestBooks();
  }

  List<BookInfoModel> getRecommendedList(BookInfoModel bookModel) {
    List<BookInfoModel> recommendedList = [];
    featuredBooks?.forEach((element) {
      if (element.id != bookModel.id) {
        recommendedList.add(element);
      }
    });

    return recommendedList;
  }
}
