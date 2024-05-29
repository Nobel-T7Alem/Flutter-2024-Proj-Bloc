import 'package:Sebawi/data/models/validate_form.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../data/models/posts.dart';
import '../../presentation/screens/agency_home.dart';

class AgencyHomeState extends Equatable {
  final ValidateForm name;
  final ValidateForm description;
  final ValidateForm contact;
  final GlobalKey<FormState>? formKey;
  final String? apiError;
  const AgencyHomeState({
    this.name = const ValidateForm(error: null),
    this.description = const ValidateForm(error: null),
    this.contact = const ValidateForm(error: null),
    this.formKey,
    this.apiError,
});

  AgencyHomeState copyWith({
    ValidateForm? name,
    ValidateForm? description,
    ValidateForm? contact,
    GlobalKey<FormState>? formKey,
    String? apiError,
}){
    return AgencyHomeState(
      name: name ?? this.name,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      formKey: formKey ?? this.formKey,
      apiError: apiError ?? this.apiError,
    );
  }

  @override
  List<Object?> get props => [name, contact, description, formKey, apiError];
}

class AgencyHomeInitial extends AgencyHomeState {}

class AgencyHomeLoading extends AgencyHomeState {}

class AgencyHomeLoaded extends AgencyHomeState {
  final List<Post> posts;

  const AgencyHomeLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class AgencyHomeError extends AgencyHomeState {
  final String error;

  const AgencyHomeError(this.error);

  @override
  List<Object> get props => [error];
}

class AgencyHomeNavigationSuccess extends AgencyHomeState {
  final String route;

  const AgencyHomeNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}



