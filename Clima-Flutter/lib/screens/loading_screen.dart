import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:clima/services/weather.dart';
import 'package:clima/screens/location_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  double latitude;
  double longitud;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocationData();

  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    print("desactivating");
  }

  void getLocationData() async{

    var weatherData = await WeatherModel().getLocationWeather();

    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return LocationScreen(locationWeather: weatherData,); //opening screen
    }));

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        )
      ),
    );
  }
}