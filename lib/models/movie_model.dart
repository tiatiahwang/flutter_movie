class MovieModel {
  final int id;
  final String title, poster, bg;

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        poster = json['backdrop_path'] ?? 'NO',
        bg = json['poster_path'] ?? 'NO';
}
