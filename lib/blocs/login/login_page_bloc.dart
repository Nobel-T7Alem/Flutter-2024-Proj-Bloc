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
    emit(const LoginPageNavigationSuccess('/admin_login'));
  }

  void _onNavigateToUserLogin(NavigateToUserLogin event, Emitter<LoginPageState> emit) {
    emit(const LoginPageNavigationSuccess('/user_login'));
  }

  void _onNavigateToSignup(NavigateToSignup event, Emitter<LoginPageState> emit) {
    emit(const LoginPageNavigationSuccess('/signup'));
  }
}
