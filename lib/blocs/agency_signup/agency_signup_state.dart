import 'package:equatable/equatable.dart';

abstract class AgencySignupState extends Equatable {
  const AgencySignupState();

  @override
  List<Object> get props => [];
}

class AgencySignupInitial extends AgencySignupState {}

class AgencySignupNavigationSuccess extends AgencySignupState {
  final String route;

  const AgencySignupNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}
