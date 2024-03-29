import 'package:chater/helper/text_style.dart';
import 'package:chater/services/auth/auth_cubit.dart';
import 'package:chater/services/auth/auth_states.dart';
import 'package:chater/services/get_data/get_data_cubit.dart';
import 'package:chater/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DisplayDrawer extends StatelessWidget {
  const DisplayDrawer({
    super.key,
    required this.user,
  });

  final GetDataCubit user;

  @override
  Widget build(BuildContext context) {
    final auth = BlocProvider.of<AuthCubit>(context);
    return BlocConsumer<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is SuccessToLogOut) {
          Navigator.pushReplacementNamed(context, kLogInPage);
        }
      },
      builder: (context, state) => Drawer(
        backgroundColor: kSenderColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user.userModel != null)
              UserAccountsDrawerHeader(
                currentAccountPictureSize: const Size.square(85.0),
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                ),
                accountName: StyleOfText(
                  text: user.userModel!.name,
                  color: kSenderColor,
                ),
                accountEmail: StyleOfText(
                  text: user.userModel!.mail,
                  color: kSenderColor,
                ),
                currentAccountPicture: CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(user.userModel!.image),
                ),
              ),
            Expanded(
                child: ListView(
              children: [
                ListTile(
                  onTap: () => auth.logOut(),
                  leading: const Icon(Icons.logout_rounded),
                  title: const StyleOfText(text: 'Log Out'),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
