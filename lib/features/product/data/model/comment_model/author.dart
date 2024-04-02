class Author {
  String? email;

  Author({this.email});

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'email': email,
      };
}
