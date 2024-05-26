import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/login_user/login_user_bloc.dart';
import '../../blocs/login_user/login_user_event.dart';
import '../../blocs/login_user/login_user_state.dart';

class LoginUserPage extends StatelessWidget {
  const LoginUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginUserBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Login as User'),
        ),
        body: BlocListener<LoginUserBloc, LoginUserState>(
          listener: (context, state) {
            if (state is LoginUserSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is LoginUserFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<LoginUserBloc, LoginUserState>(
            builder: (context, state) {
              if (state is LoginUserLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Use your actual input fields to get values
                          BlocProvider.of<LoginUserBloc>(context).add(
                            LoginUserRequested(
                              'email@example.com',
                              'password',
                            ),
                          );
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
