import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/home/home_page_bloc.dart';
import '../../blocs/home/home_page_event.dart';
import '../../blocs/home/home_page_state.dart';
import 'login_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageBloc()..add(LoadHomePage()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: BlocBuilder<HomePageBloc, HomePageState>(
            builder: (context, state) {
              if (state is HomePageLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is HomePageLoaded) {
                return LoginPage(); // Adjust as necessary for your logic
              } else if (state is HomePageError) {
                return Center(child: Text(state.error));
              } else {
                return Center(child: Text('Welcome to Home Page'));
              }
            },
          ),
        ),
        theme: ThemeData(
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontSize: 20),
            bodyMedium: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
