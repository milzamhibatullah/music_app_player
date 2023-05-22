///this mixin will use or reuse on bloc class
mixin AudioMixin {
  void play({ int? index}) {}

  pause({ int? index}) {}

  void seekTo() {}

  void previousSkip() {}

  void nextSkip() {}

  void stop({ int? index}) {}
}
