import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../services/weather.dart';
import '../utilities/constants.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {

  final locationWeather;
  LocationScreen({required this.locationWeather});

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather=new WeatherModel();
  late double temp;
  late String cityName;
  late String country;
  late String weatherIcon;
  late String message;
   var description;
   var icon;

@override
  void initState() {
    super.initState();
    update(widget.locationWeather);
  }
  void update(dynamic weatherdata){
     setState(() {
       if(weatherdata==null){
         temp=18.2;
         cityName='Adiss Ababa';
         weatherIcon='';
         message='';
         description='';
         country='ET';
       }
      else{
         description=weatherdata['weather'][0]['description'];
         icon=weatherdata['weather'][0]['icon'];
         temp=weatherdata['main']['temp'];
         temp=temp-273.15;
         temp=double.parse(temp.toStringAsFixed(1));
         var condition=weatherdata['weather'][0]['id'];
         cityName=weatherdata['name'];
         country=weatherdata['sys']['country'];
        // print(temp);
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
            image: AssetImage('images/location_background.png'),
            fit: BoxFit.fill,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextButton(
                      onPressed: () async{
                          var weatherdata= await weather.getLocationWeathe();
                          update(weatherdata);

                      },
                      child: Icon(
                        FontAwesomeIcons.locationArrow,
                        color: Color(0xffd1ac9a),
                        size: 50.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: ()async {
                       var typedName= await Navigator.push(context, MaterialPageRoute(builder:
                        (context)=>CityScreen()));
                       if(typedName!=null){
                         var weatherdata=await  weather.getCityWeather(typedName);
                         update(weatherdata);
                       }
                      },
                      child: Icon(
                        Icons.location_city_outlined,
                        color: Color(0xffd1ac9a),
                        size: 50.0,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 100,),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "$temp",
                        style: kTempTextStyle
                      ),
                      TextSpan(text: " "),
                      TextSpan(
                        text: "$weatherIcon",
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Text(
                  '$cityName, $country',style: TextStyle(fontSize: 35),
                ),
              ),
              SizedBox(height: 100,),
              Padding(
                padding: EdgeInsets.all( 15.0),
                child: Text(
                  "$message and there is $description in $cityName!",
                  textAlign: TextAlign.center,
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

