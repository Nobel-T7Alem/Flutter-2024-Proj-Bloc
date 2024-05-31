import 'package:Sebawi/presentation/widgets/profile_update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/application/user_update/user_update_bloc.dart';
import 'package:Sebawi/application/user_update/user_update_event.dart';
import 'package:Sebawi/application/user_update/user_update_state.dart';

class UserUpdate extends StatelessWidget {
  const UserUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserUpdateBloc(),
      child: BlocListener<UserUpdateBloc, UserUpdateState>(
        listener: (context, state) {
          if (state is UserUpdateNavigationSuccess) {
            context.go(state.route);
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Update Profile'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ProfileUpdateForm(),
          ),
        ),
      ),
    );
  }
}
