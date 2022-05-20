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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
        ),
        body: Stepper(
          type: StepperType.horizontal,
          steps: getSteps(),
          currentStep: currentStep,
          onStepContinue: () {
            final isLastStep = currentStep == getSteps().length - 1;
            if (isLastStep) {
              Navigator.of(context).pushNamed('/mainpage');
            } else {
              setState(() => currentStep += 1);
            }
          },
          onStepCancel: () {
            if (currentStep == 0) {
            } else {
              setState(() => currentStep -= 1);
            }
          },
          onStepTapped: (step) => setState(
            (() => currentStep = step),
          ),
        ),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          state: currentStep > 0 ? StepState.complete : StepState.indexed,
          isActive: currentStep >= 0,
          title: Text("Account".i18n()),
          content: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomFormField(
                    onComplete: () {
                      FocusScope.of(context).requestFocus(_emailNode);
                    },
                    focusNode: _userNameNode,
                    controller: _userId,
                    enterKeyAction: TextInputAction.next,
                    type: TextInputType.name,
                    labelText: "Enter Your User Name",
                    icon: const Icon(Icons.perm_identity),
                  ),
                  CustomFormField(
                    onComplete: () {
                      FocusScope.of(context).requestFocus(_passwodNode);
                    },
                    focusNode: _emailNode,
                    controller: _emailId,
                    enterKeyAction: TextInputAction.next,
                    type: TextInputType.name,
                    labelText: "Enter Your Email",
                    icon: const Icon(Icons.email),
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
          title: Text("Personal".i18n()),
          content: Container(
            height: MediaQuery.of(context).size.height,
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
                  labelText: "Enter Your First Name",
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
                  labelText: "Enter Your Second Name",
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
                  labelText: "Enter Your Third Name",
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
                  labelText: "Enter Your Last Name",
                  icon: const Icon(Icons.perm_identity),
                ),
                Text("Chose your Interests".i18n()),
                CheckboxListTile(
                  title: Text("Lands".i18n()),
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
                  title: Text("Stores".i18n()),
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
                  title: Text("Appartment".i18n()),
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
                  title: Text("Parking".i18n()),
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
          ),
        ),
        Step(
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
            isActive: currentStep >= 1,
            title: Text("Finish".i18n()),
            content: Container(
              child: Column(
                children: [
                  CheckboxListTile(
                    title: Text("Accept Terms And Conditions".i18n()),
                    secondary: Icon(Icons.rule),
                    controlAffinity: ListTileControlAffinity.platform,
                    value: _check5,
                    onChanged: (value) {
                      setState(() {
                        _check5 = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Accept Notification".i18n()),
                    secondary: Icon(Icons.notification_add),
                    controlAffinity: ListTileControlAffinity.platform,
                    value: _check6,
                    onChanged: (value) {
                      setState(() {
                        _check6 = value!;
                      });
                    },
                  ),
                  CheckboxListTile(
                    title: Text("Enable Location".i18n()),
                    secondary: Icon(Icons.location_city),
                    controlAffinity: ListTileControlAffinity.platform,
                    value: _check7,
                    onChanged: (value) {
                      setState(() {
                        _check7 = value!;
                      });
                    },
                  ),
                ],
              ),
            ))
      ];
}
