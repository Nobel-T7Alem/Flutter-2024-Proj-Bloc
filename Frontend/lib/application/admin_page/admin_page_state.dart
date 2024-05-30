import 'package:equatable/equatable.dart';

import '../../data/models/posts.dart';

abstract class AdminPageState extends Equatable {
  const AdminPageState();

  @override
  List<Object> get props => [];
}

class AdminPageInitial extends AdminPageState {}

class PostsLoading extends AdminPageState {}

class PostsLoaded extends AdminPageState {
  final List<Post> posts;
  const PostsLoaded(this.posts);

  @override
  List<Object> get props => [posts];
}

class PostsError extends AdminPageState {
  final String error;

  const PostsError(this.error);

  @override
  List<Object> get props => [error];
}

class AccountsLoading extends AdminPageState {}

class AccountsLoaded extends AdminPageState {
  final List accounts;

  const AccountsLoaded(this.accounts);

  @override
  List<Object> get props => [accounts];
}

class AccountsError extends AdminPageState {
  final String error;

  const AccountsError(this.error);

  @override
  List<Object> get props => [error];
}
