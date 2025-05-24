// app_album/lib/viewmodels/album_view_model.dart placeholder content
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

class AlbumViewModel {
  final String albumsUrl = 'https://jsonplaceholder.typicode.com/albums';
  final String photosUrl = 'https://jsonplaceholder.typicode.com/photos';

  Future<List<Map<String, dynamic>>> fetchAlbumsWithPhotos() async {
    final albumResponse = await http.get(Uri.parse(albumsUrl));
    final photoResponse = await http.get(Uri.parse(photosUrl));

    if (albumResponse.statusCode == 200 && photoResponse.statusCode == 200) {
      final List albumData = json.decode(albumResponse.body);
      final List photoData = json.decode(photoResponse.body);

      List<Album> albums = albumData.map((a) => Album.fromJson(a)).toList();
      List<Photo> photos = photoData.map((p) => Photo.fromJson(p)).toList();

      // Group photos by albumId
      Map<int, Photo> firstPhotoPerAlbum = {};
      for (Photo photo in photos) {
        if (!firstPhotoPerAlbum.containsKey(photo.albumId)) {
          firstPhotoPerAlbum[photo.albumId] = photo;
        }
      }

      return albums.map((album) {
        return {
          'album': album,
          'photo': firstPhotoPerAlbum[album.id],
        };
      }).toList();
    } else {
      throw Exception("Failed to load data");
    }
  }
}
