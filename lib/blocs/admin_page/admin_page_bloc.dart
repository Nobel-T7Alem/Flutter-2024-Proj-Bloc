import 'package:bloc/bloc.dart';
import 'admin_page_event.dart';
import 'admin_page_state.dart';

class AdminPageBloc extends Bloc<AdminPageEvent, AdminPageState> {
  AdminPageBloc() : super(AdminPageInitial()) {
    on<LoadAdminPage>(_onLoadAdminPage);
  }

  void _onLoadAdminPage(LoadAdminPage event, Emitter<AdminPageState> emit) {
    emit(AdminPageLoading());
    try {
      // Simulate data loading
      final data = 'Admin Page Data Loaded';
      emit(AdminPageLoaded(data));
    } catch (e) {
      emit(AdminPageError('Failed to load admin page data'));
    }
  }
}
