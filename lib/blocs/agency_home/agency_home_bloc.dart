import 'package:bloc/bloc.dart';
import 'agency_home_event.dart';
import 'agency_home_state.dart';

class AgencyHomeBloc extends Bloc<AgencyHomeEvent, AgencyHomeState> {
  AgencyHomeBloc() : super(AgencyHomeInitial());

  @override
  Stream<AgencyHomeState> mapEventToState(AgencyHomeEvent event) async* {
    if (event is LoadAgencyHomePage) {
      yield AgencyHomeLoading();
      try {
        // Simulate fetching data
        await Future.delayed(const Duration(seconds: 2));
        yield const AgencyHomeLoaded('Agency Home Page Data Loaded');
      } catch (e) {
        yield const AgencyHomeError('Failed to load agency home page data');
      }
    }
  }
}
