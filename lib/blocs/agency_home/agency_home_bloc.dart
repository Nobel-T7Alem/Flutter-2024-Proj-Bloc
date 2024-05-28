import 'package:bloc/bloc.dart';
import 'agency_home_event.dart';
import 'agency_home_state.dart';
import 'package:Sebawi/presentation/screens/agency_home.dart';

class AgencyHomeBloc extends Bloc<AgencyHomeEvent, AgencyHomeState> {
  AgencyHomeBloc() : super(AgencyHomeInitial()) {
    on<LoadAgencyHomePage>(_onLoadAgencyHomePage);
    on<NavigateToAgencyUpdateEvent>(_onNavigateToAgencyUpdate);
  }

  void _onLoadAgencyHomePage(LoadAgencyHomePage event, Emitter<AgencyHomeState> emit) {
    emit(AgencyHomeLoading());
    try {
      // Simulate data loading
      final posts = [
        Post(
          agencyName: "Mekedonia",
          contactInfo: "09113124",
          serviceType: "Money and Labor",
        ),
        Post(
          agencyName: "Gergesenon",
          contactInfo: "09113523",
          serviceType: "Sanitary Products",
        ),
      ];
      emit(AgencyHomeLoaded(posts));
    } catch (e) {
      emit(AgencyHomeError('Failed to load posts'));
    }
  }

  void _onNavigateToAgencyUpdate(NavigateToAgencyUpdateEvent event, Emitter<AgencyHomeState> emit) {
    emit(AgencyHomeNavigationSuccess('/agency_update'));
  }
}
