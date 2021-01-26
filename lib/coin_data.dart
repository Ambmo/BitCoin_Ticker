import 'package:http/http.dart' as http;
import 'dart:convert';

const api = 'apikey=A3460786-4961-4F13-BCEB-2D8E756248CF';
const api2 = 'apikey=4A46E0E5-2BD6-446F-9FC0-ECD43BDB3A42';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

class CoinData {
  // String selectedNote;
  // CoinData({this.selectedNote});

  var decodedData;

  Future<dynamic> getData({String noteValue, String crypto}) async {
    String url =
        "https://rest.coinapi.io/v1/exchangerate/$crypto/$noteValue?$api2";

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String data = response.body;
      decodedData = jsonDecode(data);
    } else {
      print('error getting data: ${response.statusCode}');
    }
    return decodedData;
  }
}
