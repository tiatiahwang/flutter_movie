import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movie_model.dart';
import 'package:flutter_movie/screens/detail_screen.dart';
import 'package:flutter_movie/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> populars = ApiService.getPopulars();
  final Future<List<MovieModel>> nowPlayings = ApiService.getNowPlayings();
  final Future<List<MovieModel>> comingSoons = ApiService.getComingSoon();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Popular Movies',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 220,
                child: FutureBuilder(
                  future: populars,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var movie = snapshot.data![index];
                          var url =
                              'https://image.tmdb.org/t/p/w500/${movie.poster}';
                          return PopularMovies(
                            url: url,
                            id: movie.id,
                            bg: movie.bg,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemCount: snapshot.data!.length,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Now in Cinemas',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: FutureBuilder(
                  future: nowPlayings,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var movie = snapshot.data![index];
                          var url =
                              'https://image.tmdb.org/t/p/w500/${movie.poster}';
                          return NowPlayingMovies(
                            url: url,
                            title: movie.title,
                            id: movie.id,
                            bg: movie.bg,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemCount: snapshot.data!.length,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Coming soon',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 280,
                child: FutureBuilder(
                  future: comingSoons,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var movie = snapshot.data![index];
                          var url =
                              'https://image.tmdb.org/t/p/w500/${movie.poster}';
                          return ComnigSoonMovies(
                            url: url,
                            title: movie.title,
                            id: movie.id,
                            bg: movie.bg,
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(width: 20),
                        itemCount: snapshot.data!.length,
                      );
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class ComnigSoonMovies extends StatelessWidget {
  final String url, bg, title;
  final int id;

  const ComnigSoonMovies({
    super.key,
    required this.url,
    required this.bg,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              bg: bg,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 150,
            height: 220,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            // clipBehavior: Clip.hardEdge,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    url,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NowPlayingMovies extends StatelessWidget {
  final String url, bg, title;
  final int id;

  const NowPlayingMovies({
    super.key,
    required this.url,
    required this.bg,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              bg: bg,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Container(
            width: 150,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(
                    url,
                    height: 150,
                    fit: BoxFit.fill,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PopularMovies extends StatelessWidget {
  final String bg;
  final int id;

  const PopularMovies({
    super.key,
    required this.url,
    required this.bg,
    required this.id,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              bg: bg,
              id: id,
            ),
          ),
        );
      },
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          url,
          // height: 200,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
