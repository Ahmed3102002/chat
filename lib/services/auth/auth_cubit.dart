import 'dart:developer';
import 'dart:io';
import 'package:chater/models/user_model.dart';
import 'package:chater/utils/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(InitialAppState());

  Future<void> createAccount(
      {required String name,
      required String mail,
      required String password}) async {
    emit(RegisterLoadingState());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: mail,
        password: password,
      );

      if (userCredential.user?.uid != null) {
        String userImage = await uploadImageToStorage();
        sendUserInfo(
          image: userImage,
          name: name,
          email: mail,
          userID: userCredential.user!.uid,
        );
        emit(UserCreatedSuccessState());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        log(e.code);
        emit(FailedToCreateUserState(message: e.code));
      } else if (e.code == 'wrong-password') {
        log(e.code);
        emit(FailedToCreateUserState(message: e.code));
      } else {
        log(e.code);
        emit(FailedToCreateUserState(message: e.code));
      }
    }
  }

  File? userImageFile;

  void getImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      userImageFile = File(pickedImage.path);
      emit(UserImageSelectedSuccessState());
    } else {
      emit(FailedToGeUserImageSelectedState());
    }
  }

  Future<String> uploadImageToStorage() async {
    Reference imageRef =
        FirebaseStorage.instance.ref(basename(userImageFile!.path));
    await imageRef.putFile(userImageFile!);
    var image = await imageRef.getDownloadURL();
    return image;
  }

  Future<void> sendUserInfo(
      {required String image,
      required String name,
      required String email,
      required String userID}) async {
    UserModel userModel =
        UserModel(id: userID, name: name, mail: email, image: image);
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userID)
          .set(userModel.toJson());
      emit(SaveUserDataOnFirestoreSuccessState());
    } on FirebaseException {
      emit(FailedToSaveUserDataOnFirestoreState());
    }
  }

  Future<void> logInUser(mail, password) async {
    emit(LoginLoadingState());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: mail,
        password: password,
      );
      if (userCredential.user?.uid != null) {
        final SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString('userId', userCredential.user!.uid);
        userId = sharedPreferences.getString('userId');
        emit(LoginSuccessState());
      }
    } on FirebaseAuthException catch (e) {
      emit(FailedToLoginState());
      if (e.code == 'weak-password') {
        log(e.code);
      }
      if (e.code == 'user-not-found') {
        log(e.code);
      } else {
        log(e.code);
      }
    }
  }

  Future resetPassword(String email) async {
    try {
      emit(RestPasswordLoadingState());
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      emit(SuccessToRestPassword());
    } on FirebaseException catch (e) {
      emit(FailedToRestPasswordState(message: e.code));
    }
  }

  Future<void> logOut() async {
    emit(LogOutLoadingState());
    try {
      emit(SuccessToLogOut());
      await FirebaseAuth.instance.signOut();
      userId = null;
    } on FirebaseException catch (e) {
      emit(FailedToLogOutState(message: e.code));
    }
  }

  void showPassword() {
    passwordVisible = !passwordVisible;
    emit(ShowPasswordSuccessState());
  }
}
