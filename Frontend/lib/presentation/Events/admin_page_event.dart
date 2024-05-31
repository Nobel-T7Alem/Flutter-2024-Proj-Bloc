import 'package:Sebawi/presentation/Events/agency_home_event.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/accounts.dart';
import '../../data/models/posts.dart';

abstract class AdminPageEvent extends Equatable {
  const AdminPageEvent();

  @override
  List<Object> get props => [];
}

class ChangeRoleEvent extends AdminPageEvent{
  final Account account;
  const ChangeRoleEvent(this.account);
}

class AdminPageInitialEvent extends AdminPageEvent {
  const AdminPageInitialEvent();
}

class DeletePostEvent extends AdminPageEvent{
  final Post post;
  const DeletePostEvent(this.post);
}

class DeleteAccountEvent extends AdminPageEvent{
  final Account account;
  const DeleteAccountEvent(this.account);
}

class LoadAccountsEvent extends AdminPageEvent {
}

class LoadPostsEvent extends AdminPageEvent {}