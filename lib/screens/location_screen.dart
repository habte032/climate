import 'package:flutter/material.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';

class LocationScreen extends StatefulWidget {

  final locationWeather;
  LocationScreen({required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=new WeatherModel();
  late double temp;
  late String city;
  late String weatherIcon;
  late String message;

@override
  void initState() {
    super.initState();
    update(widget.locationWeather);
  }
  void update(dynamic weatherdata){
     setState(() {
       if(weatherdata==null){
         temp=18.2;
         city='Adiss Ababa';
         weatherIcon='☁️';
         message='You\'ll need 🧣 and 🧤';
       }
      else{
         temp=weatherdata['main']['temp'];
         temp=temp-273.15;
         temp=double.parse(temp.toStringAsFixed(1));
         var condition=weatherdata['weather'][0]['id'];
         city=weatherdata['name'];
         print(temp);
         weatherIcon=weather.getWeatherIcon(condition);
         message=weather.getMessage(temp);
       }
     });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      setState(() {
                        var weatherdata=weather.getLocationWeathe();
                        update(weatherdata);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$weatherIcon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$message in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// double temp=decodeData['main']['temp'];
// int condition=decodeData['weather'][0]['id'];
// String city=decodeData['name'];
// print(city);
// print(temp);
// print(condition);