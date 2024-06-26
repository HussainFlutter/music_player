import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ui_challenge/pages/home_page/home_page.dart';

import 'give_permission_page.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  SongBloc() : super(SongInitial()) {
    on<GetSongsEvent>((event, emit) => _getSongs(emit, event));
  }

  _getSongs(
    Emitter<SongState> emit,
    GetSongsEvent event,
  ) async {
    try {
      const storagePermission = Permission.storage;
      final result = await storagePermission.request();
      if (result.isGranted) {
        final audioQuery = OnAudioQuery();
        final albums = await audioQuery.queryAlbums();
        final artists = await audioQuery.queryArtists();
        final genres = await audioQuery.queryGenres();
        final playlists = await audioQuery.queryPlaylists();
        final songs = await audioQuery.querySongs();
        if (event.context.mounted) {
          Navigator.pushReplacement(
            event.context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                songs: songs,
                albums: albums,
                artists: artists,
                genres: genres,
                playlists: playlists,
              ),
            ),
          );
        }
      } else {
        if (event.context.mounted) {
          Navigator.pushReplacement(
              event.context,
              MaterialPageRoute(
                  builder: (context) => const GivePermissionPage()));
        }
      }
    } catch (e) {
      print("eror2");
      print(e.toString());
    }
  }
}
