import 'package:Sebawi/data/services/api_path.dart';
import 'package:bloc/bloc.dart';
import 'admin_page_event.dart';
import 'admin_page_state.dart';

class AdminPageBloc extends Bloc<AdminPageEvent, AdminPageState> {
  AdminPageBloc() : super(AdminPageInitial()) {
    on<AdminPageInitialEvent>(_initState);
    on<LoadAccountsEvent>(_onLoadAccounts);
    on<DeleteAccountEvent>(_onDeleteAccount);
    on<ChangeRoleEvent>(_onChangeRole);
    on<LoadPostsEvent>(_onLoadPosts);
    on<DeletePostEvent>(_onDeletePost);
  }

  Future<void> _initState(
      AdminPageInitialEvent event, Emitter<AdminPageState> emit) async {
    add(LoadAccountsEvent());
  }

  Future<void> _onLoadAccounts(
      LoadAccountsEvent event, Emitter<AdminPageState> emit) async {
    final accounts = await RemoteService().getAccounts();
    try {
      if (accounts != null) {
        emit(AccountsLoaded(accounts));
      } else {
        emit(const AccountsError('Failed to load accounts'));
      }
      // Simulate data loading
    } catch (e) {
      emit(const AccountsError('Failed to load admin page data'));
    }
  }

  Future<void> _onLoadPosts(
      LoadPostsEvent event, Emitter<AdminPageState> emit) async {
    try {
      final posts = await RemoteService().getPosts();
      if (posts != null) {
        emit(PostsLoaded(posts));
      } else {
        emit(const PostsError('Failed to load posts'));
      }
    } catch (error) {
      emit(PostsError(error.toString()));
    }
  }

  Future<void> _onDeleteAccount(
      DeleteAccountEvent event, Emitter<AdminPageState> emit) async {
    print("trying");
    final id = event.account.id;
    await RemoteService().deleteAccount(id);
  }

  Future<void> _onChangeRole(
      ChangeRoleEvent event, Emitter<AdminPageState> emit) async {
    final account = event.account;
    await RemoteService().changeRole(account.id);
  }

  void _onDeletePost(
      DeletePostEvent event, Emitter<AdminPageState> emit) async{
    var id = event.post.id;
    await RemoteService().deletePost(id);
  }
}
