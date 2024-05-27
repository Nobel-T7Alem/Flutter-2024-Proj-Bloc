import 'package:bloc/bloc.dart';
import 'admin_page_event.dart';
import 'admin_page_state.dart';

class AdminPageBloc extends Bloc<AdminPageEvent, AdminPageState> {
  AdminPageBloc() : super(AdminPageInitial());

  @override
  Stream<AdminPageState> mapEventToState(AdminPageEvent event) async* {
    if (event is LoadAdminPage) {
      yield AdminPageLoading();
      try {
        // Simulate fetching data
        await Future.delayed(const Duration(seconds: 2));
        yield const AdminPageLoaded('Admin Page Data Loaded');
      } catch (e) {
        yield const AdminPageError('Failed to load admin page data');
      }
    }
  }
}
