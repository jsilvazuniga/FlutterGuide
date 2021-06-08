import 'package:bitcoin_ticker/config/configuration.dart';
import 'package:bitcoin_ticker/services/networking.dart';

class ExchangeModel {

  Future<dynamic> getExchangeRate(String currencyFrom, String currencyTo) async {
    String url = "$openExchangeRateURL/$currencyFrom/$currencyTo?apikey=$apiKey";

    print(url);

    NetworkHelper networkHelper = NetworkHelper(url);

    return await networkHelper.getData();
  }

}