import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'currency.dart';

class HttpHelper {
  Future<Currency?> getCurrency() async {
    var client = http.Client();
    var url = Uri.parse('https://open.er-api.com/v6/latest/USD');
    http.Response result = await client.get(url);
    if (result.statusCode == HttpStatus.ok) {
      var json = result.body;
      return currencyFromJson(json);
    } else {
      return null;
    }
  }
}
