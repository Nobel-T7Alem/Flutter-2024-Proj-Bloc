import 'package:bloc/bloc.dart';
import 'user_home_event.dart';
import 'user_home_state.dart';
import '../../data/services/api_path.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(UserHomeInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<NavigateToUserUpdateEvent>(_onNavigateToUserUpdate);
    on<AddToCalendarEvent>(_onAddToCalendar);
    on<LoadCalendarEvent>(_onLoadCalendar);
  }

  void _onLoadPosts(LoadPostsEvent event, Emitter<UserHomeState> emit) async {
    emit(UserHomeLoading());
    try {
      final posts = await RemoteService().getPosts();
      emit(UserHomeLoaded(posts!));
    } catch (e) {
      emit(UserHomeError());
    }
  }

  void _onAddToCalendar(AddToCalendarEvent event, Emitter<UserHomeState> emit) async {
    print("date");
    print(event.date);

    print(event.id);
    final post = await RemoteService().addToCalendar(event.date, event.id);
    if (post != null) {
      // emit(UserHomeLoaded(post);
    } else {
      emit(UserHomeError());
    }
  }

  void _onLoadCalendar(LoadCalendarEvent event, Emitter<UserHomeState> emit) async {
    emit(CalendarLoading());
    try {
      final calendars = await RemoteService().getCalendar();
      if (calendars == null) {
        emit(CalendarError());
        return;
      }
      emit(CalendarLoaded(calendars));
    } catch (e) {
      emit(CalendarError());
    }
  }

  void _onNavigateToUserUpdate(NavigateToUserUpdateEvent event, Emitter<UserHomeState> emit) {
    emit(UserHomeNavigationSuccess('/user_update'));
  }
}
