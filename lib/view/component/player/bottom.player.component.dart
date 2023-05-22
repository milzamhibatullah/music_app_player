import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

import '../../../model/music/music.state.dart';

class BottomPlayerComponent extends StatelessWidget{
  MusicBloc? currentState;
  MusicState? state;
  BottomPlayerComponent({Key? key,this.currentState,this.state}):super(key: key);
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
                imageUrl: currentState!
                    .music!
                    .results![currentState!.musicIndex!]
                    .artworkUrl100!,
                fit: BoxFit.cover,
                height: 40.0,
                width: 40.0,
                progressIndicatorBuilder:
                    (context, url, downloadProgress) =>
                    CircularProgressIndicator(
                        value: downloadProgress.progress),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error),
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
                    currentState!
                        .music!
                        .results![currentState!.musicIndex!]
                        .trackName!,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    currentState!
                        .music!
                        .results![currentState!.musicIndex!]
                        .artistName!,
                    style: Theme.of(context).textTheme.labelSmall,
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
              icon: state is MusicOnPlayState
                  ? const Icon(Icons.pause)
                  : const Icon(Icons.play_arrow),
            )
          ],
        ),
      ),
    );
  }
}