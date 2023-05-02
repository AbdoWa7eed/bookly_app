import 'package:json_annotation/json_annotation.dart';
part 'responses.g.dart';

@JsonSerializable()
class BaseBookResponse {
  @JsonKey(name: "id")
  final String? id;
  @JsonKey(name:"volumeInfo")
  BookInfoResponse? volumeInfo;

  BaseBookResponse(this.id);
  factory BaseBookResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseBookResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseBookResponseToJson(this);
}

@JsonSerializable()
class BookInfoResponse {
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "authors")
  final List<String>? authors;
  @JsonKey(name: "averageRating")
  final double? averageRating;
  @JsonKey(name: "language")
  final String? language;
  @JsonKey(name: "imageLinks")
  final ImageLink? imageLink;
  @JsonKey(name: "previewLink")
  final String? previewLink;
  @JsonKey(name: "pageCount")
  final int? pageCount;

  BookInfoResponse(this.title, this.authors, this.averageRating, this.language,
      this.imageLink, this.previewLink, this.pageCount);

  factory BookInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$BookInfoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BookInfoResponseToJson(this);
}

@JsonSerializable()
class ImageLink {
  @JsonKey(name: "smallThumbnail")
  final String? smallImage;
  @JsonKey(name: "thumbnail")
  final String? normalImage;

  ImageLink(this.smallImage, this.normalImage);

  factory ImageLink.fromJson(Map<String, dynamic> json) =>
      _$ImageLinkFromJson(json);

  Map<String, dynamic> toJson() => _$ImageLinkToJson(this);
}
