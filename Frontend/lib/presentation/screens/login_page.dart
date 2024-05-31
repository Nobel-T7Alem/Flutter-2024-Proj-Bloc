import 'package:Sebawi/application/login/image_slider_bloc.dart';
import 'package:Sebawi/presentation/Events/image_slider_event.dart';
import 'package:Sebawi/presentation/States/image_slider_state.dart';
import 'package:Sebawi/application/login/login_page_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/presentation/Events/login_page_event.dart';
import 'package:Sebawi/presentation/States/login_page_state.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ImageSliderBloc()..add(StartSliding()),
        ),
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
      ],
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocBuilder<ImageSliderBloc, ImageSliderState>(
            builder: (context, state) {
              if (state is ImageSliderLoaded) {
                List<String> imageFiles = [
                  "assets/images/11.jpg",
                  "assets/images/15.jpg",
                  "assets/images/13.jpg",
                  "assets/images/7.jpg",
                  "assets/images/9.jpg",
                ];
                return PageView.builder(
                  controller: PageController(initialPage: state.currentIndex),
                  itemCount: imageFiles.length,
                  itemBuilder: (context, index) {
                    return Image.asset(
                      imageFiles[index],
                      fit: BoxFit.cover,
                    );
                  },
                );
              }
              return Container();
            },
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.black.withOpacity(0.5),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/sebawi2.png', width: 80),
                const SizedBox(height: 400),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(AdminLoginPressed());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.green[800]!, width: 3),
                      ),
                      elevation: 5,
                      shadowColor: Colors.greenAccent,
                    ),
                    child: const Text('Login as Admin'),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<LoginBloc>(context)
                          .add(UserLoginPressed());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen.withOpacity(0.5),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      textStyle: const TextStyle(fontSize: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: BorderSide(color: Colors.green[800]!, width: 3),
                      ),
                      elevation: 5,
                      shadowColor: Colors.green[800]!,
                    ),
                    child: const Text('Login as Volunteer/Agency'),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'New to the Sebawi Community? ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 3.0,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          BlocProvider.of<LoginBloc>(context)
                              .add(SignUpPressed());
                        },
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.green.shade800;
                              }
                              return Colors.lightGreen;
                            },
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            const TextStyle(
                              fontSize: 15,
                              shadows: [
                                Shadow(
                                  offset: Offset(1.0, 1.0),
                                  blurRadius: 3.0,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ),
                        ),
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is NavigateToAdminLogin) {
                      context.go('/admin_login');
                    } else if (state is NavigateToUserLogin) {
                      context.go('/user_login');
                    } else if (state is NavigateToSignUp) {
                      context.go('/signup');
                    }
                  },
                  child: Container(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
