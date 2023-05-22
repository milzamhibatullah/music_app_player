import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

import '../model/music/music.state.dart';

class HomeScreen extends StatelessWidget {
  var imageMusic =
      'https://is3-ssl.mzstatic.com/image/thumb/Music116/v4/44/d2/fd/44d2fd29-60f8-cbe2-d362-e369fcb8d301/cover.jpg/100x100bb.jpg';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MusicBloc, MusicState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: SizedBox(
            height: 40.0,
            child: TextFormField(
              style: Theme.of(context).textTheme.bodyMedium,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(8.0),
                  filled: true,
                  fillColor: Theme.of(context).colorScheme.primaryContainer,
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search_rounded,
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  hintText: 'Seach song or artist ...',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.normal),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.0),
                      borderSide: BorderSide.none),
                  focusedBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
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
                    imageUrl: imageMusic,
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
                        'Drama Queen',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Tayri & Hoop Records',
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
                  onPressed: () {},
                  icon: state is MusicOnPlayState
                      ? Icon(Icons.pause)
                      : Icon(Icons.play_arrow),
                )
              ],
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ///artis widget section
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView(
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(bottom: 20.0),
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      12,
                      (index) => Container(
                        margin: const EdgeInsets.only(top: 10.0),
                        decoration: BoxDecoration(
                            color:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ///image music
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: CachedNetworkImage(
                                  imageUrl: imageMusic,
                                  fit: BoxFit.cover,
                                  height: 60.0,
                                  width: 60.0,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
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
                                      'Drama Queen',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium!
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Tayri & Hoop Records',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium,
                                    ),
                                    Text(
                                      'Viral Hits 2023 : The Best Tiktok Viral Hits by Hoop Records',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .secondary),
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
                                    if( state is MusicOnPlayState){
                                      print('pause');
                                      context.read<MusicBloc>().pause(stateIndex: index,index: index);
                                    }else if(state is MusicOnPauseState){
                                      print('resume');
                                      context.read<MusicBloc>().seekTo();
                                    }else{
                                      print('play');
                                      context.read<MusicBloc>().musicIndex=index;
                                      context.read<MusicBloc>().play();
                                    }

                                  },
                                  icon:   Icon(
                                      state is MusicOnPlayState && context.read<MusicBloc>().musicIndex==index ?Icons.pause:  Icons.play_circle_fill_rounded))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
