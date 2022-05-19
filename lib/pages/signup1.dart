// ignore_for_file: prefer_const_constructors

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _password = TextEditingController();
  FocusNode idNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode loginNode = FocusNode();
  @override
  void dispose() {
    idNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  String name = "";
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Text("Here To Get Welcomed"),
              SizedBox(
                height: height * 0.05,
              ),
              CustomFormField(
                onComplete: () {},
                focusNode: idNode,
                controller: _id,
                enterKeyAction: TextInputAction.next,
                type: TextInputType.name,
                labelText: "Enter Your User Name",
                icon: const Icon(Icons.perm_identity),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomFormField(
                onComplete: () {},
                focusNode: idNode,
                controller: _id,
                enterKeyAction: TextInputAction.next,
                type: TextInputType.name,
                labelText: "Enter Your Fisrt Name",
                icon: const Icon(Icons.perm_identity),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomFormField(
                onComplete: () {},
                focusNode: idNode,
                controller: _id,
                enterKeyAction: TextInputAction.next,
                type: TextInputType.name,
                labelText: "Enter Your Second Name",
                icon: const Icon(Icons.perm_identity),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomFormField(
                onComplete: () {},
                focusNode: idNode,
                controller: _id,
                enterKeyAction: TextInputAction.next,
                type: TextInputType.name,
                labelText: "Enter Your Third Name",
                icon: const Icon(Icons.perm_identity),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomFormField(
                onComplete: () {},
                focusNode: idNode,
                controller: _id,
                enterKeyAction: TextInputAction.next,
                type: TextInputType.name,
                labelText: "Enter Your Last Name",
                icon: const Icon(Icons.perm_identity),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ElevatedButton(
                focusNode: loginNode,
                onPressed: () {
                  Navigator.of(context).pushNamed('/signup2');
                },
                child: Text("Next".i18n()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
