import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/model/music/music.state.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

class MusicDetail extends StatelessWidget {
  var imageMusic =
      'https://is3-ssl.mzstatic.com/image/thumb/Music116/v4/44/d2/fd/44d2fd29-60f8-cbe2-d362-e369fcb8d301/cover.jpg/100x100bb.jpg';
  Duration currentDuration = Duration.zero;
  Duration maxDuration = Duration.zero;

  String formatedDuration(s){
    var splitTime = s.toString().split('.')[0];
    var formatted = splitTime.split(':');
    return formatted[1]+':'+formatted[2];
  }
  @override
  Widget build(BuildContext context) {
    final currentState = context.read<MusicBloc>();
    return BlocConsumer<MusicBloc, MusicState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
              ),
            ),
            title: Text(
              currentState.music!.results![currentState.musicIndex!].artistName!,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60.0,
                    ),

                    ///image
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          imageUrl: imageMusic,
                          fit: BoxFit.contain,
                          height: MediaQuery.of(context).size.height / 4,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  CircularProgressIndicator(
                                      value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),

                    ///title and artist section
                    Text(
                      currentState.music!.results![currentState.musicIndex!].trackName!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentState.music!.results![currentState.musicIndex!].artistName!,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    ///slider bar player
                    SizedBox(
                      width: double.infinity,
                      child: SliderTheme(
                        data: SliderThemeData(
                            trackHeight: 5.0,
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 10.0)),
                        child: Slider(
                          value: currentDuration.inMilliseconds.toDouble() >
                                  maxDuration.inMilliseconds.toDouble()
                              ? 1.0
                              : currentDuration.inMilliseconds.toDouble(),
                          min: 0.0,
                          max: currentDuration.inMilliseconds.toDouble() >
                                  maxDuration.inMilliseconds.toDouble()
                              ? 1.0
                              : maxDuration.inMilliseconds.toDouble(),

                          // label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    ///duration
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            formatedDuration(currentDuration.toString()),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        Text(formatedDuration(maxDuration.toString()),
                            style: Theme.of(context).textTheme.labelLarge),
                        const SizedBox(
                          width: 10.0,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    ///player
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 1.0,
                          ),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.skip_previous_rounded,
                              size: 60.0,
                            )),
                        IconButton(
                            onPressed: () {
                              if (state is MusicOnPlayState) {
                                print('pause');
                                context.read<MusicBloc>().pause();
                              } else if (state is MusicOnPauseState) {
                                print('resume');
                                context.read<MusicBloc>().seekTo();
                              } else {
                                print('play');
                                context.read<MusicBloc>().play();
                              }
                            },
                            icon: Icon(
                              state is MusicOnStopState ||
                                      state is MusicOnPauseState
                                  ? Icons.play_circle_fill_rounded
                                  : Icons.pause,
                              size: 80.0,
                            )),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.skip_next_rounded, size: 60.0)),
                        Expanded(
                          flex: 1,
                          child: SizedBox(
                            height: 1.0,
                          ),
                        ),
                        // IconButton(
                        //     onPressed: () {
                        //       context.read<MusicBloc>().stop();
                        //     },
                        //     icon: Icon(Icons.stop_outlined, size: 20.0))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is MusicOnPlayState) {
          currentDuration = state.currentDuration;
          maxDuration = state.maxDuration;
        } else {
          currentDuration = currentDuration;
          maxDuration = maxDuration;
        }
      },
    );
  }
}
