import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:chat_bubbles/message_bars/message_bar.dart';
import 'package:chater/helper/text_style.dart';
import 'package:chater/models/user_model.dart';
import 'package:chater/services/get_data/get_data_cubit.dart';
import 'package:chater/services/get_data/get_data_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/const.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.userModel});
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    final sender = BlocProvider.of<GetDataCubit>(context)
      ..getMessages(userModel.id);
    return SafeArea(
      child: BlocConsumer<GetDataCubit, GetDataState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kSenderColor),
            elevation: 0,
            backgroundColor: kPrimaryColor,
            centerTitle: true,
            title: StyleOfText(
              text: userModel.name,
              color: kSenderColor,
            ),
          ),
          body: Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [kPrimaryColor, kSenderColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Material(
              elevation: 5,
              color: kSenderColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.89,
                child: Column(
                  children: [
                    Expanded(
                      child: state is GetAllMessagesLoadingState
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : sender.messages.isNotEmpty
                              ? ListView.builder(
                                  controller: scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 12),
                                  itemCount: sender.messages.length,
                                  itemBuilder: (context, index) =>
                                      BubbleSpecialThree(
                                    text: sender.messages[index].message,
                                    isSender: sender.messages[index].senderId ==
                                            userModel.id
                                        ? true
                                        : false,
                                    color: sender.messages[index].senderId ==
                                            userModel.id
                                        ? kPrimaryColor
                                        : kSenderColor,
                                    textStyle: GoogleFonts.actor(
                                      color: sender.messages[index].senderId ==
                                              userModel.id
                                          ? kSenderColor
                                          : kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : const Center(
                                  child: StyleOfText(
                                      text: "No Messages yet , ..."),
                                ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: MessageBar(
                        textFieldTextStyle:
                            GoogleFonts.actor(color: kPrimaryColor),
                        messageBarColor: kPrimaryColor,
                        sendButtonColor: kSenderColor,
                        onSend: (message) {
                          sender.sendMessage(message, userModel.id);
                          scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceInOut,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
