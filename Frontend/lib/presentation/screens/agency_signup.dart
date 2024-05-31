import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/presentation/Events/agency_signup_event.dart';
import 'package:Sebawi/application/agency_signup/agency_signup_bloc.dart';
import 'package:Sebawi/presentation/States/agency_signup_state.dart';
import '../../data/models/validate_form.dart';

class AgencySignup extends StatelessWidget {
  const AgencySignup({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AgencySignupBloc()..add(const AgencySignupInitialEvent()),
      child: BlocListener<AgencySignupBloc, AgencySignupState>(
        listener: (context, state) {
          if (state is NavigateToAdminHome) {
            context.go("/agency_home");
          } else if (state is NavigateToAdminLogin) {
            context.go("/user_login");
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    context.go('/signup');
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: BlocBuilder<AgencySignupBloc, AgencySignupState>(
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
                          'Share your Agencying opportunities.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Form(
                    key: state.formKey,
                    child: Column(children: [
                      const SizedBox(height: 8.0),
                      CustomTextFormField(
                        labelText: 'Agency name',
                        obscureText: false,
                        onChange: (val) {
                          BlocProvider.of<AgencySignupBloc>(context).add(
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
                        obscureText: false,
                        onChange: (val) {
                          BlocProvider.of<AgencySignupBloc>(context).add(
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
                        obscureText: false,
                        onChange: (val) {
                          BlocProvider.of<AgencySignupBloc>(context).add(
                              UsernameChangedEvent(
                                  username: ValidateForm(value: val!)));
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
                          BlocProvider.of<AgencySignupBloc>(context).add(
                              PasswordChangedEvent(
                                  password: ValidateForm(value: val!)));
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
                          BlocProvider.of<AgencySignupBloc>(context).add(
                              ConfirmPasswordChangedEvent(
                                  confirmPassword: ValidateForm(value: val!)));
                        },
                        validator: (val) {
                          return state.confirmPassword.error;
                        },
                      ),
                      if (state.apiError != null)
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Center(
                            child: Text(
                              state.apiError!,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      const SizedBox(height: 40.0),
                      CustomButton(
                          buttonText: 'Signup',
                          buttonColor: const Color.fromARGB(255, 83, 171, 71),
                          buttonTextColor: Colors.white,
                          buttonAction: () async {
                            BlocProvider.of<AgencySignupBloc>(context)
                                .add(const AgencySignupButtonPressed());
                          }),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(17),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4.0),
                            child: Text('Already signed up?'),
                          ),
                          GestureDetector(
                            onTap: () {
                              BlocProvider.of<AgencySignupBloc>(context)
                                  .add(NavigateToLogin());
                            },
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 66, 148, 69),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          })),
        ),
      ),
    );
  }
}
