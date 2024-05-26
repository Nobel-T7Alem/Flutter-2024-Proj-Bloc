import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/admin_login/admin_login_bloc.dart';
import '../../blocs/admin_login/admin_login_event.dart';
import '../../blocs/admin_login/admin_login_state.dart';

class AdminLoginPage extends StatelessWidget {
  const AdminLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLoginBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Login'),
        ),
        body: BlocListener<AdminLoginBloc, AdminLoginState>(
          listener: (context, state) {
            if (state is AdminLoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AdminLoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<AdminLoginBloc, AdminLoginState>(
            builder: (context, state) {
              if (state is AdminLoginLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Use your actual username and password fields
                          BlocProvider.of<AdminLoginBloc>(context).add(
                            AdminLoginRequested('username', 'password'),
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
