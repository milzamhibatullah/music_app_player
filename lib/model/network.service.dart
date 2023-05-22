import 'dart:async';

import 'package:http/http.dart' as http;

class NetworkService{
  final String _baseUrl = 'https://itunes.apple.com/';
  ///set timeout duration
  final int _duration = 45;

  ///create method get data
   get({required endpoint}) async {
    try {
      final response = await http
          .get(
        Uri.parse(_baseUrl + endpoint),
      )
          .timeout(
        Duration(seconds: _duration),
      );
      // print(response.body);
      if(response.statusCode==200){
        return response.body;
      }else{
        return false;
      }
    } on TimeoutException catch (e) {
      return false;
    }
  }
}

final networks = NetworkService();