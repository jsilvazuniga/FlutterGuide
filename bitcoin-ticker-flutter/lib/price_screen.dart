import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/services/exchange.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {


  String selectedCurrency = 'USD';
  ExchangeModel exchange = ExchangeModel();

  int rate;
  String asset_id_base;
  String asset_id_quote;
  String message;

  @override
  void initState()  {
    super.initState();
    getData();

  }

  void getData() async {
    try {
      var resultExchange = await exchange.getExchangeRate('BTC', selectedCurrency);
      setState(() {
        updateUI(resultExchange);
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownButton<String> androidDropdown() {

    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value)   {
        setState(()  {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker(){

    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);

      },
      children: pickerItems,
    );

  }

  Widget getPicker(){
    if(Platform.isIOS){
      return iOSPicker();
    }else {
      return androidDropdown();
    }
  }
  void updateUI(dynamic exchangeData){
    setState(() {
      if(exchangeData != null){
        /*print(weatherData); */
        double temp =  exchangeData["rate"];
        asset_id_base =  exchangeData["asset_id_base"];
        asset_id_quote =  exchangeData["asset_id_quote"];
        message = "";
        rate = temp.toInt();
      }else{
        rate = 0;
        message = "unable to get exchange data";
        asset_id_base = "";
        asset_id_quote = "";
        return;
      }

    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 $asset_id_base = $rate $asset_id_quote',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: getPicker()
          ),
        ],
      ),
    );
  }
}
