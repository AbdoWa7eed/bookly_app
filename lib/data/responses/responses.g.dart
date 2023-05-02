// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseBookResponse _$BaseBookResponseFromJson(Map<String, dynamic> json) =>
    BaseBookResponse(
      json['id'] as String?,
    )..volumeInfo = json['volumeInfo'] == null
        ? null
        : BookInfoResponse.fromJson(json['volumeInfo'] as Map<String, dynamic>);

Map<String, dynamic> _$BaseBookResponseToJson(BaseBookResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'volumeInfo': instance.volumeInfo,
    };

BookInfoResponse _$BookInfoResponseFromJson(Map<String, dynamic> json) =>
    BookInfoResponse(
      json['title'] as String?,
      (json['authors'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['averageRating'] as num?)?.toDouble(),
      json['language'] as String?,
      json['imageLinks'] == null
          ? null
          : ImageLink.fromJson(json['imageLinks'] as Map<String, dynamic>),
      json['previewLink'] as String?,
      json['pageCount'] as int?,
    );

Map<String, dynamic> _$BookInfoResponseToJson(BookInfoResponse instance) =>
    <String, dynamic>{
      'title': instance.title,
      'authors': instance.authors,
      'averageRating': instance.averageRating,
      'language': instance.language,
      'imageLinks': instance.imageLink,
      'previewLink': instance.previewLink,
      'pageCount': instance.pageCount,
    };

ImageLink _$ImageLinkFromJson(Map<String, dynamic> json) => ImageLink(
      json['smallThumbnail'] as String?,
      json['thumbnail'] as String?,
    );

Map<String, dynamic> _$ImageLinkToJson(ImageLink instance) => <String, dynamic>{
      'smallThumbnail': instance.smallImage,
      'thumbnail': instance.normalImage,
    };
