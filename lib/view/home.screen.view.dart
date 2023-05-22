import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/view/component/player/bottom.player.component.dart';
import 'package:music_app_player/view/component/searchbar.component.dart';
import 'package:music_app_player/view/component/shimmer/shimmer.component.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

import '../model/music/music.state.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentState = context.read<MusicBloc>();
    return BlocBuilder<MusicBloc, MusicState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            ///searchbar widget component
            title: SearchBarComponent(
              currentState: currentState,
              state:state,
            ),
          ),

          ///bottom player bar
          bottomNavigationBar:
              currentState.music != null && currentState.musicIndex != null
                  ? BottomPlayerComponent(
                      currentState: currentState,
                      state: state,
                    )
                  : null,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: state is MusicLoadingState
                  ? itemShimmer(context)
                  : state is MusicLoadedErrorState?Container():Column(
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
                              currentState.music!.results!.length,
                              (index) => _itemList(
                                  index, currentState, context, state),
                            ),
                          ),
                        )
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }

  /// widget for item on list music
  Widget _itemList(index, currentState, context, state) {
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
                imageUrl: currentState.music!.results![index].artworkUrl100!,
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
                    currentState.music!.results![index].trackName ?? '',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    currentState.music!.results![index].artistName ??
                        'Tayri & Hoop Records',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  Text(
                    currentState.music!.results![index].collectionName ??
                        'Viral Hits 2023 : The Best Tiktok Viral Hits by Hoop Records',
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
                  if (state is MusicOnPlayState) {
                    print('pause');
                    if (currentState.musicIndex == index) {
                      currentState.pause();
                    } else {
                      currentState.trackPreviewUrl =
                          currentState.music!.results![index].previewUrl!;
                      currentState.musicIndex = index;
                      currentState.play();
                    }
                  } else if (state is MusicOnPauseState) {
                    print('resume');
                    if (currentState.musicIndex != index) {
                      currentState.trackPreviewUrl =
                          currentState.music!.results![index].previewUrl!;
                      currentState.musicIndex = index;
                      currentState.play();
                    } else {
                      currentState.seekTo();
                    }
                  } else {
                    print('play');
                    currentState.trackPreviewUrl =
                        currentState.music!.results![index].previewUrl!;
                    currentState.musicIndex = index;
                    currentState.play();
                  }
                },
                icon: Icon(state is MusicOnPlayState &&
                        currentState.musicIndex == index
                    ? Icons.pause
                    : Icons.play_circle_fill_rounded))
          ],
        ),
      ),
    );
  }
}
