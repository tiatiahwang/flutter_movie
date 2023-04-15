// 가장 인기 있는 영화: https://movies-api.nomadcoders.workers.dev/popular
// 극장에서 상영 중인 영화: https://movies-api.nomadcoders.workers.dev/now-playing
// 곧 개봉하는 영화: https://movies-api.nomadcoders.workers.dev/coming-soon
// 영화에 대한 세부 정보: https://movies-api.nomadcoders.workers.dev/movie?id=1

import 'package:http/http.dart' as http;

class ApiService {
  final String baseURL = 'https://movies-api.nomadcoders.workers.dev';
  final String popular = 'popular';
  final String nowPlaying = 'now-playing';
  final String comingSoon = 'coming-soon';

  void getPopulars() async {
    final url = Uri.parse('$baseURL/$popular');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.body);
      return;
    }
    throw Error();
  }
}
