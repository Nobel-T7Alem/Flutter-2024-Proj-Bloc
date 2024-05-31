import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../application/admin_login/admin_login_bloc.dart';
import '../../application/admin_login/admin_login_event.dart';
import '../../application/admin_login/admin_login_state.dart';

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  _AdminLoginPageState createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminLoginBloc(),
      child: BlocListener<AdminLoginBloc, AdminLoginState>(
        listener: (context, state) {
          if (state is AdminLoginSuccess) {
            context.go('/admin_page');
          } else if (state is AdminLoginFailure) {
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Login Failed'),
                content: const Text('Invalid username or password.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Close'),
                    onPressed: () {
                      context.pop();
                    },
                  ),
                ],
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Admin Login'),
            backgroundColor: Colors.lightGreen.withOpacity(0.5),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AdminLoginBloc>(context).add(
                        AdminLoginSubmitted(
                          username: _usernameController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.green[800]!, width: 3),
                      ),
                      shadowColor: Colors.greenAccent,
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
