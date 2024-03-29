abstract class AuthStates {}

class InitialAppState extends AuthStates {}

class LoginSuccessState extends AuthStates {}

class LoginLoadingState extends AuthStates {}

class FailedToLoginState extends AuthStates {}

class SuccessToLogOut extends AuthStates {}

class LogOutLoadingState extends AuthStates {}

class FailedToLogOutState extends AuthStates {
  String message;
  FailedToLogOutState({required this.message});
}

class SuccessToRestPassword extends AuthStates {}

class RestPasswordLoadingState extends AuthStates {}

class FailedToRestPasswordState extends AuthStates {
  String message;
  FailedToRestPasswordState({required this.message});
}

class RegisterLoadingState extends AuthStates {}

class FailedToSaveUserDataOnFirestoreState extends AuthStates {}

class SaveUserDataOnFirestoreSuccessState extends AuthStates {}

class UserImageSelectedSuccessState extends AuthStates {}

class FailedToGeUserImageSelectedState extends AuthStates {}

class UserCreatedSuccessState extends AuthStates {}

class FailedToCreateUserState extends AuthStates {
  String message;
  FailedToCreateUserState({required this.message});
}

class ShowPasswordSuccessState extends AuthStates {}
