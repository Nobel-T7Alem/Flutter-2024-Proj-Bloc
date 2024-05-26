import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/volunteer_signup/volunteer_signup_bloc.dart';
import '../../blocs/volunteer_signup/volunteer_signup_event.dart';
import '../../blocs/volunteer_signup/volunteer_signup_state.dart';

class VolunteerSignupPage extends StatelessWidget {
  const VolunteerSignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VolunteerSignupBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Volunteer Signup'),
        ),
        body: BlocListener<VolunteerSignupBloc, VolunteerSignupState>(
          listener: (context, state) {
            if (state is VolunteerSignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is VolunteerSignupFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<VolunteerSignupBloc, VolunteerSignupState>(
            builder: (context, state) {
              if (state is VolunteerSignupLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Name'),
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
                          BlocProvider.of<VolunteerSignupBloc>(context).add(
                            SubmitVolunteerSignup(
                              'name',
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
