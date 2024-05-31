import 'package:bloc/bloc.dart';

import 'package:Sebawi/presentation/Events/signup_page.event.dart';
import 'package:Sebawi/presentation/States/signup_page.state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<NavigateToVolunteerSignupEvent>(_onNavigateToVolunteerSignup);
    on<NavigateToAgencySignupEvent>(_onNavigateToAgencySignup);
  }

  void _onNavigateToVolunteerSignup(NavigateToVolunteerSignupEvent event, Emitter<SignupState> emit) {
    emit(SignupNavigationSuccess('/volunteer_signup'));
  }

  void _onNavigateToAgencySignup(NavigateToAgencySignupEvent event, Emitter<SignupState> emit) {
    emit(SignupNavigationSuccess('/agency_signup'));
  }
}
