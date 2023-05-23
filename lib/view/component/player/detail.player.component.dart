import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app_player/model/audio/audio.state.dart';
import 'package:music_app_player/viewmodel/audio.bloc.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

import '../../../model/music/music.state.dart';

class DetailPlayerComponent extends StatelessWidget {
  final AudioBloc bloc;
  final MusicBloc mBloc;
  final AudioState audioState;
  final MusicState musicState;

  const DetailPlayerComponent(
      {Key? key,
      required this.bloc,
      required this.mBloc,
      required this.audioState,
      required this.musicState})
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
            onPressed:
                musicState.dataMusic == musicState.musicModel!.results!.first
                    ?null
                    : () {

                        final index = musicState.musicModel!.results!
                            .indexOf(musicState.dataMusic!);
                        final previousMusic =
                            musicState.musicModel!.results![index - 1];
                        mBloc.setSelectedMusic(previousMusic);
                        bloc.setTrack(musicState.dataMusic!.previewUrl);
                        bloc.play();
                      },
            icon: const Icon(
              Icons.skip_previous_rounded,
              size: 60.0,
            )),

        ///play button
        IconButton(
            onPressed: () {
              if (audioState is AudioOnPlayState) {
                print('pause');
                bloc.pause();
              } else if (audioState is AudioOnPauseState) {
                print('resume');
                bloc.seekTo();
              } else {
                print('play');
                bloc.play();
              }
            },
            icon: Icon(
              audioState is AudioOnPauseState || audioState is AudioOnStopState
                  ? Icons.play_circle_fill_rounded
                  : Icons.pause,
              size: 80.0,
            )),

        ///button next skip
        IconButton(
          onPressed: musicState.dataMusic ==
                  musicState.musicModel!.results!.last
              ? null
              : () {

                  final index = musicState.musicModel!.results!
                      .indexOf(musicState.dataMusic!);
                  final nextMusic = musicState.musicModel!.results![index + 1];
                  mBloc.setSelectedMusic(nextMusic);
                  bloc.setTrack(musicState.dataMusic!.previewUrl);
                  bloc.play();
                },
          icon: const Icon(Icons.skip_next_rounded, size: 60.0),
        ),
      ],
    );
  }
}
