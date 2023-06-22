import 'package:climate/services/location.dart';
import '../services/networking.dart';

const apiKey='';
const url='';

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
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
