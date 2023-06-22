import 'dart:convert';
import 'package:http/http.dart';



class Network{
  final String url;
  Network(this.url);


  Future getData() async {
    Response response = await get(Uri.parse(url));
    if(response.statusCode==200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      print(response.body);
      return decodeData;

    }else{
        print(response.statusCode);
    }

  }
}