// app_album/lib/widgets/album_tile.dart placeholder content
import 'package:flutter/material.dart';

class AlbumTile extends StatelessWidget {
  final String albumTitle;
  final String photoThumbnailUrl;
  final VoidCallback onTap;

  const AlbumTile({
    super.key,
    required this.albumTitle,
    required this.photoThumbnailUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        photoThumbnailUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
      ),
      title: Text(albumTitle),
      onTap: onTap,
    );
  }
}
