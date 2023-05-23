import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app_player/model/audio/audio.model.dart';
import 'package:music_app_player/model/audio/audio.state.dart';
import 'package:music_app_player/model/mixin/audio.mixin.dart';

///class audio bloc as bloc for running audio
class AudioBloc extends Cubit<AudioState> with AudioMixin {
  AudioBloc() : super(AudioInitialState());

  ///setup preview url
  String? _previewUrl;

  void setTrack(url) => _previewUrl = url;

  ///create player
  final _player = AudioPlayer();

  void init() {
    ///set player state stream on init to watch the change status audio player
    _player.playerStateStream.listen((playerState) {
      ///create processing state
      final ProcessingState processingState = playerState.processingState;
      print('prosess state $processingState');

      /// give condition
      switch (processingState) {
        case ProcessingState.ready:

          ///when process is ready check the is playing or not and also update position
          _audioPlayPosition(playerState);
          break;

        ///stop when proccess is completed
        case ProcessingState.completed:
          stop();
          emit(AudioOnStopState());
          break;
        default:
          emit(AudioOnStopState());
          break;
      }
    });
  }

  ///this function to dectect position audio
  void _audioPlayPosition(PlayerState playerState) {
    _player.positionStream.listen((position) {
      playerState.playing
          ? emit(
              AudioOnPlayState(
                AudioModel(
                  position: position,
                  duration: _player.duration!,
                ),
              ),
            )
          : emit(AudioOnPauseState(AudioModel(
              position: position,
              duration: _player.duration!,
            )));
    });
  }

  @override
  void stop() {
    _player.stop();
  }

  @override
  void seekTo({Duration? position}) {
    ///if position is not null play to seek duration
    if (position != null) {
      _player.seek(position);
    } else {
      _player.seek(_player.position);
    }

    _player.play();
  }

  @override
  void pause() {
    /// when pause, set position of audio duration
    emit(
      AudioOnPauseState(
        AudioModel(position: _player.position, duration: _player.duration!),
      ),
    );
    _player.pause();
  }

  @override
  void play() async {
    await _player.setUrl(_previewUrl!);
    _player.play();
  }

  ///this function used on slider to get duration and seek then emit to play after drag end
  void setChangeDuration(Duration duration) {
    emit(
      AudioOnPlayState(
        AudioModel(position: duration, duration: _player.duration!),
      ),
    );
  }
}
