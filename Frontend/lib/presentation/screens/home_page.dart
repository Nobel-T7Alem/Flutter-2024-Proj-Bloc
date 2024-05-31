import 'package:Sebawi/presentation/screens/admin_page.dart';
import 'package:Sebawi/presentation/screens/agency_home.dart';
import 'package:Sebawi/presentation/screens/agency_signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'login_page.dart';
import 'package:Sebawi/application/home/home_page_bloc.dart';
import 'package:Sebawi/presentation/Events/home_page_event.dart';
import 'package:Sebawi/presentation/States/home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc(),
      child: BlocListener<HomePageBloc, HomePageState>(
        listener: (context, state) {
          if (state is HomePageNavigationSuccess) {
            context.go(state.route);
          }
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const LoginPage(),
          theme: ThemeData(
            textTheme: const TextTheme(
              bodyLarge: TextStyle(fontSize: 20),
              bodyMedium: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}
