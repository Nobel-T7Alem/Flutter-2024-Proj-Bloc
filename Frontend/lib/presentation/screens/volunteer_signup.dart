import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sebawi/blocs/volunteer_signup/volunteer_signup_bloc.dart';
import 'package:Sebawi/blocs/volunteer_signup/volunteer_signup_state.dart';
import 'package:Sebawi/blocs/volunteer_signup/volunteer_signup_event.dart';
import 'package:go_router/go_router.dart';

import '../../data/models/validate_form.dart';

class VolunteerSignup extends StatelessWidget {
  const VolunteerSignup({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          VolunteerSignupBloc()..add(const VolunteerSignupInitialEvent()),
      child: BlocListener<VolunteerSignupBloc, VolunteerSignupState>(
        listener: (context, state) {
          if (state is NavigateToUserHome) {
            context.go('/user_home');
          } else if (state is NavigateToUserLogin) {
            context.go('/user_login');
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              body: BlocBuilder<VolunteerSignupBloc, VolunteerSignupState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Image.asset(
                        'assets/images/sebawilogo.png',
                        width: 140.0,
                        height: 140.0,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 35),
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 2.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8.0),
                          Text(
                            'Do something good today.',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Form(
                      key: state.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            labelText: 'Full name',
                            onChange: (val) {
                              BlocProvider.of<VolunteerSignupBloc>(context).add(
                                  NameChangedEvent(
                                      name: ValidateForm(value: val!)));
                            },
                            validator: (val) {
                              return state.name.error;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          CustomTextFormField(
                            labelText: 'Enter Email',
                            onChange: (val) {
                              BlocProvider.of<VolunteerSignupBloc>(context).add(
                                  EmailChangedEvent(
                                      email: ValidateForm(value: val!)));
                            },
                            validator: (val) {
                              return state.email.error;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          CustomTextFormField(
                            labelText: 'Create Username',
                            onChange: (val) {
                              BlocProvider.of<VolunteerSignupBloc>(context).add(
                                  UsernameChangedEvent(
                                      username:
                                          ValidateForm(value: val!)));
                            },
                            validator: (val) {
                              return state.username.error;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          CustomTextFormField(
                            labelText: 'Create Password',
                            obscureText: false,
                            onChange: (val) {
                              BlocProvider.of<VolunteerSignupBloc>(context).add(
                                  PasswordChangedEvent(
                                      password:
                                          ValidateForm(value: val!)));
                            },
                            validator: (val) {
                              return state.password.error;
                            },
                          ),
                          const SizedBox(height: 10.0),
                          CustomTextFormField(
                            labelText: 'Confirm Password',
                            obscureText: true,
                            onChange: (val) {
                              BlocProvider.of<VolunteerSignupBloc>(context).add(
                                  ConfirmPasswordChangedEvent(
                                      confirmPassword:
                                          ValidateForm(value: val!)));
                            },
                            validator: (val) {
                              return state.confirmPassword.error;
                            },
                          ),
                          if (state.apiError != null)
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                              child: Text(
                                state.apiError!,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),

                          const SizedBox(height: 40.0),
                          CustomButton(
                            buttonText: 'Sign up',
                            buttonColor: const Color.fromARGB(255, 83, 171, 71),
                            buttonTextColor: Colors.white,
                            buttonAction: () async {
                              BlocProvider.of<VolunteerSignupBloc>(context)
                                  .add(const SignupButtonPressed());
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(17),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already signed up?'),
                            TextButton(
                              onPressed: () {
                                context.go('/user_login');
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 66, 148, 69)),
                                textStyle: MaterialStateProperty.all<TextStyle>(
                                  const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              child: const Text('Log In'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
        ),
      ),
    );
  }
}
