import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_project_1/widgets/movie_details_main_info_widget.dart';

class MovieDetailsWidget extends StatefulWidget {
  final int movieId;
  const MovieDetailsWidget({super.key, required this.movieId});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Name."),
      ),
      body: ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1),
        child: ListView(
          children: [
            MovieDetailsMainInfoWidget(),
          ],
        ),
      ),
    );
  }
}
