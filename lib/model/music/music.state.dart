import 'package:equatable/equatable.dart';

abstract class MusicState extends Equatable {
  @override
  List<Object> get props => [];
}

class MusicInitialState extends MusicState {
  MusicInitialState();
}

class MusicOnPlayState extends MusicState {
  final double currentDuration;
  final double duration;

  MusicOnPlayState(
      {
      required this.currentDuration,
      required this.duration}) ;

  @override
  List<Object> get props =>[currentDuration,duration];
}

class MusicOnPauseState extends MusicState {
  MusicOnPauseState() ;
  @override
  List<Object> get props=>[];

}

class MusicOnStopState extends MusicState {
  MusicOnStopState() ;

  @override
  List<Object> get props=>[];
}

class MusicLoadingState extends MusicState {
  MusicLoadingState();
}
