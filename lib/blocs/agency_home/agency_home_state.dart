import 'package:Sebawi/data/models/validate_form.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../data/models/posts.dart';

class AgencyHomeState extends Equatable {
  final ValidateForm name;
  final ValidateForm description;
  final ValidateForm contact;
  final GlobalKey<FormState>? formKey;
  final String? apiError;
  final String? apiMessage;
  const AgencyHomeState({
    this.name = const ValidateForm(error: null),
    this.description = const ValidateForm(error: null),
    this.contact = const ValidateForm(error: null),
    this.formKey,
    this.apiError,
    this.apiMessage
});

  AgencyHomeState copyWith({
    ValidateForm? name,
    ValidateForm? description,
    ValidateForm? contact,
    GlobalKey<FormState>? formKey,
    String? apiError,
    String? apiMessage,
}){
    return AgencyHomeState(
      name: name ?? this.name,
      description: description ?? this.description,
      contact: contact ?? this.contact,
      formKey: formKey ?? this.formKey,
      apiError: apiError ?? this.apiError,
      apiMessage: apiMessage ?? this.apiMessage,
    );
  }

  @override
  List<Object?> get props => [name, contact, description, formKey, apiError, apiMessage];
}


class AgencyHomeLoading extends AgencyHomeState {}

class MyPostsLoaded extends AgencyHomeState {
  final List<Post> myPosts;
  const MyPostsLoaded(this.myPosts);
  @override
  List<Object> get props => [myPosts];
}

class MyPostsLoading extends AgencyHomeState {}

class MyPostsError extends AgencyHomeState {
  final String error;
  const MyPostsError(this.error);
  @override
  List<Object> get props => [error];
}

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



class InitialAgencyHome extends AgencyHomeState {}

class AgencyHomeNavigationSuccess extends AgencyHomeState {
  final String route;

  const AgencyHomeNavigationSuccess(this.route);

  @override
  List<Object> get props => [route];
}




