import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/agency_home/agency_home_bloc.dart';
import '../../blocs/agency_home/agency_home_event.dart';
import '../../blocs/agency_home/agency_home_state.dart';

class AgencyHomePage extends StatelessWidget {
  const AgencyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgencyHomeBloc()..add(LoadAgencyHomePage()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agency Home Page'),
        ),
        body: BlocBuilder<AgencyHomeBloc, AgencyHomeState>(
          builder: (context, state) {
            if (state is AgencyHomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AgencyHomeLoaded) {
              return Center(child: Text(state.data));
            } else if (state is AgencyHomeError) {
              return Center(child: Text(state.error));
            } else {
              return const Center(child: Text('Welcome to Agency Home Page'));
            }
          },
        ),
      ),
    );
  }
}
