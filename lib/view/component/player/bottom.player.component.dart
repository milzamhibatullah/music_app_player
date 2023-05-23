import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app_player/model/audio/audio.state.dart';
import 'package:music_app_player/viewmodel/audio.bloc.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

import '../../../model/music/music.state.dart';

class BottomPlayerComponent extends StatelessWidget {
  final AudioState audioState;
  final MusicState musicState;
  final AudioBloc bloc;

  BottomPlayerComponent(
      {Key? key,
      required this.audioState,
      required this.musicState,
      required this.bloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/music-detail');
      },
      onDoubleTap: () {},
      child: Container(
        height: 60.0,
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///image music
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: musicState.dataMusic?.artworkUrl60 ?? '',
                fit: BoxFit.cover,
                height: 40.0,
                width: 40.0,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              width: 16.0,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    musicState.dataMusic?.trackName ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    musicState.dataMusic?.artistName ?? '',
                    style: Theme.of(context).textTheme.labelSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),

            ///playbutton or pause
            IconButton(
              onPressed: () {
                if (audioState is AudioOnPlayState) {
                  bloc.pause();
                } else if (audioState is AudioOnPauseState) {
                  print('resume');
                  bloc.seekTo();
                } else {
                  print('play');
                  bloc.play();
                }
              },
              icon: audioState is AudioOnPlayState
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
            )
          ],
        ),
      ),
    );
  }
}
