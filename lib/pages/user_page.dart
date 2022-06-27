import 'dart:convert';

import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/user_details.dart';
import 'package:emtalik/pages/edit_estate.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  UserPage({Key? key, required this.userId}) : super(key: key);

  int userId;
  @override
  State<UserPage> createState() => _UserPageDisplay(userId: userId);
}

class _UserPageDisplay extends State<UserPage> {
  _UserPageDisplay({required this.userId});
  int userId;

  late Future<UserDetails> user;

  Future<UserDetails> getUser() async {
    var response = await HttpService.getUserById(userId);
    var user = UserDetails.fromRawJson(response.body);
    return user;
  }

  @override
  void initState() {
    super.initState();
    user = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        future: user,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
                body: Center(child: CircularProgressIndicator()));
          } else if (snapshot.hasData) {
            UserDetails user = snapshot.data as UserDetails;
            return Scaffold(
              appBar: AppBar(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000),
                    ),
                    side: BorderSide(width: 3, color: Colors.black)),
                bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(20), child: SizedBox()),
                backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
                centerTitle: true,
                shadowColor: Colors.black,
                title: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      decodeUtf8ToString(user.username),
                      style: Theme.of(context).textTheme.headline3,
                    )),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Center(
                        child: ClipOval(
                          child: Image.network(
                            HttpService.getProfilePictureRoute(userId),
                            fit: BoxFit.cover,
                            width: 250,
                          ),
                        ),
                      ),
                    ),
                    if (user.firstName != null &&
                        user.fathersName != null &&
                        user.grandfathersName != null &&
                        user.surName != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("full-name".i18n()),
                          Text(
                            decodeUtf8ToString(user.firstName!) +
                                " " +
                                decodeUtf8ToString(user.fathersName!) +
                                " " +
                                decodeUtf8ToString(user.grandfathersName!) +
                                " " +
                                decodeUtf8ToString(user.surName!) +
                                " ",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    if (user.role == "admin")
                      Center(
                        child: Text(
                          "admin".i18n(),
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    if (user.contactNumber != null)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text("phone".i18n()),
                          Text(
                            user.contactNumber!,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    Container(
                      margin:
                          const EdgeInsets.only(right: 10, left: 10, top: 10),
                      child: Text("chose-interests".i18n()),
                    ),
                    if (user.interests != null && user.interests!.isNotEmpty)
                      ListView.builder(
                        itemCount: user.interests!.length,
                        shrinkWrap: true,
                        itemBuilder: ((context, index) {
                          return Row(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.only(right: 5, left: 5),
                                child: Icon(
                                  user.interests![index] == "land"
                                      ? Icons.landscape
                                      : user.interests![index] == "store"
                                          ? Icons.store
                                          : user.interests![index] == "house"
                                              ? Icons.house
                                              : user.interests![index] ==
                                                      "apartment"
                                                  ? Icons.apartment
                                                  : Icons.local_parking,
                                ),
                              ),
                              Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, left: 5),
                                  child: Text(user.interests![index].i18n())),
                            ],
                          );
                        }),
                      ),
                    if (user.role == "seller")
                      FutureBuilder(future: ,builder: (context, snapshot) {}),
                    if (userId ==
                        Provider.of<UserSession>(context, listen: false).id)
                      ElevatedButton.icon(
                        icon: const Icon(Icons.edit),
                        label: Text("edit-profile".i18n()),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Theme.of(context).colorScheme.secondary),
                        ),
                        onPressed: () {
                          // TODO MAKE EDIT PAGES
                        },
                      ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      "no-connection".i18n(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          user = getUser();
                        });
                      },
                      icon: const Icon(
                        Icons.refresh,
                        size: 35,
                      ),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
