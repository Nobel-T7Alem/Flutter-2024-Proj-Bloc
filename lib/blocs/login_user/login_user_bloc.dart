import 'package:bloc/bloc.dart';
import 'login_user_event.dart';
import 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUserBloc() : super(LoginUserInitial());

  @override
  Stream<LoginUserState> mapEventToState(LoginUserEvent event) async* {
    if (event is LoginUserRequested) {
      yield LoginUserLoading();
      try {
        // Simulate a login process
        await Future.delayed(const Duration(seconds: 2));
        yield const LoginUserSuccess('User Login Successful');
      } catch (e) {
        yield const LoginUserFailure('User Login Failed');
      }
    }
  }
}
