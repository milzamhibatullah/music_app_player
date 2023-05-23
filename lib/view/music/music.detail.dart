import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_app_player/model/audio/audio.state.dart';
import 'package:music_app_player/model/music/music.state.dart';
import 'package:music_app_player/view/component/player/detail.player.component.dart';
import 'package:music_app_player/viewmodel/audio.bloc.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

///this class widget is used as detail after tap from bottom player
class MusicDetail extends StatelessWidget {
  MusicDetail({super.key});

  ///this function to formating duration and return as string
  String formattedDuration(s) {
    var splitTime = s.toString().split('.')[0];
    var formatted = splitTime.split(':');
    return '${formatted[1]}:${formatted[2]}';
  }


  @override
  Widget build(BuildContext context) {

    return MultiBlocListener(
        listeners: [
          BlocListener<AudioBloc, AudioState>(listener: (context, state) {
          }),
          BlocListener<MusicBloc, MusicState>(listener: (context, state) {
          })
        ],
        child:Builder(
          builder: (context){
            final musicState = context.watch<MusicBloc>().state;
            final audioState = context.watch<AudioBloc>().state;
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
                  musicState.dataMusic?.artistName ??
                      'No Artist Name',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
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
                              imageUrl:  musicState
                                  .dataMusic
                                  ?.artworkUrl100 ??
                                  '',
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
                          musicState.dataMusic?.trackName ??
                              '',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          musicState
                              .dataMusic
                              ?.collectionName ??
                              '',
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
                                thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 10.0)),
                            child: Slider(
                              value:audioState.model!=null? audioState.model!.position.inMilliseconds.toDouble() >
                                  audioState.model!.duration.inMilliseconds.toDouble()
                                  ? 1.0
                                  : audioState.model!.position.inMilliseconds.toDouble():0.0,
                              min: 0.0,
                              max: audioState.model!=null?audioState.model!.position.inMilliseconds.toDouble() >
                                  audioState.model!.duration.inMilliseconds.toDouble()
                                  ? 1.0
                                  : audioState.model!.duration.inMilliseconds.toDouble():1.0,

                              // label: _currentSliderValue.round().toString(),
                              onChanged: (double value) {
                                context.read<AudioBloc>().pause();
                                context.read<AudioBloc>().setChangeDuration(
                                  Duration(milliseconds: value.toInt()),
                                );

                              },
                              onChangeEnd: (double value) {
                                print(value);
                                context.read<AudioBloc>().seekTo(
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
                                audioState.model!=null?
                                     formattedDuration(audioState.model!.position.toString())
                                    : '0:00',
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            Text(
                                audioState.model!=null?
                                     formattedDuration(audioState.model!.duration.toString())
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
                        DetailPlayerComponent(
                            bloc: context.read<AudioBloc>(),
                            mBloc: context.read<MusicBloc>(),
                            audioState: audioState,
                            musicState: musicState),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ) );
  }
}
