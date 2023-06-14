import 'package:bloc/bloc.dart';

import '../../models/movies_model.dart';
import 'event.dart';
import 'state.dart';

import 'package:dio/dio.dart';


class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final Dio dio;

  MoviesBloc(this.dio) : super(IsInitial()) {
    on<FetchMovies>((event, emit) async{
      emit(IsLoading());
      try {
        final movies = await _fetchMovies();
        emit(IsLoaded(movies));
      } catch (error) {
        emit(MoviesError(error.toString()));
      }
    });
  }


  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is FetchMovies) {
      yield IsLoading();
      try {
        final movies = await _fetchMovies();
        yield IsLoaded(movies);
      } catch (error) {
        yield MoviesError(error.toString());
      }
    }
  }

  Future<List<Movie>> _fetchMovies() async {
    final response = await dio.get(
        'https://api.themoviedb.org/3/movie/popular?api_key=1500496dcaf1512b62894bd98ba83f9d');
    final data = response.data['results'] as List<dynamic>;
    return data.map<Movie>((json) => Movie.fromJson(json)).toList();
  }
}








