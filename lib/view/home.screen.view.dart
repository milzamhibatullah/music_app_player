import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/model/audio/audio.state.dart';
import 'package:music_app_player/model/music/music.model.dart';
import 'package:music_app_player/view/component/player/bottom.player.component.dart';
import 'package:music_app_player/view/component/searchbar.component.dart';
import 'package:music_app_player/view/component/shimmer/shimmer.component.dart';
import 'package:music_app_player/viewmodel/audio.bloc.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

import '../model/music/music.state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      final audioState = context.watch<AudioBloc>().state;
      final musicState = context.watch<MusicBloc>().state;
      return Scaffold(
        appBar: AppBar(
          ///searchbar widget component
          title: SearchBarComponent(
            bloc: context.read<MusicBloc>(),
          ),
        ),

        ///bottom player bar
        bottomNavigationBar:
        audioState is AudioOnPlayState || audioState is AudioOnPauseState
            ? BottomPlayerComponent(
          audioState: audioState,
          musicState : musicState,
          bloc: context.read<AudioBloc>(),
        )
            : null,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: musicState is MusicLoadingState
                ? itemShimmer(context)
                : musicState is MusicLoadedErrorState?Container(color: Colors.deepOrange,):Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ///music list
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 20.0),
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      musicState.musicModel?.results?.length??0,
                          (index) => _itemList(
                            musicState.musicModel!.results![index],
                            context,
                            audioState,
                            musicState
                          ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }

  /// widget for item on list music
  Widget _itemList(DataMusic dataMusic, BuildContext context, AudioState audioState, MusicState musicState) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ///image music
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: CachedNetworkImage(
                imageUrl: dataMusic.artworkUrl100!,
                fit: BoxFit.cover,
                height: 60.0,
                width: 60.0,
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              flex: 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataMusic.trackName ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    dataMusic.artistName ??
                        'No Artist',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    dataMusic.collectionName ??
                        '-',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(
                        color: Theme.of(context).colorScheme.secondary),
                  )
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
                    print('pause');

                    if (dataMusic==musicState.dataMusic) {
                      context.read<AudioBloc>().pause();
                    } else {
                      context.read<MusicBloc>().setSelectedMusic(dataMusic);
                      context.read<AudioBloc>().setTrack(dataMusic.previewUrl);
                      context.read<AudioBloc>().play();
                    }
                  } else if (audioState is AudioOnPauseState) {
                    print('resume');
                    /// when on pause, if same music clicked resume audio
                    /// if not play new music
                    if (dataMusic != musicState.dataMusic) {
                      context.read<MusicBloc>().setSelectedMusic(dataMusic);
                      context.read<AudioBloc>().setTrack(dataMusic.previewUrl);
                      context.read<AudioBloc>().play();
                    } else {
                      context.read<AudioBloc>().seekTo();
                    }
                  } else {
                    context.read<MusicBloc>().setSelectedMusic(dataMusic);
                    context.read<AudioBloc>().setTrack(dataMusic.previewUrl);
                    context.read<AudioBloc>().play();
                  }
                },
                icon: Icon(audioState is AudioOnPlayState &&
                        dataMusic==musicState.dataMusic
                    ? Icons.pause
                    : Icons.play_circle_fill_rounded))
          ],
        ),
      ),
    );
  }
}
