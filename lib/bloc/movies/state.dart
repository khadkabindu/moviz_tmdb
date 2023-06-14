import '../../models/movies_model.dart';
import 'event.dart';

class IsInitial extends MoviesState {}

class IsLoading extends MoviesState {}

class IsLoaded extends MoviesState {
  final List<Movie> movies;

  const IsLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class MoviesError extends MoviesState {
  final String error;

  const MoviesError(this.error);

  @override
  List<Object?> get props => [error];
}