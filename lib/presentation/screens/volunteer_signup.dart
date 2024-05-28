import 'package:Sebawi/data/models/volunteer_signup_form.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Sebawi/blocs/volunteer_signup/volunteer_signup_bloc.dart';
import 'package:Sebawi/blocs/volunteer_signup/volunteer_signup_state.dart';
import 'package:Sebawi/blocs/volunteer_signup/volunteer_signup_event.dart';
import 'package:go_router/go_router.dart';


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
                            const SizedBox(height: 8.0),
                            CustomTextFormField(
                              labelText: 'Full name',
                              onChange:(val){
                                BlocProvider.of<VolunteerSignupBloc>(context).add(NameChangedEvent(name: VolunteerSignupForm(value: val!)));
                              },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r"[a-zA-Z]+|\s"),
                                  )
                                ],
                              obscureText: false,
                              validator: (val) {
                                return state.name.error;
                              }
                            ),
                            const SizedBox(height: 10.0),
                            CustomTextFormField(
                              onChange:(val){
                                BlocProvider.of<VolunteerSignupBloc>(context).add(EmailChangedEvent(email: VolunteerSignupForm(value: val!)));
                              },
                              labelText: 'Enter Email',
                              obscureText: false,
                              validator: (val) {
                                return state.email.error;
                              }
                            ),
                            const SizedBox(height: 10.0),
                            CustomTextFormField(
                              labelText: 'Create Username',
                              obscureText: false,
                              onChange: (val){
                                BlocProvider.of<VolunteerSignupBloc>(context).add(UsernameChangedEvent(username: VolunteerSignupForm(value: val!)));
                              },
                              validator: (val) {
                                return state.username.error;
                              }
                            ),
                            const SizedBox(height: 10.0),
                            CustomTextFormField(
                              labelText: 'Create Password',
                              obscureText: true,
                              onChange: (val){
                                BlocProvider.of<VolunteerSignupBloc>(context).add(PasswordChangedEvent(password: VolunteerSignupForm(value: val!)));
                              },
                              validator: (val) {
                                return state.password.error;
                              }
                            ),
                            const SizedBox(height: 10.0),
                            CustomTextFormField(
                              labelText: 'Confirm Password',
                              obscureText: true,
                              validator: (val) {
                                return state.confirmPassword.error;
                              },
                            ),
                            const SizedBox(height: 40.0),
                            CustomButton(
                              buttonText: 'Sign up',
                              buttonColor:
                                  const Color.fromARGB(255, 83, 171, 71),
                              buttonTextColor: Colors.white,
                              buttonAction: () async {
                              // BlocProvider.of<VolunteerSignupBloc>(context).add(const
                              // SignupButtonPressed(
                                  // name: VolunteerSignupForm(value: state.name.value),
                                  // email: VolunteerSignupForm(value: state.email.value),
                                  // username: VolunteerSignupForm(value: state.username.value),
                                  // password: VolunteerSignupForm(value: state.password.value),
                                  // confirmPassword: VolunteerSignupForm(value: state.confirmPassword.value),
                              // ));
                                // signup()


                              },
                            ),
                          ],
                        )),
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
                    )
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
