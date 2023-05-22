
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app_player/model/music/music.model.dart';

import '../network.service.dart';

class MusicApi{
  /// method to fetch coffee example with hot
  fetchMusic({term=''})async{
    try{
      var endpoint = term.toString().isEmpty?'search?term=viral 2023&media=music':'search?term=$term&media=music';
      print('endPont : $endpoint');
      final response = await networks.get(endpoint: endpoint);
      print('refetch');
      if(response!=false){
        return MusicModel.fromJson(jsonDecode(response));
      }else{
        throw 'error';
      }

    }catch(e){
      debugPrint('error fetch '+e.toString());
      throw 'error';
    }
  }
}