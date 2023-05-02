import 'package:bookly_app/data/responses/responses.dart';
import 'package:dio/dio.dart';

const volumes = '/volumes';

abstract class AppServiceClient {
  Future<List<BaseBookResponse>> getFeaturedBooks({int pageIndex = 0});

  Future<List<BaseBookResponse>> getNewestBooks({int pageIndex = 0});

  Future<List<BaseBookResponse>> getSearchedBooks(String searchedBook,
      {int pageIndex = 0});
}

class AppServiceClientImpl implements AppServiceClient {
  final Dio _dio;
  AppServiceClientImpl(this._dio);
  @override
  Future<List<BaseBookResponse>> getFeaturedBooks({int pageIndex = 0}) async {
    var query = {
      'q': 'subject: programming',
      'Filtering': 'free-ebooks',
      'startIndex': pageIndex * 10
    };

    var response = await _dio.get(volumes, queryParameters: query);

    var data = List<BaseBookResponse>.from(response.data['items']
        .map((book) => BaseBookResponse.fromJson(book))
        .toList());
    return data;
  }

  @override
  Future<List<BaseBookResponse>> getNewestBooks({int pageIndex = 0}) async {
    var query = {
      'q': 'subject: programming',
      'Sorting': 'newest',
      'Filtering': 'free-ebooks',
      'startIndex': pageIndex * 10,
    };
    var response = await _dio.get(volumes, queryParameters: query);

    var data = List<BaseBookResponse>.from(response.data['items']
        .map((book) => BaseBookResponse.fromJson(book))
        .toList());

    return data;
  }

  @override
  Future<List<BaseBookResponse>> getSearchedBooks(String searchedBook,
      {int pageIndex = 0}) async {
    var response = await _dio.get(volumes, queryParameters: {
      'q': searchedBook,
      'Filtering': 'free-ebooks',
      'startIndex': pageIndex * 10,
    });

    var data = List<BaseBookResponse>.from(response.data['items']
        .map((book) => BaseBookResponse.fromJson(book))
        .toList());

    return data;
  }
}
