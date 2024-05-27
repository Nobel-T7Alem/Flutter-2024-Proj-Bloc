import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/agency_update/agency_update_bloc.dart';
import '../../blocs/agency_update/agency_update_event.dart';
import '../../blocs/agency_update/agency_update_state.dart';

class AgencyUpdatePage extends StatelessWidget {
  const AgencyUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgencyUpdateBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agency Update'),
        ),
        body: BlocListener<AgencyUpdateBloc, AgencyUpdateState>(
          listener: (context, state) {
            if (state is AgencyUpdateSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AgencyUpdateFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          child: BlocBuilder<AgencyUpdateBloc, AgencyUpdateState>(
            builder: (context, state) {
              if (state is AgencyUpdateLoading) {
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
                        decoration: InputDecoration(labelText: 'Address'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Use your actual input fields to get values
                          BlocProvider.of<AgencyUpdateBloc>(context).add(
                            const SubmitAgencyUpdate(
                              'Agency Name',
                              'email@example.com',
                              'address',
                            ),
                          );
                        },
                        child: const Text('Update'),
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
