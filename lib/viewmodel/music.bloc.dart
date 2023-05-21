import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_player/model/mixin/audio.mixin.dart';
import 'package:equatable/equatable.dart';

import '../model/music/music.state.dart';

class MusicBloc extends Cubit<MusicState> with AudioMixin {
  MusicBloc() : super(MusicInitialState());
  final player = AudioPlayer();
  int? musicIndex;
  final sampleUrlTrack =
      'https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview116/v4/2b/c2/2f/2bc22f1c-8e8e-30ec-ea9e-5e4ee8a4e9a0/mzaf_4981399673600368234.plus.aac.p.m4a';

  @override
  void nextSkip() {}

  @override
  void previousSkip() {}

  @override
  void stop() async {
    print('clicked');
    emit(MusicOnStopState());
    await player.stop();
  }

  @override
  void seekTo() {}

  @override
  void pause({stateIndex, index}) async {
    emit(MusicOnPauseState());
    await player.pause();
  }

  @override
  void onChange(Change<MusicState> change) {
    updatePosition();
  }

  void updatePosition() {
    player.positionStream.listen((event) {
      emit(MusicOnPlayState(
          duration: player.duration!.inMilliseconds.toDouble(),
          currentDuration: event.inMilliseconds.toDouble()));
    });

  }

  @override
  void play({stateIndex, index}) async {
    print(state);

    if (state is MusicOnPauseState) {
      musicIndex=index!;
      updatePosition();
      player.play().whenComplete((){
        print('stop track');
        emit(MusicOnStopState());
      });
    } else {
      musicIndex=index!;
      print('jere');
      player.setUrl(sampleUrlTrack);
      player.seek(Duration.zero);
      updatePosition();
      player.play().whenComplete((){
        print('stop track');
        emit(MusicOnStopState());
      });
    }
  }
}
