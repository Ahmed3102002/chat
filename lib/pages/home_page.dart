import 'package:chater/helper/show_message.dart';
import 'package:chater/services/get_data/get_data_cubit.dart';
import 'package:chater/services/get_data/get_data_states.dart';
import 'package:chater/utils/const.dart';
import 'package:chater/widgets/drawer.dart';
import 'package:chater/widgets/search_button.dart';
import 'package:chater/widgets/text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helper/text_style.dart';
import '../widgets/chats_style.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    final user = BlocProvider.of<GetDataCubit>(context)
      ..getMyData()
      ..getUsersData();

    return SafeArea(
      child: BlocConsumer<GetDataCubit, GetDataState>(
        listener: (context, state) {
          if (state is FailedToGetCurrentUserDataState) {
            showMessage(context, state.message);
          }
        },
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            drawer: DisplayDrawer(
              user: user,
            ),
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: user.search
                  ? Expanded(
                      child: TextForm(
                        onChanged: (query) {
                          user.filteredUsers(query);
                        },
                        hintText: 'Search for user',
                        controller: searchController,
                        color: kSenderColor,
                      ),
                    )
                  : const StyleOfText(
                      text: "Chats",
                      fontSize: 25,
                      color: kSenderColor,
                    ),
              backgroundColor: kPrimaryColor,
              actions: [
                SearchButton(
                  onPressed: user.searchFiltered,
                ),
              ],
            ),
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
              child: Material(
                elevation: 5,
                color: kSenderColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.89,
                  child: state is GetAllUsersDataLoadingState
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                            backgroundColor: kSenderColor,
                          ),
                        )
                      : user.users.isEmpty
                          ? const Center(
                              child:
                                  StyleOfText(text: 'there is no users yet ,'),
                            )
                          : ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const Divider(
                                color: kPrimaryColor,
                              ),
                              itemCount: user.search
                                  ? user.filteredUser.length
                                  : user.users.length,
                              itemBuilder: (context, index) {
                                return ChatsStyle(
                                  userModel: user.search
                                      ? user.filteredUser[index]
                                      : user.users[index],
                                );
                              },
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
