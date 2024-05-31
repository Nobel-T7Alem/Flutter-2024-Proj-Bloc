import 'package:bloc/bloc.dart';
import 'admin_login_event.dart';
import 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  AdminLoginBloc() : super(AdminLoginInitial()) {
    on<AdminLoginSubmitted>(_onAdminLoginSubmitted);
  }

  void _onAdminLoginSubmitted(AdminLoginSubmitted event, Emitter<AdminLoginState> emit) {
    if (event.username == 'admin' && event.password == 'password') {
      emit(AdminLoginSuccess());
    } else {
      emit(AdminLoginFailure());
    }
  }
}
