class MovieDetailModel {
  final int id;
  final String title, overview, url;
  final double ratings;
  final List genres;

  MovieDetailModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        overview = json['overview'],
        url = json['homepage'],
        ratings = json['vote_average'],
        genres = json['genres'];
}
