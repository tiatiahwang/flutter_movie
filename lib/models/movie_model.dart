class MovieModel {
  final int id;
  final String title, poster;

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        poster = json['backdrop_path'] ?? ' ';
}
