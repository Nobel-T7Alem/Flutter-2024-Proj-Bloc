import 'package:Sebawi/data/models/validate_form.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/posts.dart';

abstract class AgencyHomeEvent extends Equatable {
  const AgencyHomeEvent();

  @override
  List<Object> get props => [];
}

class AddPostEvent extends AgencyHomeEvent {
  const AddPostEvent();
}

class InitialAgencyHomeEvent extends AgencyHomeEvent {
  const InitialAgencyHomeEvent();
}

class LoadAgencyHomePageEvent extends AgencyHomeEvent {
}

class NavigateToAgencyUpdateEvent extends AgencyHomeEvent {}

class EditPostEvent extends AgencyHomeEvent {
  final Post post;
  const EditPostEvent(this.post);
}

class DeletePostEvent extends AgencyHomeEvent {
  final Post post;
  const DeletePostEvent(this.post);
}

class AgencyNameChangedEvent extends AgencyHomeEvent {
  const AgencyNameChangedEvent({required this.name});
  final ValidateForm name;
}

class DescriptionChangedEvent extends AgencyHomeEvent {
  const DescriptionChangedEvent({required this.description});
  final ValidateForm description;
}

class ContactChangedEvent extends AgencyHomeEvent {
  const ContactChangedEvent({required this.contact});
  final ValidateForm contact;
}