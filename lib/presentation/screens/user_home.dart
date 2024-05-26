import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/user_home/user_home_bloc.dart';
import '../../blocs/user_home/user_home_event.dart';
import '../../blocs/user_home/user_home_state.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserHomeBloc()..add(LoadUserHomePage()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Home Page'),
        ),
        body: BlocBuilder<UserHomeBloc, UserHomeState>(
          builder: (context, state) {
            if (state is UserHomeLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is UserHomeLoaded) {
              return Center(child: Text(state.data));
            } else if (state is UserHomeError) {
              return Center(child: Text(state.error));
            } else {
              return Center(child: Text('Welcome to User Home Page'));
            }
          },
        ),
      ),
    );
  }
}
