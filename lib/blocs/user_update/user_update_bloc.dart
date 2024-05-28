import 'package:bloc/bloc.dart';
import 'user_update_event.dart';
import 'user_update_state.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  UserUpdateBloc() : super(UserUpdateInitial()) {
    on<SubmitUserUpdate>(_onSubmitUserUpdate);
  }

  void _onSubmitUserUpdate(SubmitUserUpdate event, Emitter<UserUpdateState> emit) {
    // Perform some update logic here, such as API calls

    // Navigate to a success page or another relevant page
    emit(UserUpdateNavigationSuccess('/profile_success'));
  }
}
