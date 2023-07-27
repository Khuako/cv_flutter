import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:meal_app/router/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class ValueWidget extends StatelessWidget {
  String valueName;
  String valueImage;
  String valueDollar;
  String explorerLink;
  String marketCap;
  ValueWidget(
      {required this.valueName,
      required this.valueDollar,
      required this.valueImage,
      required this.explorerLink,
      required this.marketCap});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: IconButton(
        onPressed: () {
          AutoRouter.of(context).push(CoinDetailRoute(
              coinImage: valueImage,
              coinName: valueName,
              marketCap: marketCap,
              priceUsd: valueDollar));
        },
        icon: Icon(Icons.arrow_forward_ios_rounded),
      ),
      title: Text(
        valueName,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          '${valueDollar} \$',
          style: TextStyle(color: Colors.grey),
        ),
        GestureDetector(
          onTap: () async {
            final Uri uri = Uri.parse(explorerLink);
            if (!await launchUrl(uri)) {
              throw Exception('Could not launch $uri');
            }
          },
          child: Text(
            '${explorerLink}',
            style: TextStyle(color: Colors.blue),
            maxLines: 1,
          ),
        ),
      ]),
      leading: Container(
        width: 60,
        height: 60,
        child: CircleAvatar(
          backgroundColor: ThemeData.dark().dialogBackgroundColor,
          foregroundImage: AssetImage(valueImage),
        ),
      ),
    );
  }
}
