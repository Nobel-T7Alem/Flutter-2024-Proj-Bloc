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
        await Future.delayed(Duration(seconds: 2));
        yield LoginUserSuccess('User Login Successful');
      } catch (e) {
        yield LoginUserFailure('User Login Failed');
      }
    }
  }
}
