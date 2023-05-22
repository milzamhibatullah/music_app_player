///this mixin will use or reuse on bloc class
mixin AudioMixin {
  void play() {}

  pause() {}

  void seekTo({Duration? position}) {}

  void previousSkip() {}

  void nextSkip() {}

  void stop({ int? index}) {}
}
