import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {
  late Future<Map<String, dynamic>> movie;
  Future<Map<String, dynamic>> getPopularMovies() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=29667ec8d34ba1a03724f218ad12dd43',
        ),
      );

      if (res.statusCode != 200) {
        throw 'An unexpected error occurred';
      }

      final data1 = jsonDecode(res.body);

      return data1;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    movie = getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder(
        future: movie,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          final data = snapshot.data!;
          final trending = data['results'];
          return Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Latest ",
                    style: TextStyle(color: Colors.green, fontSize: 18),
                  ),
                  Text(
                    "Trending ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "popular ",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "filter ",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Stack(
                children: [
                  GridView.builder(
                    itemCount: trending.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 0.7,
                    ),
                    itemBuilder: (context, index) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Stack(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 5,
                                  vertical: 5,
                                ),
                                width: 180,
                                child: Image(
                                  image: NetworkImage(
                                    "https://image.tmdb.org/t/p/w500/${trending[index]["poster_path"]}",
                                  ),
                                ),
                              ),
                              Positioned(
                                top: widthSize / 45,
                                left: 17,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(7),
                                  child: Container(
                                    width: 33,
                                    height: 20,
                                    color: Colors.black.withOpacity(0.5),
                                    child: const Center(
                                        child: Text(
                                      "HD",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ),
                              ),
                            ],
                          ));
                    },
                  ),
                ],
              ))
            ],
          );
        },
      ),
    );
  }
}
