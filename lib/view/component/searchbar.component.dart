import 'package:flutter/material.dart';
import 'package:music_app_player/viewmodel/music.bloc.dart';

class SearchBarComponent extends StatelessWidget {
  MusicBloc? currentState;

  SearchBarComponent({Key? key, this.currentState}) :super(key: key);
  final searchField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.0,
      child: TextFormField(
        style: Theme
            .of(context)
            .textTheme
            .bodyMedium,
        textInputAction: TextInputAction.search,
        controller: searchField,
        onFieldSubmitted: (value) async {
          currentState!.search = value.toString();
          await currentState!.fetchSong();
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
                currentState!.search = searchField.text;
                await currentState!.fetchSong();
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