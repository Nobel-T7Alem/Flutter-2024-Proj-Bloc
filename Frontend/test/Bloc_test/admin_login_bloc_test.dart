import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:Sebawi/application/admin_login/admin_login_bloc.dart';
import 'package:Sebawi/application/admin_login/admin_login_event.dart';
import 'package:Sebawi/application/admin_login/admin_login_state.dart';

void main() {
  group('AdminLoginBloc', () {
    late AdminLoginBloc adminLoginBloc;

    setUp(() {
      adminLoginBloc = AdminLoginBloc();
    });

    tearDown(() {
      adminLoginBloc.close();
    });

    test('initial state is AdminLoginInitial', () {
      expect(adminLoginBloc.state, AdminLoginInitial());
    });

    blocTest<AdminLoginBloc, AdminLoginState>(
      'emits [AdminLoginLoading, AdminLoginSuccess] when AdminLoginSubmitted is added with correct credentials',
      build: () => adminLoginBloc,
      act: (bloc) => bloc.add(const AdminLoginSubmitted(username: 'admin', password: 'password')),
      expect: () => [AdminLoginSuccess()],
    );

    blocTest<AdminLoginBloc, AdminLoginState>(
      'emits [AdminLoginLoading, AdminLoginFailure] when AdminLoginSubmitted is added with incorrect credentials',
      build: () => adminLoginBloc,
      act: (bloc) => bloc.add(const AdminLoginSubmitted(username: 'wrong', password: 'credentials')),
      expect: () => [AdminLoginFailure()],
    );
  });
}
