import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/agency_signup/agency_signup_bloc.dart';
import '../../blocs/agency_signup/agency_signup_event.dart';
import '../../blocs/agency_signup/agency_signup_state.dart';

class AgencySignupPage extends StatelessWidget {
  const AgencySignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgencySignupBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agency Signup'),
        ),
        body: BlocListener<AgencySignupBloc, AgencySignupState>(
          listener: (context, state) {
            if (state is AgencySignupSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AgencySignupFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<AgencySignupBloc, AgencySignupState>(
            builder: (context, state) {
              if (state is AgencySignupLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(labelText: 'Agency Name'),
                      ),
                      const TextField(
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      const TextField(
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Use your actual input fields to get values
                          BlocProvider.of<AgencySignupBloc>(context).add(
                            const SubmitAgencySignup(
                              'Agency Name',
                              'email@example.com',
                              'password',
                            ),
                          );
                        },
                        child: const Text('Sign Up'),
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
