import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:Sebawi/application/admin_login/admin_login_bloc.dart';
import 'package:Sebawi/application/admin_login/admin_login_event.dart';
import 'package:Sebawi/application/admin_login/admin_login_state.dart';
import 'package:Sebawi/data/models/validate_form.dart';

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
      'emits state with updated username when UsernameChangedEvent is added',
      build: () => adminLoginBloc,
      act: (bloc) => bloc.add(const UsernameChangedEvent(username: ValidateForm(value: 'admin'))),
      expect: () => [
        isA<AdminLoginState>().having((state) => state.username.value, 'username', 'admin'),
      ],
    );

    blocTest<AdminLoginBloc, AdminLoginState>(
      'emits state with updated password when PasswordChangedEvent is added',
      build: () => adminLoginBloc,
      act: (bloc) => bloc.add(const PasswordChangedEvent(password: ValidateForm(value: 'password'))),
      expect: () => [
        isA<AdminLoginState>().having((state) => state.password.value, 'password', 'password'),
      ],
    );
  });
}
