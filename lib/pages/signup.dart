// ignore_for_file: prefer_const_constructors, unused_field, prefer_final_fields, use_key_in_widget_constructors, dead_code
import 'dart:io';
import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:image_picker/image_picker.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  File? image;
  Future pickYourImage() async {
    try {
      final userImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (userImage == null) return;
      final imageDeafult = File(image!.path);
      setState(() => image = imageDeafult);
    } on PlatformException catch (e) {
      ToastFactory.makeToast(context, TOAST_TYPE.info, "Error",
          "Cant Pick Up Image", false, () {});
    }
  }

  bool _land = false;
  bool _store = false;
  bool _appartment = false;
  bool _parking = false;
  late int currentStep;
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

  final requiredFormKey = GlobalKey<FormState>();
  final sellerFormKey = GlobalKey<FormState>();
  final etcFormKey = GlobalKey<FormState>();
  late List<GlobalKey<FormState>> keys;

  @override
  void initState() {
    currentStep = 0;
    keys = [requiredFormKey, sellerFormKey, etcFormKey];
    super.initState();
  }

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

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          resizeToAvoidBottomInset: false,
          key: _scaffoldkey,
          body: Theme(
            data: Theme.of(context),
            child: Stepper(
                type: StepperType.horizontal,
                steps: [
                  Step(
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 0,
                    title: Text("account".i18n()),
                    content: SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Form(
                          key: requiredFormKey,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 25,
                              ),
                              CustomFormField(
                                info: "user-name-constraints".i18n(),
                                onComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(_emailNode);
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
                                  FocusScope.of(context)
                                      .requestFocus(_passwodNode);
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
                                  FocusScope.of(context)
                                      .requestFocus(_passwodNode);
                                },
                                focusNode: _phoneNode,
                                controller: _phoneId,
                                enterKeyAction: TextInputAction.next,
                                type: TextInputType.phone,
                                labelText: "phone".i18n(),
                                icon: const Icon(Icons.phone),
                              ),
                              PasswordFormField(
                                info: 'password-constraints'.i18n(),
                                focusNode: _passwodNode,
                                controller: _passwordId,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Step(
                    state: currentStep > 1
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 1,
                    title: Text("personal".i18n()),
                    content: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Form(
                        key: sellerFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CustomFormField(
                              onComplete: () {
                                FocusScope.of(context)
                                    .requestFocus(_secondNameNode);
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
                                FocusScope.of(context)
                                    .requestFocus(_thirdNameNode);
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
                                FocusScope.of(context)
                                    .requestFocus(_lastNameNode);
                              },
                              focusNode: _thirdNameNode,
                              controller: _thirdNameId,
                              enterKeyAction: TextInputAction.next,
                              type: TextInputType.name,
                              labelText: "grandfather-name",
                              icon: const Icon(Icons.perm_identity),
                            ),
                            CustomFormField(
                              onComplete: () {},
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
                  ),
                  Step(
                      state: currentStep > 1
                          ? StepState.complete
                          : StepState.indexed,
                      isActive: currentStep >= 2,
                      title: Text("finish".i18n()),
                      content: Form(
                        key: etcFormKey,
                        child: Column(
                          children: [
                            Text("chose-interests".i18n()),
                            CheckboxListTile(
                              title: Text("land".i18n()),
                              secondary: Icon(Icons.landscape),
                              controlAffinity: ListTileControlAffinity.platform,
                              value: _land,
                              onChanged: (value) {
                                setState(() {
                                  _land = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("store".i18n()),
                              secondary: Icon(Icons.store),
                              controlAffinity: ListTileControlAffinity.platform,
                              value: _store,
                              onChanged: (value) {
                                setState(() {
                                  _store = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("appartment".i18n()),
                              secondary: Icon(Icons.home),
                              controlAffinity: ListTileControlAffinity.platform,
                              value: _appartment,
                              onChanged: (value) {
                                setState(() {
                                  _appartment = value!;
                                });
                              },
                            ),
                            CheckboxListTile(
                              title: Text("parking".i18n()),
                              secondary: Icon(Icons.local_parking),
                              controlAffinity: ListTileControlAffinity.platform,
                              value: _parking,
                              onChanged: (value) {
                                setState(() {
                                  _parking = value!;
                                });
                              },
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Column(
                              children: [
                                Text(
                                  "pick-up-your-image".i18n(),
                                ),
                                IconButton(
                                  iconSize: 50,
                                  color: Colors.green,
                                  icon: Icon(Icons.image_search),
                                  onPressed: pickYourImage,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))
                ],
                currentStep: currentStep,
                onStepContinue: () {
                  // STEPS CONTINUE BUTTON
                  if (currentStep == 2) {
                    // SIGNING UP
                    if (keys[currentStep].currentState!.validate()) {
                      // SEND SIGNUP REQUEST
                      Navigator.of(context).pushNamed('/mainpage');
                    }
                  } else {
                    if (keys[currentStep].currentState!.validate()) {
                      setState(() => currentStep += 1);
                    }
                  }
                },
                onStepCancel: () {
                  Navigator.of(context).pushNamed('/');
                },
                onStepTapped: (step) {
                  if (keys[currentStep].currentState!.validate()) {
                    setState((() => currentStep = step));
                  }
                }),
          ),
        )
        // ignore: dead_code
        );
  }
}
