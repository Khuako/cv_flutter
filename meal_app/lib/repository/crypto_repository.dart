import 'dart:convert';

import 'package:http/http.dart';
import 'package:meal_app/model/crypto_prices.dart';

class CryptoRepository {
  Client client = Client();
  Future<CryptoPrices> fetchPricesList() async {
    final response = await client.get(Uri.parse(
        'https://api.coincap.io/v2/assets'));
    return CryptoPrices.fromJson(
      json.decode(response.body),
    );
  }
}
