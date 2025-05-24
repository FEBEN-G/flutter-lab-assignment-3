// app_album/lib/views/album_detail_screen.dart placeholder content
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

class AlbumDetailScreen extends StatefulWidget {
  final int albumId;
  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  late Future<Album> _albumFuture;
  late Future<List<Photo>> _photosFuture;

  @override
  void initState() {
    super.initState();
    _albumFuture = fetchAlbum(widget.albumId);
    _photosFuture = fetchPhotos(widget.albumId);
  }

  Future<Album> fetchAlbum(int id) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    );
    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<List<Photo>> fetchPhotos(int albumId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos?albumId=$albumId'),
    );
    if (response.statusCode == 200) {
      List photosJson = json.decode(response.body);
      return photosJson.map((p) => Photo.fromJson(p)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Details'),
      ),
      body: FutureBuilder<Album>(
        future: _albumFuture,
        builder: (context, albumSnapshot) {
          if (albumSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (albumSnapshot.hasError) {
            return Center(child: Text('Error: ${albumSnapshot.error}'));
          } else if (!albumSnapshot.hasData) {
            return const Center(child: Text('Album not found'));
          }

          final album = albumSnapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  album.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder<List<Photo>>(
                  future: _photosFuture,
                  builder: (context, photoSnapshot) {
                    if (photoSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (photoSnapshot.hasError) {
                      return Center(child: Text('Error: ${photoSnapshot.error}'));
                    } else if (!photoSnapshot.hasData || photoSnapshot.data!.isEmpty) {
                      return const Center(child: Text('No photos found'));
                    }

                    final photos = photoSnapshot.data!;

                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                      ),
                      itemCount: photos.length,
                      itemBuilder: (context, index) {
                        final photo = photos[index];
                        return GridTile(
                          child: Image.network(
                            photo.thumbnailUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image),
                          ),
                          footer: GridTileBar(
                            backgroundColor: Colors.black54,
                            title: Text(
                              photo.title,
                              style: const TextStyle(fontSize: 10),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
