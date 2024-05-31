import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  const HomePageState();

  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageNavigationSuccess extends HomePageState {
  final String route;

  const HomePageNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}
