import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:music_app_player/model/music/music.model.dart';

import '../network.service.dart';

class MusicApi {
  /// method to fetch coffee example with hot
  fetchMusic({term = ''}) async {
    try {
      ///validate endpoint set defaul to search "viral 2023"
      var endpoint = term.toString().isEmpty
          ? 'search?term=viral 2023&media=music'
          : 'search?term=$term&media=music';
     // print('endPont : $endpoint');
      final response = await networks.get(endpoint: endpoint);
     // print('refetch');
      if (response != false) {
        ///if success fetch decode to model class
        return MusicModel.fromJson(jsonDecode(response));
      } else {
        throw 'error';
      }
    } catch (e) {
      ///print when has error fetch data
      debugPrint('error fetch $e');
      throw 'error';
    }
  }
}
