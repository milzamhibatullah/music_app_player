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
  ///initiate audio player
  final _player = AudioPlayer();
  ///create stream subscription
  StreamSubscription? status;
  /// create observable duration
  Duration? currentDuration;
  Duration? maxDuration;
  ///observable music model
  MusicModel? music;
  ///obervable index of music
  int? musicIndex;
  /// observable search parameter and set default to empty
  String search = '';
  /// observable track music url
  var trackPreviewUrl = '';

  void init() async {
    ///initial song fetch at the geginning
    await fetchSong();
    /// dispose subscription first to prevent crash
    status?.cancel();
    /// inititate subscription to as audio player stream
    status = _player.playerStateStream.listen((playerState) {
      ///get processing state audio
      final ProcessingState processingState = playerState.processingState;
      // print('processing state $processingState');
      ///validate processing state
      switch (processingState) {
        case ProcessingState.ready:
          ///if audio process is ready listen the position current duration
          _player.positionStream.listen((event) {
            playerState.playing
                ? emit(
              MusicOnPlayState(
                  currentDuration: event,
                  maxDuration:
                  _player.duration!),
            )
                : emit(MusicOnPauseState());
          });
          break;
          ///if proccess is complete stop the audio preccess
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

  ///fetch stong function
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

  ///this function to skip next music
  @override
  void nextSkip() async{
    _player.setUrl(trackPreviewUrl);
    await _player.play();
  }
  ///this function to skip previous music
  @override
  void previousSkip() async{
    _player.setUrl(trackPreviewUrl);
    await _player.play();
  }

  ///this function to stop music
  @override
  void stop({index}) async {
    musicIndex = index;
    await _player.stop();
  }

  ///this function to seek music
  @override
  void seekTo({position}) async {
    if(position!=null){
      ///if position not null it means user slide the bar
      await _player.seek(position);
    }else{
      ///if not seek to current position. it used as resume
      await _player.seek(_player.position);
    }

    ///then play the audio
    await _player.play();
  }
  ///this function to pause
  @override
  void pause() async {
    await _player.pause();
  }

  ///this function to play music
  @override
  void play() async {
    _player.setUrl(trackPreviewUrl);
    await _player.play();
  }
}
