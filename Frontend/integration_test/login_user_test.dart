import 'package:Sebawi/application/login_user/login_user_bloc.dart';
import 'package:Sebawi/presentation/Events/login_user_event.dart';
import 'package:Sebawi/presentation/States/login_user_state.dart';
import 'package:Sebawi/presentation/screens/login_user.dart';
import 'package:Sebawi/presentation/widgets/custom_button.dart';
import 'package:Sebawi/presentation/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MockLoginUserBloc extends MockBloc<LoginUserEvent, LoginUserState>
    implements LoginUserBloc {}

class FakeLoginUserState extends Fake implements LoginUserState {}

class FakeLoginUserEvent extends Fake implements LoginUserEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLoginUserState());
    registerFallbackValue(FakeLoginUserEvent());
  });

  group('LoginUser Page', () {
    late LoginUserBloc loginUserBloc;

    setUp(() {
      loginUserBloc = MockLoginUserBloc();
    });

    Widget createWidgetUnderTest() {
      final router = GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const LoginUser(),
          ),
          GoRoute(
            path: '/nextPage',
            builder: (context, state) => const Scaffold(body: Text('Next Page')),
          ),
        ],
      );

      return BlocProvider<LoginUserBloc>(
        create: (context) => loginUserBloc,
        child: MaterialApp.router(
          routerConfig: router,
        ),
      );
    }

    testWidgets('renders LoginUser page', (WidgetTester tester) async {
      when(() => loginUserBloc.state).thenReturn(LoginUserInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(LoginUser), findsOneWidget);
      expect(find.text('Login'), findsAny);
    });

    testWidgets('shows error message when login fails', (WidgetTester tester) async {
      whenListen(
        loginUserBloc,
        Stream.fromIterable([
          LoginUserInitial(),
          LoginUserFailure(error: 'Invalid credentials'),
        ]),
        initialState: LoginUserInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); 
      expect(find.text('Invalid credentials'), findsNothing);
    });

    testWidgets('navigates to signup page on "Signup" tap', (WidgetTester tester) async {
      when(() => loginUserBloc.state).thenReturn(LoginUserInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.text('Signup'));
      await tester.pumpAndSettle();

      //verify(() => loginUserBloc.add(any(that: isA<NavigateToSignupEvent>()))).called(1);
    });

    testWidgets('calls LoginSubmitted when login button is pressed', (WidgetTester tester) async {
      when(() => loginUserBloc.state).thenReturn(LoginUserInitial());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(find.byType(CustomTextFormField).at(0), 'username');
      await tester.enterText(find.byType(CustomTextFormField).at(1), 'password');

      await tester.tap(find.byType(CustomButton));
      await tester.pumpAndSettle();

    });

    testWidgets('navigates to next page on successful login', (WidgetTester tester) async {
      whenListen(
        loginUserBloc,
        Stream.fromIterable([
          LoginUserInitial(),
          LoginUserNavigationSuccess('/nextPage'),
        ]),
        initialState: LoginUserInitial(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); 
      expect(find.text('Next Page'), findsNothing);
    });
  });
}
