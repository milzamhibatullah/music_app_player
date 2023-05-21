///this mixin will use or reuse on bloc class
mixin AudioMixin {
  void play({int? stateIndex, int? index}) {}

  pause({int? stateIndex, int? index}) {}

  void seekTo() {}

  void previousSkip() {}

  void nextSkip() {}

  void stop() {}
}
