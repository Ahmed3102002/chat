import 'package:chater/helper/text_style.dart';
import 'package:chater/services/auth/auth_cubit.dart';
import 'package:chater/services/auth/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helper/button.dart';
import '../../utils/const.dart';
import '../../widgets/text_form.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController mailController = TextEditingController();
    final auth = BlocProvider.of<AuthCubit>(context);
    final GlobalKey<FormState> formKey = GlobalKey();
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthStates>(
        listener: (context, state) {
          if (state is SuccessToRestPassword) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kSenderColor),
            elevation: 0,
            title: const StyleOfText(
              text: "Forget Password",
              fontSize: 30,
              color: kSenderColor,
            ),
            centerTitle: true,
            backgroundColor: kPrimaryColor,
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Container(
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                  child: Column(
                    children: [
                      Center(
                        child: StyleOfText(
                          text: "Reset Password to Log in again",
                          fontSize: 20,
                          color: kSenderColor.withOpacity(0.5),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.sizeOf(context).width / 15,
                      ),
                      Material(
                        elevation: 5,
                        color: kSenderColor,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height / 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const StyleOfText(
                                color: kPrimaryColor,
                                text: "E-mail",
                                fontSize: 30,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TextForm(
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: kPrimaryColor,
                                ),
                                hintText: 'enter your mail',
                                controller: mailController,
                              ),
                              SizedBox(
                                height: MediaQuery.sizeOf(context).width / 8,
                              ),
                              Center(
                                child: Button(
                                  icon: const Icon(
                                    Icons.email_outlined,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      auth.resetPassword(
                                          mailController.text.trim());
                                    }
                                  },
                                  title: 'Send E-mail',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
