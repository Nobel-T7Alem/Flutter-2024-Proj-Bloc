import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:Sebawi/presentation/screens/admin_login.dart';
import 'package:Sebawi/presentation/screens/admin_page.dart';
import 'package:Sebawi/presentation/screens/agency_home.dart';
import 'package:Sebawi/presentation/screens/agency_signup.dart';
import 'package:Sebawi/presentation/screens/agency_update.dart';
import 'package:Sebawi/presentation/screens/home_page.dart';
import 'package:Sebawi/presentation/screens/login_page.dart';
import 'package:Sebawi/presentation/screens/login_user.dart';
import 'package:Sebawi/presentation/screens/signup_page.dart';
import 'package:Sebawi/presentation/screens/user_home.dart';
import 'package:Sebawi/presentation/screens/user_update.dart';
import 'package:Sebawi/presentation/screens/volunteer_signup.dart';

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
      name: 'signup',
      builder: (context, state) => const SignupPage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/admin_login',
      name: 'admin_login',
      builder: (context, state) => const AdminLoginPage(),
    ),
    GoRoute(
      path: '/user_login',
      name: 'user_login',
      builder: (context, state) => const LoginUserPage(),
    ),
    GoRoute(
      path: '/admin_page',
      name: 'admin_page',
      builder: (context, state) => const AdminPage(),
    ),
    GoRoute(
      path: '/agency_home',
      name: 'agency_home',
      builder: (context, state) => const AgencyHomePage(),
    ),
    GoRoute(
      path: '/agency_signup',
      name: 'agency_signup',
      builder: (context, state) => const AgencySignupPage(),
    ),
    GoRoute(
      path: '/agency_update',
      name: 'agency_update',
      builder: (context, state) => const AgencyUpdatePage(),
    ),
    GoRoute(
      path: '/user_home',
      name: 'user_home',
      builder: (context, state) => const UserHomePage(),
    ),
    GoRoute(
      path: '/user_update',
      name: 'user_update',
      builder: (context, state) => const UserUpdatePage(),
    ),
    GoRoute(
      path: '/volunteer_signup',
      name: 'volunteer_signup',
      builder: (context, state) => const VolunteerSignupPage(),
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
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: () {
              context.go('/');
            },
            child: const Text(
              'Return to Home Page',
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    ),
  ),
);
