import 'package:equatable/equatable.dart';
import 'package:music_app_player/model/music/music.model.dart';

///use equatable for class music state
abstract class MusicState extends Equatable {
  MusicModel? musicModel;
  DataMusic? dataMusic;
   MusicState({this.dataMusic,this.musicModel});
  @override
  List<Object> get props => [dataMusic!,musicModel!];
}

class MusicInitialState extends MusicState {}

class MusicLoadingState extends MusicState {}

class MusicLoadedErrorState extends MusicState {}

class MusicOnSelectedState extends MusicState{
  final DataMusic model;
  MusicOnSelectedState(this.model):super(dataMusic: model);
}
class MusicLoadedState extends MusicState {
  final MusicModel model;

   MusicLoadedState(this.model):super(musicModel: model);
}
