import 'package:equatable/equatable.dart';
import 'package:music_app_player/model/audio/audio.model.dart';

abstract class AudioState extends Equatable {
  AudioModel? model;
  AudioState({this.model});
  @override
  List<Object?> get props => [];
}

class AudioInitialState extends AudioState {}

class AudioOnPlayState extends AudioState {
  AudioModel? model;
  AudioOnPlayState(this.model):super(model: model);
}

class AudioOnPauseState extends AudioState {
  AudioModel? model;
  AudioOnPauseState(this.model):super(model: model);
}

class AudioOnStopState extends AudioState {}
