// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, use_key_in_widget_constructors

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

//
//
//
//
//
//        TODO: IMPLEMENT CANCEL BUTTON RETURNS TO THE MAIN PAGE
//        TODO: Give meaningfull route names and meaningfull file names
//
//
//
//
//
//
//
//
//

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  bool _check1 = false;
  bool _check2 = false;
  bool _check3 = false;
  bool _check4 = false;
  bool _check5 = false;
  bool _check6 = false;
  bool _check7 = false;
  int currentStep = 0;
  bool isCompleted = false;
  final TextEditingController _userId = TextEditingController();
  final TextEditingController _passwordId = TextEditingController();
  final TextEditingController _firstNameId = TextEditingController();
  final TextEditingController _secondNameId = TextEditingController();
  final TextEditingController _thirdNameId = TextEditingController();
  final TextEditingController _lastNameId = TextEditingController();
  final TextEditingController _emailId = TextEditingController();
  final TextEditingController _phoneId = TextEditingController();
  FocusNode _emailNode = FocusNode();
  FocusNode _phoneNode = FocusNode();
  FocusNode _nextNode = FocusNode();
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
    _emailNode.dispose();
    _phoneNode.dispose();
    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  String name = "";
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _scaffoldkey,
        body: SafeArea(
          child: Stepper(
            type: StepperType.horizontal,
            //Yazeed See Here
            steps: [
              Step(
                state: currentStep > 0 ? StepState.complete : StepState.indexed,
                isActive: currentStep >= 0,
                title: Text("account".i18n()),
                content: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        CustomFormField(
                          onComplete: () {
                            FocusScope.of(context).requestFocus(_emailNode);
                          },
                          focusNode: _userNameNode,
                          controller: _userId,
                          enterKeyAction: TextInputAction.next,
                          type: TextInputType.name,
                          labelText: "username".i18n(),
                          icon: const Icon(Icons.perm_identity),
                        ),
                        CustomFormField(
                          onComplete: () {
                            FocusScope.of(context).requestFocus(_passwodNode);
                          },
                          focusNode: _emailNode,
                          controller: _emailId,
                          enterKeyAction: TextInputAction.next,
                          type: TextInputType.emailAddress,
                          labelText: "email".i18n(),
                          icon: const Icon(Icons.email),
                        ),
                        CustomFormField(
                          onComplete: () {
                            FocusScope.of(context).requestFocus(_passwodNode);
                          },
                          focusNode: _phoneNode,
                          controller: _phoneId,
                          enterKeyAction: TextInputAction.next,
                          type: TextInputType.phone,
                          labelText: "phone".i18n(),
                          icon: const Icon(Icons.phone),
                        ),
                        PasswordFormField(
                          focusNode: _passwodNode,
                          controller: _passwordId,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Step(
                state: currentStep > 1 ? StepState.complete : StepState.indexed,
                isActive: currentStep >= 1,
                title: Text("personal".i18n()),
                content: Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomFormField(
                        onComplete: () {
                          FocusScope.of(context).requestFocus(_secondNameNode);
                        },
                        focusNode: _firstNameNode,
                        controller: _firstNameId,
                        enterKeyAction: TextInputAction.next,
                        type: TextInputType.name,
                        labelText: "first-name".i18n(),
                        icon: const Icon(Icons.perm_identity),
                      ),
                      CustomFormField(
                        onComplete: () {
                          FocusScope.of(context).requestFocus(_thirdNameNode);
                        },
                        focusNode: _secondNameNode,
                        controller: _secondNameId,
                        enterKeyAction: TextInputAction.next,
                        type: TextInputType.name,
                        labelText: "father-name".i18n(),
                        icon: const Icon(Icons.perm_identity),
                      ),
                      CustomFormField(
                        onComplete: () {
                          FocusScope.of(context).requestFocus(_lastNameNode);
                        },
                        focusNode: _thirdNameNode,
                        controller: _thirdNameId,
                        enterKeyAction: TextInputAction.next,
                        type: TextInputType.name,
                        labelText: "grandfather-name",
                        icon: const Icon(Icons.perm_identity),
                      ),
                      CustomFormField(
                        onComplete: () {
                          //FocusScope.of(context).requestFocus();
                        },
                        focusNode: _passwodNode,
                        controller: _passwordId,
                        enterKeyAction: TextInputAction.next,
                        type: TextInputType.name,
                        labelText: "last-name",
                        icon: const Icon(Icons.perm_identity),
                      ),
                    ],
                  ),
                ),
              ),
              Step(
                  state: currentStep > 1 ? StepState.complete : StepState.indexed,
                  isActive: currentStep >= 2,
                  title: Text("finish".i18n()),
                  content: Container(
                    child: Column(
                      children: [
                        Text("chose-interests".i18n()),
                        CheckboxListTile(
                          title: Text("land".i18n()),
                          secondary: Icon(Icons.landscape),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: _check1,
                          onChanged: (value) {
                            setState(() {
                              _check1 = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text("store".i18n()),
                          secondary: Icon(Icons.store),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: _check2,
                          onChanged: (value) {
                            setState(() {
                              _check2 = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text("appartment".i18n()),
                          secondary: Icon(Icons.home),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: _check3,
                          onChanged: (value) {
                            setState(() {
                              _check3 = value!;
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text("parking".i18n()),
                          secondary: Icon(Icons.local_parking),
                          controlAffinity: ListTileControlAffinity.platform,
                          value: _check4,
                          onChanged: (value) {
                            setState(() {
                              _check4 = value!;
                            });
                          },
                        ),
                      ],
                    ),
                  ))
            ],
            currentStep: currentStep,
            onStepContinue: () {
              if (currentStep==2) {
                Navigator.of(context).pushNamed('/mainpage');
              } else {
                setState(() => currentStep += 1);
              }
            },
            onStepCancel: () {
              if (currentStep == 0) {
                Navigator.of(context).pushNamed('/');
              } else {
                setState(() => currentStep -= 1);
              }
            },
            onStepTapped: (step) => setState(
              (() => currentStep = step),
            ),
          ),
        ),
      ),
    );
  }
}
