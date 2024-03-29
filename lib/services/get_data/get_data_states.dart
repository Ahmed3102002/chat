abstract class GetDataState {}

class InitialDataState extends GetDataState {}

class GetCurrentUserDataSuccessState extends GetDataState {}

class FailedToGetCurrentUserDataState extends GetDataState {
  String message;
  FailedToGetCurrentUserDataState({required this.message});
}

class GetAllUsersDataLoadingState extends GetDataState {}

class FilteredUsersDataLoadingState extends GetDataState {}

class SearchUsersDataSuccessState extends GetDataState {}

class GetAllUsersDataSuccessState extends GetDataState {}

class FailedToGetAllUsersDataState extends GetDataState {
  String message;
  FailedToGetAllUsersDataState({required this.message});
}

class FilteredUsersDataSuccessState extends GetDataState {}

class FailedToFilteredUsersDataState extends GetDataState {
  String message;
  FailedToFilteredUsersDataState({required this.message});
}

class SendMessageSuccessState extends GetDataState {}

class FailedToSendMessageState extends GetDataState {
  String message;
  FailedToSendMessageState({required this.message});
}

class GetAllMessageSuccessState extends GetDataState {}

class FailedToGetAllMessageState extends GetDataState {
  String message;
  FailedToGetAllMessageState({required this.message});
}

class GetAllMessagesLoadingState extends GetDataState {}

class GetLastMessageDateSuccessState extends GetDataState {}

class FailedToGetLastMessageDateState extends GetDataState {
  String message;
  FailedToGetLastMessageDateState({required this.message});
}

class GetLastMessageDateLoadingState extends GetDataState {}
