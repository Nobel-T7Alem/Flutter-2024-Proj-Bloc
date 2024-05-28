import 'package:bloc/bloc.dart';
import 'login_user_event.dart';
import 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUserBloc() : super(LoginUserInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<NavigateToSignupEvent>(_onNavigateToSignup);
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<LoginUserState> emit) {
    // Perform login logic here (e.g., API call, authentication)

    // Navigate to the user home page upon successful login
    emit(LoginUserNavigationSuccess('/user_home'));
  }

  void _onNavigateToSignup(NavigateToSignupEvent event, Emitter<LoginUserState> emit) {
    emit(LoginUserNavigationSuccess('/signup'));
  }
}
