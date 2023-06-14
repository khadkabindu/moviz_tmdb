class Movie {
  final String title;
  final String imageUrl;
  final String description;

  Movie({
    required this.title,
    required this.imageUrl,
    required this.description,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      imageUrl: json['poster_path'],
      description: json['overview'],
    );
  }
}
