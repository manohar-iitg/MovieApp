import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/login_page.dart';
import 'package:firebase_project/movies.dart';
import 'package:firebase_project/search_page.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List trendingmovies = [];
  List topratedmovies = [];
  List nowplay = [];

  final String apikey = '3376a18a481faea92be0a6cd7c14d413';
  final readaccesstoken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMzc2YTE4YTQ4MWZhZWE5MmJlMGE2Y2Q3YzE0ZDQxMyIsInN1YiI6IjYzYTU4YmIzMzg3NjUxMDBkMTg3NmU5MyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.-qvd-9qRqs_GFrfOju2DYc903MJTCAnUEJNLFDGGPPw';

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  List searcher = [];
  fetchresult(String reqmv) async {
    var url;
    url = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/search/movie?api_key=3376a18a481faea92be0a6cd7c14d413&language=en-US&query=$reqmv&page=1&include_adult=false)"));
    setState(() {
      searcher = json.decode(url.body)['results'];
    });
  }

  loadmovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(apikey, readaccesstoken));
    const ConfigLogger(
      showLogs: true,
      showErrorLogs: true,
    );
    Map trendingresult = await tmdbLogs.v3.trending.getTrending();
    Map topratedresult = await tmdbLogs.v3.movies.getTopRated();
    Map nowresult = await tmdbLogs.v3.movies.getNowPlaying();
    setState(() {
      trendingmovies = trendingresult['results'];
      topratedmovies = topratedresult['results'];
      nowplay = nowresult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchbar = TextEditingController();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('MOVIE APP',
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.bold)),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                });
              },
              child: const Text("SIGN OUT"))
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black, Colors.black54],
        )),
        child: ListView(
          children: [
            TextField(
              controller: _searchbar,
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
              ),
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.movie_filter_outlined,
                  color: Colors.white70,
                ),
                labelText: "Enter the Movie",
                labelStyle: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                ),
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white.withOpacity(0.3),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.black, width: 1),
                ),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(style: BorderStyle.none)),
              ),
            ),
            //ElevatedButton.icon(onPressed: (){fetchresult(_searchbar.text);}, icon: Icon(Icons.keyboard), label: Text("Enter")),
            ElevatedButton.icon(
              onPressed: () async {
                await fetchresult(_searchbar.text);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchRes(
                              searcher: searcher,
                            )));
              },
              icon: const Icon(Icons.search),
              label: const Text("Search for Movies"),
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.transparent),
            ),
            TrendingMovies(trending: trendingmovies),
            TopMovies(topmovie: topratedmovies),
            NowPlay(nowplaymv: nowplay),
          ],
        ),
      ),
    );
  }
}
