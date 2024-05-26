import 'package:equatable/equatable.dart';

abstract class AgencySignupState extends Equatable {
  const AgencySignupState();

  @override
  List<Object> get props => [];
}

class AgencySignupInitial extends AgencySignupState {}

class AgencySignupLoading extends AgencySignupState {}

class AgencySignupSuccess extends AgencySignupState {
  final String message;

  const AgencySignupSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AgencySignupFailure extends AgencySignupState {
  final String error;

  const AgencySignupFailure(this.error);

  @override
  List<Object> get props => [error];
}
