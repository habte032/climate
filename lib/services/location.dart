import 'package:geolocator/geolocator.dart';

class Location{
  var longitude;
  var latitude;

  Future<void>   getCurrentLocation() async{
      try {
        Position position = await Geolocator
            .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
        longitude=position.longitude;
        latitude=position.latitude;
      }
      catch(e){
        print(e);
      }

  }
}