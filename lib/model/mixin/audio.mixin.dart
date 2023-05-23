///this mixin will use or reuse on bloc class
///use With on class to implement
mixin AudioMixin {
  void play() {}

  void pause() {}

  void seekTo({Duration? position}) {}

  void previousSkip() {}

  void nextSkip() {}

  void stop() {}
}
