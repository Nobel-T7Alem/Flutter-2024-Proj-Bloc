import 'package:bloc/bloc.dart';
import 'user_home_event.dart';
import 'user_home_state.dart';
import '../../data/services/api_path.dart';

class UserHomeBloc extends Bloc<UserHomeEvent, UserHomeState> {
  UserHomeBloc() : super(UserHomeInitial()) {
    on<LoadPostsEvent>(_onLoadPosts);
    on<NavigateToUserUpdateEvent>(_onNavigateToUserUpdate);
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

  void _onNavigateToUserUpdate(NavigateToUserUpdateEvent event, Emitter<UserHomeState> emit) {
    emit(UserHomeNavigationSuccess('/user_update'));
  }
}
