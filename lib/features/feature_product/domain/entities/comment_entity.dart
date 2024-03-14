import 'package:nike/features/feature_product/data/model/comment_model/author.dart';

class CommentEntity {
  final int id;
  final String title;
  final String content;
  final String date;
  final Author? author;

  CommentEntity(
      {required this.id,
      required this.title,
      required this.content,
      required this.date,
      required this.author});
}
