import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/application/user_update/user_update_bloc.dart';
import 'package:Sebawi/presentation/Events/user_update_event.dart';
import 'package:Sebawi/presentation/States/user_update_state.dart';
import '../../data/models/validate_form.dart';
import '../../data/services/api_path.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class ProfileUpdate extends StatelessWidget {
  ProfileUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserUpdateBloc()..add(const UserUpdateInitialEvent()),
      child: BlocListener<UserUpdateBloc, UserUpdateState>(
        listener: (context, state) {
          if (state is UserUpdateNavigationSuccess) {
            context.go(state.route);
          }
        },
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.go('/user_home');
                },
              ),
              title: const Text('Update Profile'),
            ),
            body: BlocBuilder<UserUpdateBloc, UserUpdateState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: state.formKey,
                    child: ListView(
                      children: <Widget>[
                        CustomTextFormField(
                          labelText: 'New Username',
                          obscureText: false,
                          onChange: (val) => {
                            BlocProvider.of<UserUpdateBloc>(context).add(
                                UsernameChangedEvent(
                                    username: ValidateForm(value: val!)))
                          },
                        ),
                        CustomTextFormField(
                          labelText: 'New Password',
                          onChange: (val) => {
                            BlocProvider.of<UserUpdateBloc>(context).add(
                                PasswordChangedEvent(
                                    password: ValidateForm(value: val!)))
                          },
                        ),
                        if (state.apiError != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Center(child:Text(
                              state.apiError!,
                              style: const TextStyle(color: Colors.red),
                            ), )
                          ),
                        if (state.apiMessage != null)
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Center(child:Text(
                                state.apiError!,
                                style:  TextStyle(color: Colors.green[800]),
                              ), )
                          ),
                        const SizedBox(height: 20),
                        CustomButton(
                            buttonText: 'Update Profile',
                            buttonColor: Colors.green,
                            buttonTextColor: Colors.white,
                            buttonAction: () async {
                              BlocProvider.of<UserUpdateBloc>(context)
                                  .add(const SubmitUserUpdateEvent());
                            }),
                        const SizedBox(height: 20),
                        CustomButton(
                          buttonText: 'Delete Account',
                          buttonColor: Colors.red,
                          buttonTextColor: Colors.white,
                          buttonAction: () {
                            BlocProvider.of<UserUpdateBloc>(context)
                                .add(const DeleteAccountEvent());
                            context.go("/");
                          },
                        ),
                        const SizedBox(height: 100),
                        TextButton(
                          onPressed: () {
                            SharedPreferenceService sharedPrefService =
                                SharedPreferenceService();
                            sharedPrefService.writeCache(
                                key: "token", value: "");
                            context.go("/");
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.red,
                            // Text color
                          ),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
