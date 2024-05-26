import 'package:bloc/bloc.dart';
import 'login_page_event.dart';
import 'login_page_state.dart';

class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  LoginPageBloc() : super(LoginPageInitial()) {
    on<NavigateToAdminLogin>(_onNavigateToAdminLogin);
    on<NavigateToUserLogin>(_onNavigateToUserLogin);
    on<NavigateToSignup>(_onNavigateToSignup);
  }

  void _onNavigateToAdminLogin(NavigateToAdminLogin event, Emitter<LoginPageState> emit) {
    emit(LoginPageNavigationSuccess('/admin_login'));
  }

  void _onNavigateToUserLogin(NavigateToUserLogin event, Emitter<LoginPageState> emit) {
    emit(LoginPageNavigationSuccess('/user_login'));
  }

  void _onNavigateToSignup(NavigateToSignup event, Emitter<LoginPageState> emit) {
    emit(LoginPageNavigationSuccess('/signup'));
  }
}
