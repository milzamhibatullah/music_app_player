import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

import '../../../model/music/music.state.dart';

class DetailPlayerComponent extends StatelessWidget {
  MusicBloc? currentState;
  MusicState? state;

  DetailPlayerComponent({Key? key, this.currentState, this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///previous button skip
        IconButton(
          ///validate if index is 0 disable the button
            onPressed: currentState!.musicIndex == 0
                ? null
                : () {
                    currentState!.musicIndex = currentState!.musicIndex! - 1;
                    currentState!.trackPreviewUrl = currentState!
                        .music!.results![currentState!.musicIndex!].previewUrl!;
                    currentState!.previousSkip();
                  },
            icon: const Icon(
              Icons.skip_previous_rounded,
              size: 60.0,
            )),
        ///play button
        IconButton(
            onPressed: () {
              if (state is MusicOnPlayState) {
                print('pause');
                currentState!.pause();
              } else if (state is MusicOnPauseState) {
                print('resume');
                currentState!.seekTo();
              } else {
                print('play');
                currentState!.play();
              }
            },
            icon: Icon(
              state is MusicOnStopState || state is MusicOnPauseState
                  ? Icons.play_circle_fill_rounded
                  : Icons.pause,
              size: 80.0,
            )),
        ///button next skip
        IconButton(
          onPressed: () {
            currentState!.musicIndex = currentState!.musicIndex! + 1;
            currentState!.trackPreviewUrl = currentState!
                .music!.results![currentState!.musicIndex!].previewUrl!;
            currentState!.nextSkip();
          },
          icon: Icon(Icons.skip_next_rounded, size: 60.0),
        ),
      ],
    );
  }
}
