import 'package:equatable/equatable.dart';

abstract class AgencyUpdateEvent extends Equatable {
  const AgencyUpdateEvent();

  @override
  List<Object> get props => [];
}

class SubmitAgencyUpdate extends AgencyUpdateEvent {
  final String agencyName;
  final String email;
  final String address;

  const SubmitAgencyUpdate(this.agencyName, this.email, this.address);

  @override
  List<Object> get props => [agencyName, email, address];
}
