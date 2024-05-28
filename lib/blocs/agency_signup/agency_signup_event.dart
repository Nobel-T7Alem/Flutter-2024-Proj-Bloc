import 'package:equatable/equatable.dart';

abstract class AgencySignupEvent extends Equatable {
  const AgencySignupEvent();

  @override
  List<Object> get props => [];
}

class AgencySignupSubmitted extends AgencySignupEvent {
  final Map<String, dynamic> agencyData;

  const AgencySignupSubmitted({required this.agencyData});

  @override
  List<Object> get props => [agencyData];
}

class NavigateToLogin extends AgencySignupEvent {}
