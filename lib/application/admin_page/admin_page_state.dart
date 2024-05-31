import 'package:equatable/equatable.dart';

abstract class AdminPageState extends Equatable {
  const AdminPageState();

  @override
  List<Object> get props => [];
}

class AdminPageInitial extends AdminPageState {}

class AdminPageLoading extends AdminPageState {}

class AdminPageLoaded extends AdminPageState {
  final String data;

  const AdminPageLoaded(this.data);

  @override
  List<Object> get props => [data];
}

class AdminPageError extends AdminPageState {
  final String error;

  const AdminPageError(this.error);

  @override
  List<Object> get props => [error];
}
