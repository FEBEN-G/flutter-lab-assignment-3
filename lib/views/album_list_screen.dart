// app_album/lib/views/album_list_screen.dart placeholder content
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../blocs/album_bloc.dart';
import '../blocs/album_event.dart';
import '../blocs/album_state.dart';
import '../widgets/album_tile.dart';

class AlbumListScreen extends StatelessWidget {
  const AlbumListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Trigger loading albums when the widget is built
    context.read<AlbumBloc>().add(FetchAlbums());

    return Scaffold(
      appBar: AppBar(title: const Text('Albums')),
      body: BlocBuilder<AlbumBloc, AlbumState>(
        builder: (context, state) {
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AlbumLoaded) {
            final albumsWithPhotos = state.albumsWithPhotos;

            return ListView.builder(
              itemCount: albumsWithPhotos.length,
              itemBuilder: (context, index) {
                final album = albumsWithPhotos[index]['album'];
                final photo = albumsWithPhotos[index]['photo'];

                return AlbumTile(
                  albumTitle: album.title,
                  photoThumbnailUrl: photo.thumbnailUrl,
                  onTap: () {
                    // Navigate to detail page using GoRouter
                    final albumId = album.id;
                    GoRouter.of(context).push('/album/$albumId');
                  },
                );
              },
            );
          } else if (state is AlbumError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.message}'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      context.read<AlbumBloc>().add(FetchAlbums());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
