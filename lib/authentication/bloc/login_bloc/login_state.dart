class LoginState {
  final bool isEmailValid;
  final String? errorText;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginState &&
        other.isEmailValid == this.isEmailValid &&
        other.errorText == this.errorText &&
        other.isPasswordValid == this.isPasswordValid &&
        other.isSubmitting == this.isSubmitting &&
        other.isSuccess == this.isSuccess &&
        other.isFailure == this.isFailure;
  }

  @override
  int get hashCode {
    return this.isEmailValid.hashCode ^
        this.errorText.hashCode ^
        this.isPasswordValid.hashCode ^
        this.isSubmitting.hashCode ^
        this.isSuccess.hashCode ^
        this.isFailure.hashCode;
  }

  bool get isFormValid => isEmailValid && isPasswordValid;

  LoginState(
      {required this.isEmailValid,
      required this.errorText,
      required this.isFailure,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess});

  factory LoginState.failure(String errorText) {
    return LoginState(
        isEmailValid: true,
        errorText: errorText,
        isFailure: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false);
  }

  factory LoginState.loading() {
    return LoginState(
        isEmailValid: true,
        errorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false);
  }

  factory LoginState.initial() {
    return LoginState(
        isEmailValid: true,
        errorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false);
  }

  factory LoginState.success() {
    return LoginState(
        isEmailValid: true,
        errorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: true);
  }

  LoginState update({bool? isEmailValid, bool? isPasswordValid}) {
    return copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        passwordErrorText: null);
  }

  LoginState copyWith(
      {bool? isEmailValid,
      String? errorText,
      bool? isPasswordValid,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure,
      String? passwordErrorText}) {
    return LoginState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        errorText: errorText ?? this.errorText,
        isFailure: isFailure ?? this.isFailure,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess);
  }
}
