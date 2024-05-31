import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../application/admin_page/admin_page_bloc.dart';
import '../../application/admin_page/admin_page_event.dart';
import '../../application/admin_page/admin_page_state.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminPageBloc()..add(LoadAdminPage()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Page'),
        ),
        body: BlocBuilder<AdminPageBloc, AdminPageState>(
          builder: (context, state) {
            if (state is AdminPageLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AdminPageLoaded) {
              return Center(child: Text(state.data));
            } else if (state is AdminPageError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text('Welcome to Admin Page'));
            }
          },
        ),
      ),
    );
  }
}
