import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/album_bloc.dart';
import 'viewmodels/album_view_model.dart';
import 'routes/app_router.dart';

void main() {
  runApp(const AppAlbum());
}

class AppAlbum extends StatelessWidget {
  const AppAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AlbumBloc(AlbumViewModel()),
      child: MaterialApp.router(
        title: 'Album App',
        routerConfig: appRouter,
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
      ),
    );
  }
}
