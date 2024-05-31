import 'package:bloc/bloc.dart';
import '../../data/models/calendars.dart';
import '../../data/models/posts.dart';
import '../../presentation/Events/user_home_event.dart';
import '../../presentation/States/user_home_state.dart';
import '../../data/services/api_path.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(UserHomeInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<NavigateToUserUpdateEvent>(_onNavigateToUserUpdate);
    on<AddToCalendarEvent>(_onAddToCalendar);
    on<LoadCalendarEvent>(_onLoadCalendar);
  }

  void _onLoadPosts(LoadPostsEvent event, Emitter<UserHomeState> emit) async {
    try {
      final posts = await RemoteService().getPosts();
      emit(UserHomeLoaded(posts!));
    } catch (e) {
      emit(UserHomeError());
    }
  }

  void _onAddToCalendar(AddToCalendarEvent event, Emitter<UserHomeState> emit) async {
    final post = await RemoteService().addToCalendar(event.date, event.id);
    if (post != null) {
      // emit(UserHomeLoaded(post);
    } else {
      emit(UserHomeError());
    }
  }

  void _onLoadCalendar(LoadCalendarEvent event, Emitter<UserHomeState> emit) async {
    try {
      final  posts = await RemoteService().getCalendar();
      if (posts == null) {
        print("Failed to load calendar.");
        emit(CalendarError());
        return;
      }
      emit(CalendarLoaded(posts));
    } catch (e) {
      emit(CalendarError());
    }
  }

  void _onNavigateToUserUpdate(NavigateToUserUpdateEvent event, Emitter<UserHomeState> emit) {
    emit(const UserHomeNavigationSuccess('/user_update'));
  }
}
