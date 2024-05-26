import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageLoading extends HomePageState {}

class HomePageLoaded extends HomePageState {
  final String data;

  const HomePageLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class HomePageError extends HomePageState {
  final String error;

  const HomePageError(this.error);

  @override
  List<Object> get props => [error];
}
