import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:onstream/Widgets/Standard_genre.dart';

class TopRated extends StatefulWidget {
  const TopRated({super.key});

  @override
  State<TopRated> createState() => _TopRatedState();
}

class _TopRatedState extends State<TopRated> {
  late Future<Map<String, dynamic>> movie;
  Future<Map<String, dynamic>> getPopularMovies() async {
    try {
      final res = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=29667ec8d34ba1a03724f218ad12dd43',
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
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.arrow_back,
              ),
              hintText: "Search",
              suffixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
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
              final topRated = data['results'];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Top search",
                      style:
                          TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: topRated.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Container(
                                      height: 130,
                                      width: 90,
                                      child: Image(
                                        image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500/${topRated[index]["poster_path"]}",
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        topRated[index]['title'],
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        "Movie 2024 -",
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        getGenres(topRated[index]["genre_ids"]),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w300),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              );
            }));
  }
}
