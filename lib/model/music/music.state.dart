import 'package:equatable/equatable.dart';

abstract class MusicState extends Equatable {
  @override
  List<Object> get props => [];
}

class MusicInitialState extends MusicState {}

class MusicOnPlayState extends MusicState {
  final double currentDuration;
  final double maxDuration;
  MusicOnPlayState({required this.currentDuration,required this.maxDuration});

  @override
  List<Object> get props=>[currentDuration,maxDuration];
}

class MusicOnPauseState extends MusicState {}

class MusicOnStopState extends MusicState {}

class MusicLoadingState extends MusicState {}
