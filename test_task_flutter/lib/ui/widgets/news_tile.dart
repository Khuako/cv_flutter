import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_task_flutter/constants/constant_text.dart';

class NewsTile extends StatelessWidget {
  String imageUrl;
  String title;
  String daysAgo;
  bool hasSeen;
  NewsTile(
      {required this.imageUrl,
      required this.title,
      required this.daysAgo,
      required this.hasSeen});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 7,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        width: 350,
        height: 120,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.fill,
                  width: 90,
                  height: 60,
                  maxHeightDiskCache: 400,
                  maxWidthDiskCache: 400,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: ConstantText.titleText,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${daysAgo} day ago',
                          style: ConstantText.greyText,
                        ),
                        hasSeen
                            ? Text(
                                'seen',
                                style: ConstantText.greyText,
                              )
                            : Container(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
