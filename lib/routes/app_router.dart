// app_album/lib/routes/app_router.dart placeholder content
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../views/album_list_screen.dart';
import '../views/album_detail_screen.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AlbumListScreen(),
    ),
    GoRoute(
      path: '/album/:id',
      builder: (context, state) {
        final albumId = int.tryParse(state.pathParameters['id'] ?? '');

        if (albumId == null) {
          return const Scaffold(
            body: Center(child: Text('Invalid Album ID')),
          );
        }
        return AlbumDetailScreen(albumId: albumId);
      },
    ),
  ],
);
