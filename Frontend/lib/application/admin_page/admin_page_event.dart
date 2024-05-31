import 'package:equatable/equatable.dart';

abstract class AdminPageEvent extends Equatable {
  const AdminPageEvent();

  @override
  List<Object> get props => [];
}

class LoadAdminPage extends AdminPageEvent {}
