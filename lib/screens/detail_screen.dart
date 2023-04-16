import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movie_detail_model.dart';
import 'package:flutter_movie/services/api_service.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DetailScreen extends StatefulWidget {
  final String bg;
  final int id;

  const DetailScreen({
    super.key,
    required this.bg,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiService.getMovieById(widget.id);
  }

  onButtonTap(String url) async {
    await launchUrlString(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                'back to list',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          )),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.network(
              'https://image.tmdb.org/t/p/w500/${widget.bg}',
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: const Color.fromRGBO(0, 0, 0, 0.5),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 200),
                    FutureBuilder(
                      future: movie,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List genres = [];
                          for (var genre in snapshot.data!.genres) {
                            genres.add(genre['name']);
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                snapshot.data!.title,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              IconTheme(
                                data: const IconThemeData(
                                  color: Colors.yellow,
                                  size: 24,
                                ),
                                child: StarDisplay(
                                    value: snapshot.data!.ratings / 2),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                children: [
                                  for (var genre in genres)
                                    Text(
                                      '$genre ',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 40),
                              const Text(
                                'Storyline',
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                snapshot.data!.overview,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 40),
                              GestureDetector(
                                onTap: () => onButtonTap(snapshot.data!.url),
                                child: Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 80,
                                      vertical: 15,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text('Buy ticket',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                ),
                              )
                            ],
                          );
                        }
                        return const Text('..');
                      },
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}

class StarDisplay extends StatelessWidget {
  final double value;
  const StarDisplay({super.key, this.value = 0});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < value ? Icons.star : Icons.star_border,
        );
      }),
    );
  }
}
