import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/base_card.dart';

@RoutePage()
class CoinDetailScreen extends StatefulWidget {
  String coinName;
  String coinImage;
  String marketCap;
  String priceUsd;
  CoinDetailScreen(
      {required this.coinImage,
      required this.coinName,
      required this.marketCap,
      required this.priceUsd});

  @override
  State<CoinDetailScreen> createState() => _CoinDetailScreenState();
}

class _CoinDetailScreenState extends State<CoinDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.coinName,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                child: CircleAvatar(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundImage: AssetImage(widget.coinImage),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BaseCard(
              child: Center(
                child: Text(
                  '${widget.priceUsd} \$',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            BaseCard(
              child: Column(
                children: [
                  _DataRow(
                    title: 'Hight 24 Hour',
                    value: '${widget.marketCap} \$',
                  ),
                  const SizedBox(height: 6),
                  _DataRow(
                    title: 'Low 24 Hour',
                    value: '${widget.marketCap} \$',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 140, child: Text(title)),
        const SizedBox(width: 32),
        Flexible(
          child: Text(value),
        ),
      ],
    );
  }
}
