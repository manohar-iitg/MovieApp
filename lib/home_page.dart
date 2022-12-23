import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/login_page.dart';
import 'package:firebase_project/movies.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:google_fonts/google_fonts.dart';

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

  loadmovies() async {
    TMDB tmdbLogs = TMDB(ApiKeys(apikey, readaccesstoken));
    logConfig:
    ConfigLogger(
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

  Widget build(BuildContext context) {
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginPage()));
                });
              },
              child: Text("SIGN OUT"))
        ],
        backgroundColor: Colors.black,
      ),
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.black, Colors.black54],
        )),
        child: ListView(
          children: [
            TrendingMovies(trending: trendingmovies),
            TopMovies(topmovie: topratedmovies),
            NowPlay(nowplaymv: nowplay),
          ],
        ),
      ),
    );
  }
}
