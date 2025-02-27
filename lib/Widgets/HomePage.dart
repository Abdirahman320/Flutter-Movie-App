import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:onstream/Widgets/Standard_genre.dart';

class HomePage extends StatefulWidget {
  HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Map<String, dynamic>> movie;
  Future<Map<String, dynamic>> getPopularMovies() async {
    try {
      final res1 = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/popular?api_key=29667ec8d34ba1a03724f218ad12dd43',
        ),
      );
      final res2 = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=29667ec8d34ba1a03724f218ad12dd43',
        ),
      );

      if (res1.statusCode != 200 && res2.statusCode != 200) {
        throw 'An unexpected error occurred';
      }

      final data1 = jsonDecode(res1.body);
      final data2 = jsonDecode(res2.body);

      return {
        'popular': data1,
        'trending': data2,
      };
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    movie = getPopularMovies();
    super.initState();
  }

  int indexPopular = 0;

  @override
  Widget build(BuildContext context) {
    double widthSize = MediaQuery.of(context).size.width;
    return FutureBuilder(
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

        final data1 = snapshot.data!['popular'];
        final popular = data1['results'];
        final data2 = snapshot.data!['trending'];
        final trending = data2['results'];
        return SingleChildScrollView(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text("Trending "),
                    SizedBox(width: 20),
                    Text("Popular "),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              CarouselSlider.builder(
                itemCount: popular.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image(
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          "https://image.tmdb.org/t/p/w500/${popular[index]["poster_path"]}",
                        ),
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  height: 350,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 0.6,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                      indexPopular = index;
                    });
                  },
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                popular[indexPopular]['title'],
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                getGenres(popular[indexPopular]['genre_ids']),
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    const Column(
                      children: [
                        Icon(Icons.info_outline),
                        Text("Detail"),
                      ],
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 203, 245, 53),
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: const Size(220, 55)),
                      onPressed: () {},
                      child: const Text(
                        "WATCH NOW ",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16),
                      ),
                    ),
                    const SizedBox(
                      width: 17,
                    ),
                    const Column(
                      children: [
                        Icon(Icons.bookmark_outline),
                        Text("Add List"),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trending ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "View all",
                      style: TextStyle(color: Colors.green, fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                height: 135,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: trending.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Stack(
                            children: [
                              Container(
                                width: 125,
                                child: Image(
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/w500/${trending[index]["poster_path"]}"),
                                ),
                              ),
                              Positioned(
                                top: widthSize / 45,
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
                          )),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
