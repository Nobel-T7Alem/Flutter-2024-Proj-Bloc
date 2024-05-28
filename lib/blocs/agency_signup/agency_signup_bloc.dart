import 'package:bloc/bloc.dart';
import 'agency_signup_event.dart';
import 'agency_signup_state.dart';

class AgencySignupBloc extends Bloc<AgencySignupEvent, AgencySignupState> {
  AgencySignupBloc() : super(AgencySignupInitial()) {
    on<AgencySignupSubmitted>(_onAgencySignupSubmitted);
    on<NavigateToLogin>(_onNavigateToLogin);
  }

  void _onAgencySignupSubmitted(AgencySignupSubmitted event, Emitter<AgencySignupState> emit) {
    // Perform signup logic here (e.g., API call to register agency)

    // Navigate to the agency home page upon successful signup
    emit(AgencySignupNavigationSuccess('/agency_home'));
  }

  void _onNavigateToLogin(NavigateToLogin event, Emitter<AgencySignupState> emit) {
    emit(AgencySignupNavigationSuccess('/user_login'));
  }
}
