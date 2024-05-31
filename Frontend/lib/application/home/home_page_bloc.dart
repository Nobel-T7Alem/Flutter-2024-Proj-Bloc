import 'package:bloc/bloc.dart';
import '../../presentation/Events/home_page_event.dart';
import '../../presentation/States/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<NavigateToLoginPage>(_onNavigateToLoginPage);
  }

  void _onNavigateToLoginPage(NavigateToLoginPage event, Emitter<HomePageState> emit) {
    emit(HomePageNavigationSuccess('/login'));
  }
}
