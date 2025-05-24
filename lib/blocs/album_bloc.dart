// app_album/lib/blocs/album_bloc.dart placeholder content
import 'package:flutter_bloc/flutter_bloc.dart';
import 'album_event.dart';
import 'album_state.dart';
import '../viewmodels/album_view_model.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final AlbumViewModel albumViewModel;

  AlbumBloc(this.albumViewModel) : super(AlbumInitial()) {
    on<FetchAlbums>((event, emit) async {
      emit(AlbumLoading());
      try {
        final albumsWithPhotos = await albumViewModel.fetchAlbumsWithPhotos();
        emit(AlbumLoaded(albumsWithPhotos));
      } catch (e) {
        emit(AlbumError(e.toString()));
      }
    });
  }
}
