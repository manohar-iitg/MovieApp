import 'package:firebase_project/description_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TrendingMovies extends StatelessWidget {
  final List trending;
  const TrendingMovies({Key? key, required this.trending}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Trending Movies & Shows",
              style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 26)),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 265,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: trending.length,
                itemBuilder: (context, index) {
                  String title = trending[index]['title'] ?? trending[index]['original_name'];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                    name: title,
                                    bannerurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            trending[index]['backdrop_path'],
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            trending[index]['poster_path'],
                                    description: trending[index]['overview'],
                                    vote: trending[index]['vote_average']
                                        .toString(),
                                    launch_on:
                                        trending[index]['release_date'] ?? trending[index]['first_air_date'],
                                  )));
                    },
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            trending[index]['poster_path']))),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(title,
                                style:
                                    GoogleFonts.ubuntu(color: Colors.white70)),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class TopMovies extends StatelessWidget {
  final List topmovie;
  const TopMovies({Key? key, required this.topmovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Top Rated Movies",
              style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 26)),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 265,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: topmovie.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                    name: topmovie[index]['title'] ?? topmovie[index]['original_name'],
                                    bannerurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            topmovie[index]['backdrop_path'],
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            topmovie[index]['poster_path'],
                                    description: topmovie[index]['overview'],
                                    vote: topmovie[index]['vote_average']
                                        .toString(),
                                    launch_on: topmovie[index]['release_date'],
                                  )));
                    },
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            topmovie[index]['poster_path']))),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(
                                topmovie[index]['title'] ?? topmovie[index]['original_name'],
                                style:
                                    GoogleFonts.ubuntu(color: Colors.white70)),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}

class NowPlay extends StatelessWidget {
  final List nowplaymv;
  const NowPlay({Key? key, required this.nowplaymv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Now Playing",
              style: GoogleFonts.ubuntu(color: Colors.white, fontSize: 26)),
          const SizedBox(
            height: 5,
          ),
          Container(
            height: 265,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: nowplaymv.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Description(
                                    name: nowplaymv[index]['title'] ?? nowplaymv[index]['original_name'],
                                    bannerurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            nowplaymv[index]['backdrop_path'],
                                    posterurl:
                                        'https://image.tmdb.org/t/p/w500' +
                                            nowplaymv[index]['poster_path'],
                                    description: nowplaymv[index]['overview'],
                                    vote: nowplaymv[index]['vote_average']
                                        .toString(),
                                    launch_on: nowplaymv[index]['release_date'],
                                  )));
                    },
                    child: Container(
                      width: 140,
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w500' +
                                            nowplaymv[index]['poster_path']))),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(
                                nowplaymv[index]['title'] ?? nowplaymv[index]['original_name'],
                                style:
                                    GoogleFonts.ubuntu(color: Colors.white70)),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
