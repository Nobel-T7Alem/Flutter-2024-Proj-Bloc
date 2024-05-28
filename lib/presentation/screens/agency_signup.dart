import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/blocs/agency_signup/agency_signup_event.dart';
import 'package:Sebawi/blocs/agency_signup/agency_signup_bloc.dart';
import 'package:Sebawi/blocs/agency_signup/agency_signup_state.dart';

class AgencySignup extends StatefulWidget {
  const AgencySignup({super.key});

  @override
  _AgencySignupState createState() => _AgencySignupState();
}

class _AgencySignupState extends State<AgencySignup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AgencySignupBloc(),
      child: BlocListener<AgencySignupBloc, AgencySignupState>(
        listener: (context, state) {
          if (state is AgencySignupNavigationSuccess) {
            context.go(state.route);
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Container(
              child: SingleChildScrollView(
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
                            'Share your volunteering opportunities.',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const CustomTextFormField(
                      labelText: 'Agency name',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10.0),
                    const CustomTextFormField(
                      labelText: 'Enter Email',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10.0),
                    const CustomTextFormField(
                      labelText: 'Create Username',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10.0),
                    const CustomTextFormField(
                      labelText: 'Create Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 10.0),
                    const CustomTextFormField(
                      labelText: 'Confirm Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 40.0),
                    CustomButton(
                        buttonText: 'Signup',
                        buttonColor: const Color.fromARGB(255, 83, 171, 71),
                        buttonTextColor: Colors.white,
                        buttonAction: () {
                          BlocProvider.of<AgencySignupBloc>(context).add(AgencySignupSubmitted(
                            agencyData: {
                              'username': _usernameController.text,
                              'password': _passwordController.text,
                            },
                          ));
                        }),
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
                                BlocProvider.of<AgencySignupBloc>(context).add(NavigateToLogin());
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
