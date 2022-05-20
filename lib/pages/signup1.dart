// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, use_key_in_widget_constructors

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _passwordId = TextEditingController();
  final TextEditingController _firstNameId = TextEditingController();
  final TextEditingController _secondNameId = TextEditingController();
  final TextEditingController _thirdNameId = TextEditingController();
  final TextEditingController _lastNameId = TextEditingController();
  FocusNode _logInNode = FocusNode();
  FocusNode _userNameNode = FocusNode();
  FocusNode _passwodNode = FocusNode();
  FocusNode _firstNameNode = FocusNode();
  FocusNode _secondNameNode = FocusNode();
  FocusNode _thirdNameNode = FocusNode();
  FocusNode _lastNameNode = FocusNode();

  @override
  void dispose() {
    _userNameNode.dispose();
    _firstNameNode.dispose();
    _secondNameNode.dispose();
    _thirdNameNode.dispose();
    _lastNameNode.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  String name = "";
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldkey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Text("Welcome To Emtalik-The World of Your Real-Estate"),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomFormField(
                    onComplete: () {
                      FocusScope.of(context).requestFocus(_firstNameNode);
                    },
                    focusNode: _userNameNode,
                    controller: _userId,
                    enterKeyAction: TextInputAction.next,
                    type: TextInputType.name,
                    labelText: "Enter Your User Name",
                    icon: const Icon(Icons.perm_identity),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  PasswordFormField(
                    onComplete: () {
                      FocusScope.of(context).requestFocus(_firstNameNode);
                    },
                    focusNode: _passwodNode,
                    controller: _passwordId,
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomFormField(
                    onComplete: () {
                      FocusScope.of(context).requestFocus(_secondNameNode);
                    },
                    focusNode: _firstNameNode,
                    controller: _firstNameId,
                    enterKeyAction: TextInputAction.next,
                    type: TextInputType.name,
                    labelText: "Enter Your Fisrt Name",
                    icon: const Icon(Icons.perm_identity),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomFormField(
                    onComplete: () {
                      FocusScope.of(context).requestFocus(_thirdNameNode);
                    },
                    focusNode: _secondNameNode,
                    controller: _secondNameId,
                    enterKeyAction: TextInputAction.next,
                    type: TextInputType.name,
                    labelText: "Enter Your Second Name",
                    icon: const Icon(Icons.perm_identity),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomFormField(
                    onComplete: () {
                      FocusScope.of(context).requestFocus(_lastNameNode);
                    },
                    focusNode: _thirdNameNode,
                    controller: _thirdNameId,
                    enterKeyAction: TextInputAction.next,
                    type: TextInputType.name,
                    labelText: "Enter Your Third Name",
                    icon: const Icon(Icons.perm_identity),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  CustomFormField(
                    onComplete: () {
                      FocusScope.of(context).requestFocus(_logInNode);
                    },
                    focusNode: _lastNameNode,
                    controller: _lastNameId,
                    enterKeyAction: TextInputAction.next,
                    type: TextInputType.name,
                    labelText: "Enter Your Last Name",
                    icon: const Icon(Icons.perm_identity),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                  ElevatedButton(
                    focusNode: _logInNode,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/signup2');
                    },
                    child: Text("Next".i18n()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
