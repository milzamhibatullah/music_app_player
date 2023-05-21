import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/model/mixin/audio.mixin.dart';

import '../model/music/music.state.dart';

class MusicBloc extends Cubit<MusicState> with AudioMixin {
  MusicBloc() : super(MusicInitialState());
  final sampleUrlTrack =
      'https://music.apple.com/us/album/voodoo/1671525412?i=1671526883&uo=4';

  @override
  void nextSkip() {}

  @override
  void previousSkip() {}

  @override
  void seekTo() {}

  @override
  void pause({stateIndex, index}) {
    stateIndex == index ? emit(const MusicOnPauseState()) : play(index!);
  }

  @override
  void play(int index) {
    emit(MusicOnPlayState(index));
  }
}
