import 'package:bloc/bloc.dart';
import 'signup_page_event.dart';
import 'signup_page_state.dart';

class SignupPageBloc extends Bloc<SignupPageEvent, SignupPageState> {
  SignupPageBloc() : super(SignupPageInitial());

  @override
  Stream<SignupPageState> mapEventToState(SignupPageEvent event) async* {
    if (event is SubmitSignup) {
      yield SignupPageLoading();
      try {
        // Simulate a signup process
        await Future.delayed(Duration(seconds: 2));
        yield SignupPageSuccess('Signup Successful');
      } catch (e) {
        yield SignupPageFailure('Signup Failed');
      }
    }
  }
}
