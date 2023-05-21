abstract class MusicState{
  const MusicState();
}
class MusicInitialState extends MusicState{
  const MusicInitialState();
}
class MusicOnPlayState extends MusicState{
  int index=-1;
  MusicOnPlayState(this.index);
}

class MusicOnPauseState extends MusicState{
  const MusicOnPauseState();
}
class MusicLoadingState extends MusicState{

  const MusicLoadingState();
}