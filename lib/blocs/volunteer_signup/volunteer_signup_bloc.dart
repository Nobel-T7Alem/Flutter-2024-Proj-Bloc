import 'package:bloc/bloc.dart';
import 'volunteer_signup_event.dart';
import 'volunteer_signup_state.dart';

class VolunteerSignupBloc extends Bloc<VolunteerSignupEvent, VolunteerSignupState> {
  VolunteerSignupBloc() : super(VolunteerSignupInitial()) {
    on<SignupButtonPressed>((event, emit) {
      emit(NavigateToUserHome());
    });

    on<LoginButtonPressed>((event, emit) {
      emit(NavigateToUserLogin());
    });
  }
}
