import 'package:bookly_app/app/constants.dart';
import 'package:bookly_app/app/extensions.dart';
import 'package:bookly_app/data/responses/responses.dart';
import 'package:bookly_app/domain/models/models.dart';

extension BaseBookResponseMapper on BaseBookResponse {
  BookInfoModel toDomain() {
    return BookInfoModel(
        id.orEmpty(),
        volumeInfo?.title.orEmpty() ?? Constants.empty,
        volumeInfo?.authors?[0] ?? Constants.empty,
        volumeInfo?.averageRating.orZero() ?? Constants.zeroDouble,
        volumeInfo?.language.orEmpty() ?? Constants.empty,
        volumeInfo?.imageLink?.normalImage.orEmpty() ?? Constants.empty,
        volumeInfo?.previewLink.orEmpty() ?? Constants.empty,
        volumeInfo?.pageCount.orZero() ?? Constants.zeroInt);
  }
}
