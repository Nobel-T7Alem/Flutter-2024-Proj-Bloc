import 'package:bloc/bloc.dart';
import 'login_page_event.dart';
import 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageInitial());

  @override
  Stream<LoginPageState> mapEventToState(LoginPageEvent event) async* {
    if (event is NavigateToAdminLogin) {
      yield LoginPageNavigationSuccess('/admin_login');
    } else if (event is NavigateToUserLogin) {
      yield LoginPageNavigationSuccess('/user_login');
    } else if (event is NavigateToSignup) {
      yield LoginPageNavigationSuccess('/signup');
    }
  }
}
