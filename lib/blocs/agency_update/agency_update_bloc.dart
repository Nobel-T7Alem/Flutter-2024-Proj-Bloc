import 'package:bloc/bloc.dart';
import 'agency_update_event.dart';
import 'agency_update_state.dart';

class AgencyUpdateBloc extends Bloc<AgencyUpdateEvent, AgencyUpdateState> {
  AgencyUpdateBloc() : super(AgencyUpdateInitial());

  @override
  Stream<AgencyUpdateState> mapEventToState(AgencyUpdateEvent event) async* {
    if (event is SubmitAgencyUpdate) {
      yield AgencyUpdateLoading();
      try {
        // Simulate an update process
        await Future.delayed(const Duration(seconds: 2));
        yield const AgencyUpdateSuccess('Agency Update Successful');
      } catch (e) {
        yield const AgencyUpdateFailure('Agency Update Failed');
      }
    }
  }
}
