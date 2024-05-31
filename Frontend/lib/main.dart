import 'package:Sebawi/application/login/login_page_bloc.dart';
import 'package:Sebawi/application/signup_page/signup_page.bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import './presentation/screens/login_page.dart';
import './presentation/screens/admin_login.dart';
import './application/admin_login/admin_login_bloc.dart';
import './application/admin_page/admin_page_bloc.dart';
import 'application/agency_home/agency_home_bloc.dart';
import 'application/agency_signup/agency_signup_bloc.dart';
import 'application/agency_update/agency_update_bloc.dart';
import 'application/user_home/user_home_bloc.dart';
import 'application/user_update/user_update_bloc.dart';
import 'application/volunteer_signup/volunteer_signup_bloc.dart';
import 'application/login_user/login_user_bloc.dart';
import 'presentation/screens/admin_page.dart';
import 'presentation/screens/agency_home.dart';
import 'presentation/screens/agency_signup.dart';
import 'presentation/screens/agency_update.dart';
import 'presentation/screens/home_page.dart';
import 'presentation/screens/login_user.dart';
import 'presentation/screens/signup_page.dart';
import 'presentation/screens/user_home.dart';
import 'presentation/screens/user_update.dart';
import 'presentation/screens/volunteer_signup.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/signup',
      name: "signup",
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: '/login',
      name: "login",
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/admin',
      name: "admin",
      builder: (context, state) => const AdminPage(),
    ),
    GoRoute(
      path: '/user_login',
      name: "user_login",
      builder: (context, state) =>  LoginUser(),
    ),
    GoRoute(
      path: '/admin_login',
      name: "admin_login",
      builder: (context, state) => const AdminLoginPage(),
    ),
    GoRoute(
      path: '/user_home',
      name: "user_home",
      builder: (context, state) => const UserHomePage(),
    ),
    GoRoute(
      path: '/volunteer_signup',
      name: "volunteer_signup",
      builder: (context, state) => VolunteerSignup(),
    ),
    GoRoute(
      path: '/agency_signup',
      name: "agency_signup",
      builder: (context, state) => const AgencySignup(),
    ),
    GoRoute(
        path: '/agency_home',
        name: "agency_home",
        builder: (context, state) => const AgencyHomePage()),
    GoRoute(
      path: '/user_update',
      name: "user_update",
      builder: (context, state) => const UserUpdate(),
    ),
    GoRoute(
      path: '/agency_update',
      name: "agency_update",
      builder: (context, state) => const AgencyUpdate(),
    ),
    GoRoute(
      path: '/admin_page',
      name: "admin_page",
      builder: (context, state) => const AdminPage(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Error: ${state.error}',
            style: const TextStyle(fontSize: 20),
          ),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text('Go Home'),
          ),
        ],
      ),
    ),
  ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => AdminLoginBloc()),
        BlocProvider(create: (context) => AdminPageBloc()),
        BlocProvider(create: (context) => AgencyHomeBloc()),
        BlocProvider(create: (context) => AgencySignupBloc()),
        BlocProvider(create: (context) => AgencyUpdateBloc()),
        BlocProvider(create: (context) => UserHomeBloc()),
        BlocProvider(create: (context) => UserUpdateBloc()),
        BlocProvider(create: (context) => VolunteerSignupBloc()),
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => LoginUserBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Your App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.green,
          ).copyWith(
            secondary: Colors.green[800],
            surface: Colors.lightGreen.withOpacity(0.5),
          ),
          scaffoldBackgroundColor: Colors.white,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen.withOpacity(0.5),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
                side: BorderSide(color: Colors.green[800]!, width: 3),
              ),
              shadowColor: Colors.greenAccent,
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: Colors.green[800],
            foregroundColor: Colors.white,
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: Colors.green[800],
            ),
          ),
        ),
        routerConfig: router,
      ),
    );
  }
}
