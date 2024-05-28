import 'package:Sebawi/presentation/widgets/profile_update_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sebawi/blocs/agency_update/agency_update_event.dart';
import 'package:Sebawi/blocs/agency_update/agency_update_bloc.dart';
import 'package:Sebawi/blocs/agency_update/agency_update_state.dart';
import 'package:go_router/go_router.dart';

class AgencyUpdate extends StatelessWidget {
  const AgencyUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgencyUpdateBloc(),
      child: BlocListener<AgencyUpdateBloc, AgencyUpdateState>(
        listener: (context, state) {
          if (state is AgencyUpdateNavigationSuccess) {
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
