// login_bloc.dart
import 'package:Sebawi/presentation/Events/login_page_event.dart';
import 'package:bloc/bloc.dart';
import '../../presentation/States/login_page_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<AdminLoginPressed>((event, emit) => emit(NavigateToAdminLogin()));
    on<UserLoginPressed>((event, emit) => emit(NavigateToUserLogin()));
    on<SignUpPressed>((event, emit) => emit(NavigateToSignUp()));
  }
}
