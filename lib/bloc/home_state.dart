part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final QuerySnapshot querySnapshot;

  HomeLoaded(this.querySnapshot);

  @override
  List<Object?> get props => [querySnapshot];
}

class HomeError extends HomeState {
  final String errorMessage;

  HomeError({required this.errorMessage});
}

class HomeInternetConnection extends HomeState {
  final String errorMessage;

  HomeInternetConnection({required this.errorMessage});
}

class HomeInternetConnectionSnack extends HomeState {
  final String errorMessage;

  HomeInternetConnectionSnack({required this.errorMessage});
}
