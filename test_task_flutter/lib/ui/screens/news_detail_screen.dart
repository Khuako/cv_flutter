import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task_flutter/constants/constant_text.dart';
import 'package:test_task_flutter/model/news_model.dart';

import '../../cubit/news_cubit.dart';

@RoutePage()
class NewsDetailScreen extends StatefulWidget {
  News news;
  NewsDetailScreen({required this.news});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Stack(children: [
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset: Offset(1, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      child: CachedNetworkImage(
                        width: double.maxFinite,
                        height: 400,
                        imageUrl: widget.news.imageUrl!,
                        maxHeightDiskCache: 800,
                        maxWidthDiskCache: 800,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 300,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: 700,
                    height: 300,
                    child: Text(
                      widget.news.title!,
                      style: ConstantText.featuredTitle,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 50,
                  child: Row(
                    children: [
                      IconButton(
                        iconSize: 35,
                        onPressed: () {
                          AutoRouter.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.news.description!,
                style: ConstantText.titleText,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: CachedNetworkImage(
                  placeholder: (context, url) {
                    return Center(
                      child: CircularProgressIndicator(color: Colors.black),
                    );
                  },
                  width: double.maxFinite,
                  height: 280,
                  imageUrl:
                      'https://mykaleidoscope.ru/x/uploads/posts/2022-09/1663141551_1-mykaleidoscope-ru-p-belorussiya-minsk-krasivo-1.jpg',
                  maxHeightDiskCache: 800,
                  maxWidthDiskCache: 800,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
