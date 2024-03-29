import 'package:chater/helper/button.dart';
import 'package:chater/helper/show_message.dart';
import 'package:chater/helper/text_style.dart';
import 'package:chater/services/auth/auth_cubit.dart';
import 'package:chater/services/auth/auth_states.dart';
import 'package:chater/utils/const.dart';
import 'package:chater/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../methods/vaildator.dart';
import '../../helper/question_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var authCubit = BlocProvider.of<AuthCubit>(context);
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController mailController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    bool isLoading = false;
    final auth = BlocProvider.of<AuthCubit>(context);
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is RegisterLoadingState) {
            isLoading = true;
          } else {
            isLoading = false;
          }
          if (state is FailedToCreateUserState) {
            showMessage(context, state.message);
          }
          if (state is UserCreatedSuccessState) {
            Navigator.pushReplacementNamed(context, kLogInPage);
          }
        },
        builder: (context, state) {
          return ModalProgressHUD(
            inAsyncCall: isLoading,
            opacity: 0.1,
            progressIndicator: const CircularProgressIndicator(
              color: kSenderColor,
            ),
            color: kSenderColor,
            child: Scaffold(
              body: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      kPrimaryColor,
                      kSenderColor,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: [
                      Stack(
                        alignment: AlignmentDirectional.topCenter,
                        children: [
                          Material(
                            elevation: 5,
                            borderRadius: borderRadiusAll(100),
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: authCubit.userImageFile != null
                                  ? FileImage(authCubit.userImageFile!)
                                      as ImageProvider<Object>?
                                  : const AssetImage(
                                          'assets/images/user_image.jpg')
                                      as ImageProvider<Object>?,
                            ),
                          ),
                          Positioned(
                            top: 150,
                            right: 82,
                            child: Material(
                              color: Colors.transparent,
                              borderRadius: borderRadiusAll(60),
                              elevation: 5,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: borderRadiusAll(60),
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<AuthCubit>(context)
                                        .getImage();
                                  },
                                  icon: const Icon(
                                    Icons.camera_alt_outlined,
                                    color: kPrimaryColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Card(
                        shape: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        elevation: 5,
                        color: kSenderColor,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: StyleOfText(
                                  text: 'Welcome',
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const StyleOfText(
                                color: kPrimaryColor,
                                text: "Name",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextForm(
                                validator: nameValidator,
                                prefixIcon: const Icon(
                                  Icons.person_2_outlined,
                                  color: kPrimaryColor,
                                ),
                                hintText: 'Enter your name',
                                controller: nameController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const StyleOfText(
                                color: kPrimaryColor,
                                text: "E_mail",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextForm(
                                validator: emailValidator,
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: kPrimaryColor,
                                ),
                                hintText: 'Enter your mail',
                                controller: mailController,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const StyleOfText(
                                color: kPrimaryColor,
                                text: "Password",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextForm(
                                obscureText: passwordVisible,
                                suffixIcon: IconButton(
                                  onPressed: () => auth.showPassword(),
                                  icon: Icon(
                                    state is ShowPasswordSuccessState
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: kPrimaryColor,
                                  ),
                                ),
                                validator: passwordValidator,
                                prefixIcon: const Icon(
                                  Icons.password_outlined,
                                  color: kPrimaryColor,
                                ),
                                hintText: 'Enter your password',
                                controller: passController,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Button(
                        title: 'SignUp',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).createAccount(
                                name: nameController.text.trim(),
                                mail: mailController.text.trim(),
                                password: passController.text.trim());
                          }
                        },
                      ),
                      const QuestionButton(
                        question: ' I have an account ,',
                        page: kLogInPage,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
