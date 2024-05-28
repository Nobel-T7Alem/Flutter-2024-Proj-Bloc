import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app_router.dart';
import 'blocs/home/home_page_bloc.dart';
import 'blocs/login/login_page_bloc.dart';
import 'blocs/admin_login/admin_login_bloc.dart';
import 'blocs/admin_page/admin_page_bloc.dart';
import 'blocs/agency_home/agency_home_bloc.dart';
import 'blocs/agency_signup/agency_signup_bloc.dart';
import 'blocs/agency_update/agency_update_bloc.dart';
import 'blocs/user_home/user_home_bloc.dart';
import 'blocs/user_update/user_update_bloc.dart';
import 'blocs/volunteer_signup/volunteer_signup_bloc.dart';
import 'blocs/signup/signup_page_bloc.dart';
import 'blocs/login_user/login_user_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageBloc()),
        BlocProvider(create: (context) => LoginPageBloc()),
        BlocProvider(create: (context) => AdminLoginBloc()),
        BlocProvider(create: (context) => AdminPageBloc()),
        BlocProvider(create: (context) => AgencyHomeBloc()),
        BlocProvider(create: (context) => AgencySignupBloc()),
        BlocProvider(create: (context) => AgencyUpdateBloc()),
        BlocProvider(create: (context) => UserHomeBloc()),
        BlocProvider(create: (context) => UserUpdateBloc()),
        BlocProvider(create: (context) => VolunteerSignupBloc()),
        BlocProvider(create: (context) => SignupPageBloc()),
        BlocProvider(create: (context) => LoginUserBloc()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Sebawi',
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
