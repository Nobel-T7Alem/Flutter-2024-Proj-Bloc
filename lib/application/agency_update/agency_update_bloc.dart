import 'package:bloc/bloc.dart';
import 'agency_update_event.dart';
import 'agency_update_state.dart';

class AgencyUpdateBloc extends Bloc<AgencyUpdateEvent, AgencyUpdateState> {
  AgencyUpdateBloc() : super(AgencyUpdateInitial()) {
    on<SubmitAgencyUpdate>(_onSubmitAgencyUpdate);
  }

  void _onSubmitAgencyUpdate(SubmitAgencyUpdate event, Emitter<AgencyUpdateState> emit) {
    // Perform update logic here (e.g., API call to update profile)

    // Navigate to a success page or another relevant page
    emit(AgencyUpdateNavigationSuccess('/profile_success'));
  }
}
