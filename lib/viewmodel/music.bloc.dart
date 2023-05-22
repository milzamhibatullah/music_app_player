import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_player/model/mixin/audio.mixin.dart';
import 'package:equatable/equatable.dart';
import 'package:music_app_player/model/music/music.api.dart';
import 'package:music_app_player/model/music/music.model.dart';

import '../model/music/music.state.dart';

class MusicBloc extends Cubit<MusicState> with AudioMixin {
  MusicBloc() : super(MusicInitialState());
  final player = AudioPlayer();
  StreamSubscription? status;
  StreamSubscription? iDuration;
  double? currentDuration;
  double? maxDuration;
  MusicModel? music;
  int? musicIndex;
  String search = '';
  var sampleUrlTrack = '';

  void init() async {
    await fetchSong();
    if(state is MusicLoadedState){
    }
    status?.cancel();
    status = player.playerStateStream.listen((playerState) {
      final ProcessingState processingState = playerState.processingState;
      print('processing state $processingState');
      switch (processingState) {
        case ProcessingState.ready:
          player.positionStream.listen((event) {
            playerState.playing
                ? emit(
              MusicOnPlayState(
                  currentDuration: event,
                  maxDuration:
                  player.duration!),
            )
                : emit(MusicOnPauseState());
          });
          break;
        case ProcessingState.completed:
          stop(index: musicIndex);
          emit(MusicOnStopState());
          break;
        default:
          emit(MusicOnStopState());
          break;
      }
    });



  }

  Future<void> fetchSong() async {
    try {
      final api = MusicApi();
      emit(MusicLoadingState());
      music = await api.fetchMusic(term: search);
      Future.delayed(const Duration(milliseconds: 100), () => emit(MusicLoadedState()));
    } catch (e) {
      emit(MusicLoadedErrorState());
    }
  }

  @override
  void nextSkip() {}

  @override
  void previousSkip() {}

  @override
  void stop({index}) async {
    musicIndex = index;
    await player.stop();
  }

  @override
  void seekTo() async {
    await player.seek(player.position);
    await player.play();
  }

  @override
  void pause() async {
    await player.pause();
    //updatePosition();
  }

  @override
  void play({stateIndex, index}) async {
    print('state : $state');
    player.setUrl(sampleUrlTrack);
    await player.play();
  }
}
