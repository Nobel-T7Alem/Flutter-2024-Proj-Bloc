class ValidateForm{
  final String value;
  final String? error;
  const ValidateForm({ this.value ='', this.error});
  ValidateForm copyWith({
    final String? value,
    final String? error,
  }){
    return ValidateForm(
      value: value ?? this.value,
      error: error ?? this.error,
    );
  }
}

