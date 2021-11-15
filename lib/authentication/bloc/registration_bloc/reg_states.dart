 class RegState {
  final bool isEmailValid;
  final String? emailErrorText;
  final bool isPasswordValid;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;

  bool get isFormValid => isEmailValid && isPasswordValid;

  RegState(
      {required this.isEmailValid,
        required this.emailErrorText,
        required this.isFailure,
        required this.isPasswordValid,
        required this.isSubmitting,
        required this.isSuccess});

  factory RegState.failure() {
    return RegState(
        isEmailValid: true,
        emailErrorText: null,
        isFailure: true,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false);
  }

  factory RegState.loading() {
    return RegState(
        isEmailValid: true,
        emailErrorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: true,
        isSuccess: false);
  }
  factory RegState.initial() {
    return RegState(
        isEmailValid: true,
        emailErrorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false);
  }

  factory RegState.success() {
    return RegState(
        isEmailValid: true,
        emailErrorText: null,
        isFailure: false,
        isPasswordValid: true,
        isSubmitting: false,
        isSuccess: false);
  }

  RegState update(
      { bool? isEmailValid,bool? isPasswordValid}) {
    return copyWith(isEmailValid: isEmailValid, isPasswordValid: isPasswordValid, isSubmitting: false, isSuccess: false, isFailure: false);
  }

  RegState copyWith(
      { bool? isEmailValid,
        String? emailErrorText,
        bool? isPasswordValid,
        bool? isSubmitting,
        bool? isSuccess,
        bool? isFailure}) {
    return RegState(
        isEmailValid: isEmailValid ?? this.isEmailValid,
        emailErrorText: emailErrorText ?? this.emailErrorText,
        isFailure: isFailure ?? this.isFailure,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess);
  }
}
