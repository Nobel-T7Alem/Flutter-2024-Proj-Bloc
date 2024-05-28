class VolunteerSignupForm{
  final String value;
  final String? error;
  const VolunteerSignupForm({ this.value ='', this.error});
  VolunteerSignupForm copyWith({
    final String? value,
    final String? error,
  }){
    return VolunteerSignupForm(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }
}

