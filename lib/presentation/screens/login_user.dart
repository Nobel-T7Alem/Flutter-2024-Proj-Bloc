import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/blocs/login_user/login_user_bloc.dart';
import 'package:Sebawi/blocs/login_user/login_user_state.dart';
import 'package:Sebawi/blocs/login_user/login_user_event.dart';


class LoginUser extends StatelessWidget {
  const LoginUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginUserBloc(),
      child: BlocListener<LoginUserBloc, LoginUserState>(
        listener: (context, state) {
          if (state is LoginUserNavigationSuccess) {
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
                        'Login',
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
                            'Welcome back.',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    const CustomTextFormField(
                      labelText: 'Username',
                    ),
                    const SizedBox(height: 10.0),
                    const CustomTextFormField(
                      labelText: 'Password',
                      obscureText: true,
                    ),
                    const SizedBox(height: 40.0),
                    CustomButton(
                        buttonText: 'Login',
                        buttonColor: const Color.fromARGB(255, 83, 171, 71),
                        buttonTextColor: Colors.white,
                        buttonAction: () {
                          BlocProvider.of<LoginUserBloc>(context).add(LoginSubmitted());
                        }),
                    Padding(
                      padding: const EdgeInsets.all(17),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(right: 4.0),
                              child: Text('No account?'),
                            ),
                            GestureDetector(
                              onTap: () {
                                BlocProvider.of<LoginUserBloc>(context).add(NavigateToSignupEvent());
                              },
                              child: const Text(
                                'Signup',
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

