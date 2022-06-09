import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/Widgets/displaycard.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class SandBoxUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            body: SingleChildScrollView(
          child: DisplayCard(
            header: "Header",
            footer1: "Footer1",
            footer2: "Footer2",
            imageNetworkPath:
                "https://scontent.fhfa1-1.fna.fbcdn.net/v/t39.30808-6/274877468_3067008553564509_5413850692613915992_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=ggRuW5-c4gQAX-5s9f1&_nc_ht=scontent.fhfa1-1.fna&oh=00_AT-PROsrCtW_3pIuTJhMpoODtgn4sD4E8fPMIxYMA-kl0A&oe=62A59854",
          ),
        )));
  }
}
