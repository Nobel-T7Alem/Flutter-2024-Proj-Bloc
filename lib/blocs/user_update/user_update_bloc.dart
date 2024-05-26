import 'package:bloc/bloc.dart';
import 'user_update_event.dart';
import 'user_update_state.dart';

class UserUpdateBloc extends Bloc<UserUpdateEvent, UserUpdateState> {
  UserUpdateBloc() : super(UserUpdateInitial());

  @override
  Stream<UserUpdateState> mapEventToState(UserUpdateEvent event) async* {
    if (event is SubmitUserUpdate) {
      yield UserUpdateLoading();
      try {
        // Simulate an update process
        await Future.delayed(Duration(seconds: 2));
        yield UserUpdateSuccess('User Update Successful');
      } catch (e) {
        yield UserUpdateFailure('User Update Failed');
      }
    }
  }
}
