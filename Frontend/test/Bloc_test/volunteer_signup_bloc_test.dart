import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:Sebawi/application/volunteer_signup/volunteer_signup_bloc.dart';
import 'package:Sebawi/presentation/Events/volunteer_signup_event.dart';
import 'package:Sebawi/presentation/States/volunteer_signup_state.dart';
import 'package:Sebawi/data/models/validate_form.dart';

void main() {
  group('VolunteerSignupBloc', () {
    late VolunteerSignupBloc volunteerSignupBloc;

    setUp(() {
      volunteerSignupBloc = VolunteerSignupBloc();
    });

    tearDown(() {
      volunteerSignupBloc.close();
    });

    test('initial state is VolunteerSignupState', () {
      expect(volunteerSignupBloc.state, const VolunteerSignupState());
    });

    blocTest<VolunteerSignupBloc, VolunteerSignupState>(
      'emits state with updated name when NameChangedEvent is added',
      build: () => volunteerSignupBloc,
      act: (bloc) => bloc.add(const NameChangedEvent(name: ValidateForm(value: 'Valid Name'))),
      expect: () => [
        predicate<VolunteerSignupState>((state) => state.name.value == 'Valid Name'),
      ],
    );

    blocTest<VolunteerSignupBloc, VolunteerSignupState>(
      'emits state with updated email when EmailChangedEvent is added',
      build: () => volunteerSignupBloc,
      act: (bloc) => bloc.add(const EmailChangedEvent(email: ValidateForm(value: 'test@example.com'))),
      expect: () => [
        predicate<VolunteerSignupState>((state) => state.email.value == 'test@example.com'),
      ],
    );

    blocTest<VolunteerSignupBloc, VolunteerSignupState>(
      'emits state with updated username when UsernameChangedEvent is added',
      build: () => volunteerSignupBloc,
      act: (bloc) => bloc.add(const UsernameChangedEvent(username: ValidateForm(value: 'validusername'))),
      expect: () => [
        predicate<VolunteerSignupState>((state) => state.username.value == 'validusername'),
      ],
    );

    blocTest<VolunteerSignupBloc, VolunteerSignupState>(
      'emits state with updated password when PasswordChangedEvent is added',
      build: () => volunteerSignupBloc,
      act: (bloc) => bloc.add(const PasswordChangedEvent(password: ValidateForm(value: 'Valid123!'))),
      expect: () => [
        predicate<VolunteerSignupState>((state) => state.password.value == 'Valid123!'),
      ],
    );

    blocTest<VolunteerSignupBloc, VolunteerSignupState>(
      'emits state with updated confirm password when ConfirmPasswordChangedEvent is added',
      build: () => volunteerSignupBloc,
      act: (bloc) => bloc.add(const ConfirmPasswordChangedEvent(confirmPassword: ValidateForm(value: 'Valid123!'))),
      expect: () => [
        predicate<VolunteerSignupState>((state) => state.confirmPassword.value == 'Valid123!'),
      ],
    );
  });
}
