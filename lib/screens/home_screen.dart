import 'package:flutter/material.dart';
import 'package:flutter_movie/models/movie_model.dart';
import 'package:flutter_movie/services/api_service.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<MovieModel>> populars = ApiService.getPopulars();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FutureBuilder(
          future: populars,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const Text(
                    'Popular Movies',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: makePopularList(snapshot),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  ListView makePopularList(AsyncSnapshot<List<MovieModel>> snapshot) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var popular = snapshot.data![index];
        var posterUrl = 'https://image.tmdb.org/t/p/w500/${popular.poster}';
        return Column(
          children: [
            Container(
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              clipBehavior: Clip.hardEdge,
              child: Image.network(
                posterUrl,
                height: 200,
                fit: BoxFit.fill,
              ),
            ),
          ],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
