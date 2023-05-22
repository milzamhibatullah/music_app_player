import 'package:equatable/equatable.dart';
import 'package:music_app_player/model/music/music.model.dart';

///use equatable for class music state
abstract class MusicState extends Equatable {
  @override
  List<Object> get props => [];
}

class MusicInitialState extends MusicState {}

///music on play state used for get on playing, duration,position
class MusicOnPlayState extends MusicState {
  final Duration currentDuration;
  final Duration maxDuration;

  MusicOnPlayState({required this.currentDuration, required this.maxDuration});

  @override
  List<Object> get props => [currentDuration, maxDuration];
}

class MusicOnPauseState extends MusicState {}

class MusicOnStopState extends MusicState {}

class MusicLoadingState extends MusicState {}

class MusicLoadedErrorState extends MusicState {}

class MusicLoadedState extends MusicState {}
