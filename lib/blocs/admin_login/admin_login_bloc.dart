import 'package:bloc/bloc.dart';
import 'admin_login_event.dart';
import 'admin_login_state.dart';

class AdminLoginBloc extends Bloc<AdminLoginEvent, AdminLoginState> {
  AdminLoginBloc() : super(AdminLoginInitial());

  @override
  Stream<AdminLoginState> mapEventToState(AdminLoginEvent event) async* {
    if (event is AdminLoginRequested) {
      yield AdminLoginLoading();
      try {
        // Simulate a login process
        await Future.delayed(Duration(seconds: 2));
        yield AdminLoginSuccess('Admin Login Successful');
      } catch (e) {
        yield AdminLoginFailure('Admin Login Failed');
      }
    }
  }
}
