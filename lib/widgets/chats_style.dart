import 'package:chater/models/user_model.dart';
import 'package:chater/pages/chat_page.dart';
import 'package:chater/utils/const.dart';
import 'package:flutter/material.dart';

import '../helper/text_style.dart';

class ChatsStyle extends StatelessWidget {
  const ChatsStyle({
    super.key,
    required this.userModel,
  });
  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            userModel: userModel,
          ),
        ),
      ),
      child: Card(
        shape: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        elevation: 5,
        color: kSenderColor,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          height: MediaQuery.sizeOf(context).height / 9,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: borderRadiusAll(60),
                child: Image.network(
                  userModel.image,
                  width: 80,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    StyleOfText(
                      text: userModel.name,
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                    StyleOfText(
                      text: userModel.mail,
                      fontSize: 15,
                      color: kPrimaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
