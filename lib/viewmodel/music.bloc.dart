import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:music_app_player/model/mixin/audio.mixin.dart';

import 'package:music_app_player/model/music/music.api.dart';
import 'package:music_app_player/model/music/music.model.dart';

import '../model/music/music.state.dart';

class MusicBloc extends Cubit<MusicState> {
  MusicBloc() : super(MusicInitialState());
  String? _search;

  void setSearch(String term) => _search = term;

  void init() async {
    ///initial song fetch at the geginning
    await fetchSong();
  }

  ///fetch stong function
  Future<void> fetchSong() async {
    try {
      final api = MusicApi();
      emit(MusicLoadingState());
      final music = await api.fetchMusic(term: _search);
      Future.delayed(const Duration(milliseconds: 100),
          () => emit(MusicLoadedState(music)));
    } catch (e) {
      emit(MusicLoadedErrorState());
    }
  }

  ///set selected music display to detail
  void setSelectedMusic(DataMusic model) {
    try {
      state.dataMusic = model;
    } catch (e) {
      throw 'error when select music $e';
    }
  }

}
