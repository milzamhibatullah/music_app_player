import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/model/music/music.state.dart';
import 'package:music_app_player/view/component/player/detail.player.component.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

///this class widget is used as detail after tap from bottom player
class MusicDetail extends StatelessWidget {
  const MusicDetail({super.key});
  ///this function to formating duration and return as string
  String formattedDuration(s) {
    var splitTime = s.toString().split('.')[0];
    var formatted = splitTime.split(':');
    return '${formatted[1]}:${formatted[2]}';
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
              currentState
                  .music!.results![currentState.musicIndex!].artistName!,
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

                    ///Image widget for display music art work
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: CachedNetworkImage(
                          imageUrl: currentState
                              .music!
                              .results![currentState.musicIndex!]
                              .artworkUrl100!,
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
                      currentState
                          .music!.results![currentState.musicIndex!].trackName!,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      currentState.music!.results![currentState.musicIndex!]
                          .artistName!,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),

                    ///slider bar player to change position and then play seek to
                    SizedBox(
                      width: double.infinity,
                      child: SliderTheme(
                        data: SliderThemeData(
                            trackHeight: 5.0,
                            overlayShape: SliderComponentShape.noOverlay,
                            thumbShape: RoundSliderThumbShape(
                                enabledThumbRadius: 10.0)),
                        child: Slider(
                          value: currentState.currentDuration != null
                              ? currentState.currentDuration!.inMilliseconds
                                          .toDouble() >
                                      currentState.maxDuration!.inMilliseconds
                                          .toDouble()
                                  ? 1.0
                                  : currentState.currentDuration!.inMilliseconds
                                      .toDouble()
                              : 0.0,
                          min: 0.0,
                          max: currentState.currentDuration != null
                              ? currentState.currentDuration!.inMilliseconds
                                          .toDouble() >
                                      currentState.maxDuration!.inMilliseconds
                                          .toDouble()
                                  ? 1.0
                                  : currentState.maxDuration!.inMilliseconds
                                      .toDouble()
                              : 1,

                          // label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            currentState.pause();
                            currentState.currentDuration =
                                Duration(milliseconds: value.toInt());
                            currentState.emit(MusicOnPlayState(
                                currentDuration: currentState.currentDuration!,
                                maxDuration: currentState.maxDuration!));
                          },
                          onChangeEnd: (double value) {
                            print(value);
                            currentState.seekTo(
                                position:
                                    Duration(milliseconds: value.toInt()));
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),

                    ///duration widget start - end
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 10.0,
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            currentState.currentDuration != null
                                ? formattedDuration(
                                    currentState.currentDuration.toString())
                                : '0:00',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                        Text(
                            currentState.maxDuration != null
                                ? formattedDuration(
                                    currentState.maxDuration.toString())
                                : '0:00',
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
                    DetailPlayerComponent(currentState: currentState,state: state,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {
        if (state is MusicOnPlayState) {
          currentState.currentDuration = state.currentDuration;
          currentState.maxDuration = state.maxDuration;
        } else {
          currentState.currentDuration = currentState.currentDuration;
          currentState.maxDuration = currentState.maxDuration;
        }
      },
    );
  }
}
