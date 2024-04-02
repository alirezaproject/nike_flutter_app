import 'package:nike/features/product/domain/entities/comment_entity.dart';

import 'author.dart';

class CommentModel extends CommentEntity {
  final int id;
  final String title;
  final String content;
  final String date;
  final Author? author;

  CommentModel({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.author,
  }) : super(author: author, id: id, title: title, content: content, date: date);

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        id: json['id'] as int,
        title: json['title'] as String,
        content: json['content'] as String,
        date: json['date'] as String,
        author: json['author'] == null ? null : Author.fromJson(json['author'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
        'date': date,
        'author': author?.toJson(),
      };
}
