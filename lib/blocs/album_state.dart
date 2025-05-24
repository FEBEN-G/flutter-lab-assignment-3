// app_album/lib/blocs/album_state.dart placeholder content
import '../models/album.dart';
import '../models/photo.dart';

abstract class AlbumState {}

class AlbumInitial extends AlbumState {}

class AlbumLoading extends AlbumState {}

class AlbumLoaded extends AlbumState {
  final List<Map<String, dynamic>> albumsWithPhotos;

  AlbumLoaded(this.albumsWithPhotos);
}

class AlbumError extends AlbumState {
  final String message;

  AlbumError(this.message);
}
