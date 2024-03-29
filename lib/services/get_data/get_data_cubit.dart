import 'dart:developer';
import 'package:chater/models/message_model.dart';
import 'package:chater/models/user_model.dart';
import 'package:chater/services/get_data/get_data_states.dart';
import 'package:chater/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(InitialDataState());
  UserModel? userModel;
  List<UserModel> users = [];
  List<UserModel> filteredUser = [];
  List<MessageModel> messages = [];
  bool search = false;
  String lastMessage = '';
  String time = '';
  int lenght = 0;
  void getMyData() async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get()
          .then((value) {
        if (value.data() != null) {
          userModel = UserModel.fromjson(value.data()!);
          log(userModel!.name);
          emit(GetCurrentUserDataSuccessState());
        } else {
          emit(FailedToGetCurrentUserDataState(message: 'error'));
        }
      });
    } on FirebaseException catch (error) {
      emit(FailedToGetCurrentUserDataState(message: error.code));
    }
  }

  void getUsersData() async {
    users.clear();
    emit(GetAllUsersDataLoadingState());
    try {
      await FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var item in value.docs) {
          if (item.id != userId) {
            users.add(UserModel.fromjson(item.data()));
          }
        }
        emit(GetAllUsersDataSuccessState());
        log(users[0].name);
      });
    } on FirebaseException catch (error) {
      users.clear;
      emit(FailedToGetAllUsersDataState(message: error.code));
    }
  }

  void filteredUsers(String query) async {
    filteredUser.clear();
    emit(FilteredUsersDataLoadingState());
    try {
      filteredUser =
          users.where((element) => element.mail.startsWith(query)).toList();
      log(filteredUser[0].name);
      emit(FilteredUsersDataSuccessState());
    } catch (error) {
      filteredUser.clear();
      emit(FailedToFilteredUsersDataState(message: '$error'));
    }
  }

  void searchFiltered() {
    search = !search;
    if (search == false) {
      filteredUser.clear();
    }
    emit(SearchUsersDataSuccessState());
  }

  void sendMessage(String message, String reciverId) async {
    MessageModel messageModel = MessageModel(
        time: DateTime.now().toString(), message: message, senderId: userId!);
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('chat')
          .doc(reciverId)
          .collection('message')
          .add(messageModel.toJson());
      await FirebaseFirestore.instance
          .collection('users')
          .doc(reciverId)
          .collection('chat')
          .doc(userId)
          .collection('message')
          .add(messageModel.toJson());
      emit(SendMessageSuccessState());
    } on FirebaseException catch (e) {
      emit(FailedToSendMessageState(message: e.code));
    }
  }

  void getMessages(String reciverId) async {
    emit(GetAllMessagesLoadingState());
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('chat')
          .doc(reciverId)
          .collection('message')
          .orderBy('time')
          .snapshots()
          .listen((value) {
        messages.clear();
        for (var item in value.docs) {
          messages.add(MessageModel.fromjson(item.data()));
        }

        emit(GetAllMessageSuccessState());
      });
    } on FirebaseException catch (error) {
      users.clear;
      emit(FailedToGetAllMessageState(message: error.code));
    }
  }
}
