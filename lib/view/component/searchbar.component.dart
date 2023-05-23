import 'package:flutter/material.dart';
import 'package:music_app_player/model/music/music.state.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

class SearchBarComponent extends StatelessWidget {
  final MusicBloc bloc;
  SearchBarComponent({Key? key,required this.bloc}) :super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: TextFormField(
        enabled: true,
        style: Theme
            .of(context)
            .textTheme
            .bodyMedium,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) async {
          bloc.setSearch(value);
          await bloc.fetchSong();
        },
        onChanged: (value){
          bloc.setSearch(value);
        },
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(8.0),
            filled: true,
            fillColor: Theme
                .of(context)
                .colorScheme
                .primaryContainer,
            suffixIcon: IconButton(
              onPressed: () async {
                await bloc.fetchSong();
              },
              icon: Icon(
                Icons.search_rounded,
                color:
                Theme
                    .of(context)
                    .colorScheme
                    .onSecondaryContainer,
              ),
            ),
            hintText: 'Seach song or artist ...',
            hintStyle: Theme
                .of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.normal),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide.none),
            focusedBorder:
            const OutlineInputBorder(borderSide: BorderSide.none)),
      ),
    );
  }
}