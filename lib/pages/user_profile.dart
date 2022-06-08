import 'dart:convert';

import 'package:emtalik/Widgets/UserInfoWidgets/profile_widget.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/user_appbar.dart';
import 'package:emtalik/Widgets/customdrawer.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/models/estate_response.dart';
import 'package:emtalik/pages/search.dart';
import 'package:emtalik/providers/locale_provider.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {
  final formKey = GlobalKey<FormState>();

  get onClicked => null;

  get pfpimg => null;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [ProfileWidget(pfpimg: "", onClicked: () async {})],
      ),
    );
  }
}
