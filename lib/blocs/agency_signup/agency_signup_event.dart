import 'package:equatable/equatable.dart';

abstract class AgencySignupEvent extends Equatable {
  const AgencySignupEvent();

  @override
  List<Object> get props => [];
}

class SubmitAgencySignup extends AgencySignupEvent {
  final String agencyName;
  final String email;
  final String password;

  const SubmitAgencySignup(this.agencyName, this.email, this.password);

  @override
  List<Object> get props => [agencyName, email, password];
}
