import 'package:chater/helper/button.dart';
import 'package:chater/helper/question_button.dart';
import 'package:chater/helper/text_style.dart';
import 'package:chater/services/auth/auth_cubit.dart';
import 'package:chater/services/auth/auth_states.dart';
import 'package:chater/utils/const.dart';
import 'package:chater/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../helper/show_message.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    final TextEditingController mailController = TextEditingController();
    final TextEditingController passController = TextEditingController();
    bool isLoading = false;
    final auth = BlocProvider.of<AuthCubit>(context);
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is LoginLoadingState) {
            isLoading = true;
          } else {
            isLoading = false;
          }
          if (state is FailedToLoginState) {
            showMessage(context, 'state.message');
          }
          if (state is LoginSuccessState) {
            Navigator.pushReplacementNamed(context, kHomePage);
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
                      Image.asset('assets/images/login.png'),
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
                              horizontal: 8.0, vertical: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: StyleOfText(
                                  text: 'Welcome back',
                                  fontSize: 20,
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              const StyleOfText(
                                color: kPrimaryColor,
                                text: "E_mail",
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextForm(
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
                                prefixIcon: const Icon(
                                  Icons.password_outlined,
                                  color: kPrimaryColor,
                                ),
                                hintText: 'Enter your password',
                                controller: passController,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => Navigator.pushNamed(
                                        context, kForgetPasswordPage),
                                    child: const StyleOfText(
                                      text: "Forget Password !",
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Button(
                        title: 'LogIn',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).logInUser(
                                mailController.text.trim(),
                                passController.text.trim());
                          }
                        },
                      ),
                      const QuestionButton(
                        question: 'Don`t have an account?',
                        page: kSignUpPage,
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
