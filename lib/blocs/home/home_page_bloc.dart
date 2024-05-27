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
      
      await Future.delayed(const Duration(seconds: 2));
      emit(const HomePageLoaded('Home Page Data Loaded'));
    } catch (e) {
      emit(const HomePageError('Failed to load home page data'));
    }
  }
}
