class RegState {
  final bool isEmailValid;
  final String? emailErrorText;
  final String? passwordErrorText;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RegState &&
        other.isEmailValid == this.isEmailValid &&
        other.emailErrorText == this.emailErrorText &&
        other.passwordErrorText == this.passwordErrorText &&
        other.isPasswordValid == this.isPasswordValid &&
        other.isSubmitting == this.isSubmitting &&
        other.isSuccess == this.isSuccess &&
        other.isFailure == this.isFailure;
  }

  @override
  int get hashCode {
    return this.isEmailValid.hashCode ^
        this.emailErrorText.hashCode ^
        this.passwordErrorText.hashCode ^
        this.isPasswordValid.hashCode ^
        this.isSubmitting.hashCode ^
        this.isSuccess.hashCode ^
        this.isFailure.hashCode;
  }

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegState(
      {required this.isEmailValid,
      required this.emailErrorText,
      required this.passwordErrorText,
      required this.isFailure,
      required this.isPasswordValid,
      required this.isSubmitting,
      required this.isSuccess});

  factory RegState.failure() {
    return RegState(
        isEmailValid: true,
        emailErrorText: null,
        passwordErrorText: null,
        isFailure: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false);
  }

  factory RegState.loading() {
    return RegState(
        isEmailValid: true,
        emailErrorText: null,
        passwordErrorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false);
  }

  factory RegState.initial() {
    return RegState(
        isEmailValid: true,
        emailErrorText: null,
        passwordErrorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false);
  }

  factory RegState.success() {
    return RegState(
        isEmailValid: true,
        emailErrorText: null,
        passwordErrorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: true);
  }

  RegState update({bool? isEmailValid, bool? isPasswordValid}) {
    return copyWith(
        isEmailValid: isEmailValid,
        isPasswordValid: isPasswordValid,
        isSubmitting: false,
        isSuccess: false,
        isFailure: false,
        emailErrorText: null,
        passwordErrorText: null);
  }

  RegState copyWith(
      {bool? isEmailValid,
      String? emailErrorText,
      bool? isPasswordValid,
      bool? isSubmitting,
      bool? isSuccess,
      bool? isFailure,
      String? passwordErrorText}) {
    return RegState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        emailErrorText: emailErrorText ?? this.emailErrorText,
        passwordErrorText: passwordErrorText ?? this.passwordErrorText,
        isFailure: isFailure ?? this.isFailure,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess);
  }
}
