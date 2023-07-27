import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task_flutter/constants/constant_text.dart';

class FeaturedTile extends StatelessWidget {
  String title;
  String imageUrl;
  FeaturedTile({required this.imageUrl, required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      width: 320,
      height: 305,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: Offset(1, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: CachedNetworkImageProvider(imageUrl,
              scale: 0.8, maxHeight: 500, maxWidth: 500),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              title,
              style: ConstantText.featuredTitle,
            ),
          ],
        ),
      ),
    );
  }
}
