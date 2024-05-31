import 'package:equatable/equatable.dart';

abstract class AgencyUpdateEvent extends Equatable {
  const AgencyUpdateEvent();

  @override
  List<Object> get props => [];
}

class SubmitAgencyUpdate extends AgencyUpdateEvent {
  final Map<String, dynamic> agencyData;

  const SubmitAgencyUpdate(this.agencyData);

  @override
  List<Object> get props => [agencyData];
}
