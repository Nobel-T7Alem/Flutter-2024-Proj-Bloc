import 'package:bloc/bloc.dart';
import 'volunteer_signup_event.dart';
import 'volunteer_signup_state.dart';

class VolunteerSignupBloc extends Bloc<VolunteerSignupEvent, VolunteerSignupState> {
  VolunteerSignupBloc() : super(VolunteerSignupInitial());

  @override
  Stream<VolunteerSignupState> mapEventToState(VolunteerSignupEvent event) async* {
    if (event is SubmitVolunteerSignup) {
      yield VolunteerSignupLoading();
      try {
        // Simulate a signup process
        await Future.delayed(Duration(seconds: 2));
        yield VolunteerSignupSuccess('Volunteer Signup Successful');
      } catch (e) {
        yield VolunteerSignupFailure('Volunteer Signup Failed');
      }
    }
  }
}
