import 'package:bloc/bloc.dart';
import 'home_page_event.dart';
import 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<LoadHomePage>(_onLoadHomePage);
  }

  void _onLoadHomePage(LoadHomePage event, Emitter<HomePageState> emit) async {
    emit(HomePageLoading());
    try {
      // Simulate fetching data
      await Future.delayed(Duration(seconds: 2));
      emit(HomePageLoaded('Home Page Data Loaded'));
    } catch (e) {
      emit(HomePageError('Failed to load home page data'));
    }
  }
}
