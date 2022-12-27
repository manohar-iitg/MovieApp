import 'package:firebase_project/description_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchRes extends StatelessWidget {
  final List searcher;
  const SearchRes({Key? key, required this.searcher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('MOVIE APP',
            style: GoogleFonts.montserrat(
                fontSize: 30, fontWeight: FontWeight.bold)),
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
          child: ListView.builder(
            itemCount: searcher.length,
            itemBuilder: (context, index) {
              String img = searcher[index]['poster_path'] != null
                  ? "https://image.tmdb.org/t/p/w500${searcher[index]['poster_path']}"
                  : 'https://www.prokerala.com/movies/assets/img/no-poster-available.webp';
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Description(
                                name: searcher[index]['title'] ??
                                    searcher[index]['original_title'],
                                bannerurl: searcher[index]['backdrop_path'] !=
                                        null
                                    ? 'https://image.tmdb.org/t/p/w500${searcher[index]['backdrop_path']}'
                                    : 'https://www.prokerala.com/movies/assets/img/no-poster-available.webp',
                                posterurl: img,
                                description: searcher[index]['overview'],
                                vote:
                                    searcher[index]['vote_average'].toString(),
                                launch_on: searcher[index]['release_date'] ??
                                    searcher[index]['first_air_date'],
                              )));
                },
                child: Container(
                  height: 150,
                  child: Row(
                    children: [
                      Container(
                        height: 150,
                        alignment: Alignment.centerLeft,
                        child: Card(
                          child: Image.network(img),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              searcher[index]['title'] ??
                                  searcher[index]['original_title'],
                              style: GoogleFonts.ubuntu(
                                  color: Colors.white, fontSize: 20),
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              );
            },
          )),
    );
  }
}
