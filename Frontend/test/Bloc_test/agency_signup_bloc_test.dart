import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:Sebawi/application/agency_signup/agency_signup_bloc.dart';
import 'package:Sebawi/application/agency_signup/agency_signup_event.dart';
import 'package:Sebawi/application/agency_signup/agency_signup_state.dart';
import 'package:Sebawi/data/models/validate_form.dart';

void main() {
  group('AgencySignupBloc', () {
    late AgencySignupBloc agencySignupBloc;

    setUp(() {
      agencySignupBloc = AgencySignupBloc();
    });

    tearDown(() {
      agencySignupBloc.close();
    });

    test('initial state is AgencySignupState', () {
      expect(agencySignupBloc.state, const AgencySignupState());
    });

    blocTest<AgencySignupBloc, AgencySignupState>(
      'emits NavigateToAdminHome when valid data is submitted',
      build: () => agencySignupBloc,
      act: (bloc) {
        bloc.add(const NameChangedEvent(name: ValidateForm(value: 'Valid Name')));
        bloc.add(const EmailChangedEvent(email: ValidateForm(value: 'test@example.com')));
        bloc.add(const UsernameChangedEvent(username: ValidateForm(value: 'validusername')));
        bloc.add(const PasswordChangedEvent(password: ValidateForm(value: 'Valid123!')));
        bloc.add(const ConfirmPasswordChangedEvent(confirmPassword: ValidateForm(value: 'Valid123!')));
        bloc.add(const AgencySignupButtonPressed());
      },
      expect: () => [
        predicate<AgencySignupState>((state) => state.name.value == 'Valid Name'),
        predicate<AgencySignupState>((state) => state.email.value == 'test@example.com'),
        predicate<AgencySignupState>((state) => state.username.value == 'validusername'),
        predicate<AgencySignupState>((state) => state.password.value == 'Valid123!'),
        predicate<AgencySignupState>((state) => state.confirmPassword.value == 'Valid123!'),
        isA<NavigateToAdminHome>(),
      ],
    );
  });
}
