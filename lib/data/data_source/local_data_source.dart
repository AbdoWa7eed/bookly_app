import 'package:bookly_app/app/constants.dart';
import 'package:bookly_app/domain/models/models.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalDataSource {
  Future<void> saveBooks(String boxKey, List<BookInfoModel> data);
  List<BookInfoModel> getFeaturedBooks({int pageNumber = 0});
  List<BookInfoModel> getNewestBooks({int pageNumber = 0});
}

class LocalDataSourceImpl implements LocalDataSource {
  @override
  Future<void> saveBooks(String boxKey, List<BookInfoModel> data) async {
    var box = Hive.box<BookInfoModel>(boxKey);
    await box.addAll(data);
  }

  @override
  List<BookInfoModel> getFeaturedBooks({int pageNumber = 0}) {
    var box = Hive.box<BookInfoModel>(Constants.featuredBooksKey);
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    int length = box.values.length;
    if (startIndex >= length || endIndex > length) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }

  @override
  List<BookInfoModel> getNewestBooks({int pageNumber = 0}) {
    var box = Hive.box<BookInfoModel>(Constants.newestBooksKey);
    int startIndex = pageNumber * 10;
    int endIndex = (pageNumber + 1) * 10;
    int length = box.values.length;
    if (startIndex >= length || endIndex > length) {
      return [];
    }
    return box.values.toList().sublist(startIndex, endIndex);
  }
}
