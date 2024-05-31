import 'dart:convert';
import 'package:Sebawi/data/services/api_path.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../data/models/posts.dart';
import '../../data/models/validate_form.dart';
import 'agency_home_event.dart';
import 'agency_home_state.dart';

class AgencyHomeBloc extends Bloc<AgencyHomeEvent, AgencyHomeState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  AgencyHomeBloc() : super(InitialAgencyHome()) {

    on<InitialAgencyHomeEvent>(_initState);
    on<LoadAgencyHomePageEvent>(_onLoadAgencyHomePage);
    on<NavigateToAgencyUpdateEvent>(_onNavigateToAgencyUpdate);
    on<EditPostEvent>(_onEditPostEvent);
    on<DeletePostEvent>(_onDeletePostEvent);
    on<AddPostEvent>(_onAddPostEvent);
    on<AgencyNameChangedEvent>(_onNameChanged);
    on<DescriptionChangedEvent>(_onDescriptionChanged);
    on<ContactChangedEvent>(_onContactChanged);
    on<LoadMyPostsEvent>(_onLoadMyPosts);
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _initState(
      InitialAgencyHomeEvent event, Emitter<AgencyHomeState> emit) async {
    emit(state.copyWith(formKey: _formKey));
     add(LoadAgencyHomePageEvent());
  }

  Future<void> _onLoadMyPosts(
      LoadMyPostsEvent event, Emitter<AgencyHomeState> emit) async {
      final myPosts = await RemoteService().getMyPosts();
      try{
        if (myPosts != null) {
          emit(MyPostsLoaded(myPosts));
        } else {
          emit(const MyPostsError('Failed to load posts'));
        }
      } catch (error) {
        emit(MyPostsError(error.toString()));
      }
  }

  Future<void> _onLoadAgencyHomePage(
      LoadAgencyHomePageEvent event, Emitter<AgencyHomeState> emit) async {
    try {
      final posts = await RemoteService().getPosts();
      if (posts != null) {
        emit(AgencyHomeLoaded(posts));
      } else {
        emit(const AgencyHomeError('Failed to load posts'));
      }
    } catch (error) {
      emit(AgencyHomeError(error.toString()));
    }
  }

  Future<void> _onNameChanged(
      AgencyNameChangedEvent event, Emitter<AgencyHomeState> emit) async {
    emit(state.copyWith(name: ValidateForm(value: event.name.value)));
  }

  Future<void> _onDescriptionChanged(
      DescriptionChangedEvent event, Emitter<AgencyHomeState> emit) async {
    emit(state.copyWith(
        description: ValidateForm(value: event.description.value)));
  }

  Future<void> _onContactChanged(
      ContactChangedEvent event, Emitter<AgencyHomeState> emit) async {
    emit(state.copyWith(contact: ValidateForm(value: event.contact.value)));
  }

  void _onNavigateToAgencyUpdate(
      NavigateToAgencyUpdateEvent event, Emitter<AgencyHomeState> emit) {
    emit(const AgencyHomeNavigationSuccess('/agency_update'));
  }

  Future<void> _onAddPostEvent(
      AddPostEvent event, Emitter<AgencyHomeState> emit) async {
    String? nameError;
    String? descriptionError;
    String? contactError;
    if (nameController.text.isEmpty) {
      nameError = 'Name cannot be empty';
    }
    if (descriptionController.text.isEmpty) {
      descriptionError = 'Description cannot be empty';
    }
    if (contactController.text.isEmpty) {
      contactError = 'Contact cannot be empty';
    }
    if (nameError == null && descriptionError == null && contactError == null) {
      SharedPreferenceService sharedPrefService = SharedPreferenceService();
      String? userId = await sharedPrefService.readCache(key: "uId");
      if(userId == null){
        return;
      }
      Post post = Post(
          name: nameController.text,
          description: descriptionController.text,
          contact: contactController.text,
          user: userId,
      );

      final success = await RemoteService().addPost(json.encode(post.toJson()));
      try {
        if (success == 201) {
          emit(state.copyWith(
            apiMessage: "Post added successfully!",
          ));
        } else {
          emit(state.copyWith(apiError: 'Failed to add post'));
        }
      } catch (error) {
        emit(AgencyHomeError(error.toString()));
      }
    } else {
      emit(state.copyWith(
        name: ValidateForm(value: state.name.value, error: nameError),
        description: ValidateForm(
            value: state.description.value, error: descriptionError),
        contact: ValidateForm(value: state.contact.value, error: contactError),
      ));
    }
  }

  void _onEditPostEvent(EditPostEvent event, Emitter<AgencyHomeState> emit) {
    // if (state is AgencyHomeLoaded) {
    //   final loadedState = state as AgencyHomeLoaded;
    //   final updatedPosts = loadedState.posts.map((post) {
    //     return post == event.post ? event.post : post;
    //   }).toList();
    //   emit(AgencyHomeLoaded(updatedPosts));
    // }
  }

  void _onDeletePostEvent(
      DeletePostEvent event, Emitter<AgencyHomeState> emit) {
    // if (state is AgencyHomeLoaded) {
    //   final loadedState = state as AgencyHomeLoaded;
    //   final updatedPosts = loadedState.posts.where((post) => post != event.post).toList();
    //   emit(AgencyHomeLoaded(updatedPosts));
    // }
  }
}
