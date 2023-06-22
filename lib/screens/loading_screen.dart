import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
 import 'package:climate/services/weather.dart';
import 'location_screen.dart';



class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      requestLocationPermission();
    } else {
      getLocationData() ;
    }
  }

  void requestLocationPermission() async {
    final permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      getLocationData();
    } else {
      // Handle case when location permission is denied
      print('Location permission denied.');
    }
  }

  void getLocationData() async {
    WeatherModel weatherModel=new WeatherModel();
    var weatherdata=await weatherModel.getLocationWeathe();
    Navigator.push(context, MaterialPageRoute
      (builder: (context)=>LocationScreen(locationWeather:weatherdata)));


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitCircle(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
