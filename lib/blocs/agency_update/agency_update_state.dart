import 'package:equatable/equatable.dart';

abstract class AgencyUpdateState extends Equatable {
  const AgencyUpdateState();

  @override
  List<Object> get props => [];
}

class AgencyUpdateInitial extends AgencyUpdateState {}

class AgencyUpdateLoading extends AgencyUpdateState {}

class AgencyUpdateSuccess extends AgencyUpdateState {
  final String message;

  const AgencyUpdateSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class AgencyUpdateFailure extends AgencyUpdateState {
  final String error;

  const AgencyUpdateFailure(this.error);

  @override
  List<Object> get props => [error];
}
