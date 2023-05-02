
import 'package:hive/hive.dart';
part 'models.g.dart';

@HiveType(typeId: 0)
class BookInfoModel {
  @HiveField(1)
  final String id;
  @HiveField(2)
  final String title;
  @HiveField(3)
  final String author;
  @HiveField(4)
  final double averageRating;
  @HiveField(5)
  final String language;
  @HiveField(6)
  final String imageLink;
  @HiveField(7)
  final String previewLink;
  @HiveField(8)
  final int pageCount;

  BookInfoModel(this.id, this.title, this.author, this.averageRating,
      this.language, this.imageLink, this.previewLink, this.pageCount);
}
