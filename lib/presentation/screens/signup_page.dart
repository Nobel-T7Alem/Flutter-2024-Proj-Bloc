import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/signup/signup_page_bloc.dart';
import '../../blocs/signup/signup_page_event.dart';
import '../../blocs/signup/signup_page_state.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupPageBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Signup Page'),
        ),
        body: BlocListener<SignupPageBloc, SignupPageState>(
          listener: (context, state) {
            if (state is SignupPageSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is SignupPageFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<SignupPageBloc, SignupPageState>(
            builder: (context, state) {
              if (state is SignupPageLoading) {
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
                          BlocProvider.of<SignupPageBloc>(context).add(
                            SubmitSignup(
                              'username',
                              'email@example.com',
                              'password',
                            ),
                          );
                        },
                        child: Text('Sign Up'),
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
