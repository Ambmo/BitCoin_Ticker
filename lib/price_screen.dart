import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
// import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton androidDropDownItem() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (String currency in currenciesList) {
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(item);
    }

    return DropdownButton(
      value: selectedCurrency,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          print(value);
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> cupertinoItems = [];
    for (String currency in currenciesList) {
      var item = Text(currency);
      cupertinoItems.add(item);
    }

    return CupertinoPicker(
        itemExtent: 32.0,
        onSelectedItemChanged: (selectedIndex) async {
          String noteValue = currenciesList[selectedIndex];
          String crypto = cryptoList[0]; //for BTC
          //for ETH
          var data =
              await coinData.getData(noteValue: noteValue, crypto: crypto);
          updateUI(data);

          String crypto2 = cryptoList[1];
          var dataETH =
              await coinData.getData(noteValue: noteValue, crypto: crypto2);
          updateUIETH(dataETH);
          String crypto3 = cryptoList[2];
          var dataLTC =
              await coinData.getData(noteValue: noteValue, crypto: crypto3);
          updateUILTC(dataLTC);
        },
        children: cupertinoItems);
  }

  CoinData coinData = CoinData();

  int rate;
  int rateETH;
  String currency;
  String currencyETH;
  int rateLTC;
  String currencyLTC;
  // String crypto;

  // Future<void> getData({String noteValue, String crypto}) async {
  //   String url =
  //       "https://rest.coinapi.io/v1/exchangerate/$crypto/$noteValue?$api2";
  //
  //   http.Response response = await http.get(url);
  //
  //   if (response.statusCode == 200) {
  //     String data = response.body;
  //     var decodedData = jsonDecode(data);
  //     double rate2 = decodedData['rate'];
  void updateUI(dynamic data) {
    setState(() {
      double rate2 = data['rate'];
      rate = rate2.toInt();
      // crypto = coinData.decodedData['asset_id_base'];
      currency = coinData.decodedData['asset_id_quote'];
    });
    print('rateBTC = $rate');
  }

  void updateUIETH(dynamic data) {
    setState(() {
      double rate = data['rate'];
      rateETH = rate.toInt();
      currencyETH = coinData.decodedData['asset_id_quote'];
    });
    print('rateETH = $rateETH');
  }

  void updateUILTC(dynamic data) {
    setState(() {
      double rate = data['rate'];
      rateLTC = rate.toInt();
      currencyLTC = coinData.decodedData['asset_id_quote'];
      // crypto = coinData.decodedData['asset_id_base'];
    });
    print('rateLTC = $rateLTC');
  }

  //   } else {
  //     print('error getting data: ${response.statusCode}');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    // var data = coinData.getData(noteValue: 'AUD', crypto: 'BTC');
    /* getData(
        noteValue: 'AUD', crypto: 'ETH');// for initial values on first build*/
    //  updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('🤑 Coin Ticker')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $rate $currency',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH =  $rateETH   $currencyETH',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC =  $rateLTC    $currencyLTC',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: iOSPicker(),
            // Platform.isIOS ? iOSPicker() : androidDropDownItem(),
          ),
        ],
      ),
    );
  }
}
