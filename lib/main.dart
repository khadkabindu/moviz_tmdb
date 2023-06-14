import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/movies/bloc.dart';
import 'bloc/movies/event.dart';
import 'bloc/movies/state.dart';

import 'package:dio/dio.dart';

void main() {
  final dio = Dio(); // Create a Dio instance
  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  final Dio dio;

  const MyApp({required this.dio});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (_) => MoviesBloc(dio)..add(FetchMovies()),
        child: MoviesPage(),
      ),
    );
  }
}

class MoviesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff191826),
      appBar: AppBar(
        backgroundColor: Color(0xff191826),
        elevation: 0.0,
        title: const Text(
          'Popular Movies',
          style: TextStyle(color: Color(0xfff43370)),
        ),
      ),
      body: BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          if (state is IsLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is IsLoaded) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.2),
              child: Expanded(
                child: ListView.builder(
                  itemCount: state.movies.length,
                  itemBuilder: (context, index) {
                    final movie = state.movies[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Flexible(
                              flex:1,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w200${movie.imageUrl}',
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              flex: 2,
                              child: ListTile(
                                title: Text(
                                  movie.title,
                                  style: TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(movie.description,
                                    style: TextStyle(color: Color(0xff868597))),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                      ],
                    );
                  },
                ),
              ),
            );
          } else if (state is MoviesError) {
            return Center(child: Text(state.error));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
