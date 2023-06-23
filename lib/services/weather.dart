import 'package:climate/services/location.dart';
import '../services/networking.dart';

const apiKey='';
const url='https://api.openweathermap.org/data/2.5/weather';


class WeatherModel {

    Future<dynamic> getCityWeather(String cityName)async{
      Network net=new Network('$url?q=$cityName&appid=$apiKey');
      var weatherdata=await net.getData();
      return weatherdata;

    }

  Future<dynamic> getLocationWeathe() async{
    Location location = Location();
    await location.getCurrentLocation();

    Network net=new Network('$url?'
        'lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey');

    var weatherdata=await net.getData();
    return weatherdata;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧  ';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

    String getMessage(double temp) {
      if (temp > 40) {
        return "It's extremely hot";
      } else if (temp > 30) {
        return "It's hot outside";
      } else if (temp > 25) {
        return "The weather is warm";
      } else if (temp > 20) {
        return "It's a pleasant day";
      } else if (temp > 15) {
        return "The weather is mild";
      } else if (temp > 10) {
        return "It's a cool day";
      } else if (temp >= 5) {
        return "It's chilly outside";
      } else {
        return "It's very cold";
      }
    }

}
