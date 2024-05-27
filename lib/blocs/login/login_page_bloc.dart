import 'package:bloc/bloc.dart';
import 'login_page_event.dart';
import 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageInitial()) {
    on<NavigateToAdminPage>(_onNavigateToAdminPage);
    on<NavigateToUserLogin>(_onNavigateToUserLogin);
    on<NavigateToSignup>(_onNavigateToSignup);
  }

  void _onNavigateToAdminPage(NavigateToAdminPage event, Emitter<LoginPageState> emit) {
    print('Navigating to Admin Page');
    emit(LoginPageNavigationSuccess('/admin_page'));
  }

  void _onNavigateToUserLogin(NavigateToUserLogin event, Emitter<LoginPageState> emit) {
    print('Navigating to User Login');
    emit(LoginPageNavigationSuccess('/user_login'));
  }

  void _onNavigateToSignup(NavigateToSignup event, Emitter<LoginPageState> emit) {
    print('Navigating to Signup');
    emit(LoginPageNavigationSuccess('/signup'));
  }
}
