import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_player/model/mixin/audio.mixin.dart';
import 'package:equatable/equatable.dart';

import '../model/music/music.state.dart';

class MusicBloc extends Cubit<MusicState> with AudioMixin {
  MusicBloc() : super(MusicInitialState());
  final player = AudioPlayer();
  StreamSubscription? status;
  StreamSubscription? iDuration;
  double? currentDuration;
  double? maxDuration;
  int? musicIndex;
  final sampleUrlTrack =
      'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/2b/c2/2f/2bc22f1c-8e8e-30ec-ea9e-5e4ee8a4e9a0/mzaf_4981399673600368234.plus.aac.p.m4a';

  void init() {
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
                        currentDuration: event.inMilliseconds.toDouble(),
                        maxDuration:
                            player.duration!.inMilliseconds.toDouble()),
                  )
                : emit(MusicOnPauseState());
          });
          break;
        case ProcessingState.completed:
          stop();
          emit(MusicOnStopState());
          break;
        default:
          emit(MusicOnStopState());
          break;
      }
    });
  }

  @override
  void nextSkip() {}

  @override
  void previousSkip() {}

  @override
  void stop({index}) async {
    musicIndex=index;
    await player.stop();
  }

  @override
  void seekTo() async{
    await player.seek(player.position);
    await player.play();
  }

  @override
  void pause({stateIndex, index}) async {
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
