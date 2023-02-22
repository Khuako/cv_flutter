// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_project_1/Theme/app_colors.dart';
import 'package:flutter_project_1/resources/resources.dart';
import 'package:flutter_project_1/widgets/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TopPosterWidget(),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: _MovieNameWidget(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 70),
          child: _SummeryWidget(),
        ),
        _ScoreWidget(),
        SizedBox(
          height: 30,
        ),
        _DescrWidget(),
        SizedBox(
          height: 30,
        ),
        _PeopleWidgets(),
      ],
    );
  }
}

class _TopPosterWidget extends StatelessWidget {
  const _TopPosterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          AppImages.poster,
          fit: BoxFit.fitWidth,
          color: Colors.blue,
          colorBlendMode: BlendMode.color,
        ),
        Positioned(
          top: 50,
          left: 150,
          bottom: 30,
          child: Image(
            height: 225,
            width: 125,
            image: AssetImage(AppImages.yourname),
          ),
        ),
      ],
    );
  }
}

class _MovieNameWidget extends StatelessWidget {
  const _MovieNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      maxLines: 3,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Your Name.',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.85),
          ),
          TextSpan(
            text: ' (2016)',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: RadialPercentWidget(
                  child: Text(
                    '88',
                    style: TextStyle(color: Colors.blue),
                  ),
                  percent: 0.88,
                  fillColor: Color.fromARGB(255, 10, 23, 25),
                  lineColor: Color.fromARGB(255, 37, 203, 103),
                  freeColor: Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3),
            ),
            TextButton(
              onPressed: () {},
              child: Text('User Score'),
            ),
          ],
        ),
        Container(
          color: Colors.grey,
          width: 1,
          height: 15,
        ),
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              Icon(Icons.play_arrow),
              SizedBox(
                width: 5,
              ),
              Text('Play Trailer'),
            ],
          ),
        ),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Color.fromARGB(22, 12, 25, 1),
      child: Text(
        'PG, 28/12/2016 (FR) 1h 46m Romance, Animation, Drama',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
        maxLines: 2,
      ),
    );
  }
}

class _DescrWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return containterbox(
      child: Text(
        'Two strangers find themselves linked in a bizarre way. When a connection forms, will distance be the only thing to keep them apart?',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class containterbox extends StatelessWidget {
  final Widget child;
  containterbox({required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.mainDarkBlue,
          border: Border.all(),
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: child,
        ),
      ),
    );
  }
}

class _PeopleWidgets extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        containterbox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Makoto Shinkai',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Director',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Clark Cheng',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Writer',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
        containterbox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Makoto Shinkai',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Director',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Clark Cheng',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(
                height: 2,
              ),
              Text(
                'Writer',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
