// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_project_1/resources/resources.dart';
import 'package:flutter_project_1/widgets/auth_widget.dart';

class Movie {
  final int id;
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie(
      {required this.id,
      required this.imageName,
      required this.title,
      required this.time,
      required this.description});
}

class MovieListWidget extends StatefulWidget {
  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movie(
        id: 1,
        imageName: AppImages.yourname,
        title: "Your name",
        time: 'July 6,2016',
        description:
            'Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?'),
    Movie(
        id: 2,
        imageName: AppImages.yourname,
        title: "Kimetsu no Yaiba",
        time: 'July 6,2016',
        description:
            'Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?'),
    Movie(
        id: 3,
        imageName: AppImages.yourname,
        title: "Naruto",
        time: 'July 6,2016',
        description:
            'Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?'),
    Movie(
        id: 4,
        imageName: AppImages.yourname,
        title: "One Piece",
        time: 'July 6,2016',
        description:
            'Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?'),
    Movie(
        id: 5,
        imageName: AppImages.yourname,
        title: "Berserk",
        time: 'July 6,2016',
        description:
            'Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?'),
    Movie(
        id: 6,
        imageName: AppImages.yourname,
        title: "Bleach",
        time: 'July 6,2016',
        description:
            'Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?'),
  ];
  var _filteredMovies = <Movie>[];
  void _searchMovies() {
    final query = _searchController.text;
    if (query.isNotEmpty) {
      _filteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _filteredMovies = _movies;
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _filteredMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed('/main_screen/movie_details', arguments: id);
  }

  final _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 70),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _filteredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _filteredMovies[index];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.07),
                          offset: Offset(0, 2),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage(movie.imageName),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        // ignore: prefer_const_literals_to_create_immutables
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                movie.time,
                                style: TextStyle(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  ),
                  Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => _onMovieTap(index),
                      ))
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }
}
