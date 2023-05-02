import 'package:bookly_app/data/network/app_api.dart';
import 'package:bookly_app/data/responses/responses.dart';

abstract class RemoteDataSource {
  Future<List<BaseBookResponse>?> getFeaturedBooks({int pageNumber = 0});
  Future<List<BaseBookResponse>?> getNewestBooks({int pageNumber = 0});
  Future<List<BaseBookResponse>?> getSearchedBooks(String searchedBook , {int pageNumber = 0});
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<List<BaseBookResponse>?> getFeaturedBooks({int pageNumber = 0}) async {
    return await _appServiceClient.getFeaturedBooks(pageIndex: pageNumber);
  }

  @override
  Future<List<BaseBookResponse>?> getNewestBooks({int pageNumber = 0}) async {
    return await _appServiceClient.getNewestBooks(pageIndex: pageNumber);
  }

  @override
  Future<List<BaseBookResponse>?> getSearchedBooks(String searchedBook , {int pageNumber = 0}) async {
    return await _appServiceClient.getSearchedBooks(searchedBook , pageIndex: pageNumber);
  }
}
