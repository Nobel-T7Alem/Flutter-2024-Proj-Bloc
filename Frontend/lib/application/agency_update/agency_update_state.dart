import 'package:equatable/equatable.dart';

abstract class AgencyUpdateState extends Equatable {
  const AgencyUpdateState();

  @override
  List<Object> get props => [];
}

class AgencyUpdateInitial extends AgencyUpdateState {}

class AgencyUpdateNavigationSuccess extends AgencyUpdateState {
  final String route;

  const AgencyUpdateNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}
