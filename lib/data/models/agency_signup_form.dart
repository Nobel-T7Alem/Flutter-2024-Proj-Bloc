class AgencySignupForm{
  final String value;
  final String? error;
  const AgencySignupForm({ this.value ='', this.error});
  AgencySignupForm copyWith({
    final String? value,
    final String? error,
  }){
    return AgencySignupForm(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }
}

