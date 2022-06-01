import 'dart:ffi';
import 'dart:io';
import 'package:emtalik/pages/mainpage.dart';
import 'package:http/http.dart' as http;
import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/validator.dart';
import 'package:emtalik/models/user_register.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:localization/localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  @override
  _Signup createState() => _Signup();
}

class _Signup extends State<Signup> {
  XFile? image;
  pickYourImage() async {
    try {
      final userImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (userImage != null &&
          (userImage.name.split('.')[1] == "jpeg" ||
              userImage.name.split('.')[1] == "jpg" ||
              userImage.name.split('.')[1] == "png" ||
              userImage.name.split('.')[1] == "webp")) {
        if (await userImage.length() < 5 * 1000000) {
          setState(() {
            image = userImage;
          });
        } else {
          ToastFactory.makeToast(
              context,
              TOAST_TYPE.error,
              "file-size-error".i18n(),
              "profile-picture-constraint".i18n(),
              false,
              () {});
          setState(() {
            image = null;
          });
        }
      } else {
        ToastFactory.makeToast(context, TOAST_TYPE.error, null,
            "not-supported-file", false, () {});
        setState(() {
          image = null;
        });
      }
    } on PlatformException catch (e) {
      image = null;
      ToastFactory.makeToast(context, TOAST_TYPE.error, "Error",
          "Cant Pick Up Image", false, () {});
    }
  }

  bool _land = false;
  bool _store = false;
  bool _appartment = false;
  bool _parking = false;
  bool _house = false;
  late int currentStep;
  bool isCompleted = false;
  final TextEditingController _userNameId = TextEditingController();
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
  FocusNode _passwordNode = FocusNode();
  FocusNode _firstNameNode = FocusNode();
  FocusNode _secondNameNode = FocusNode();
  FocusNode _thirdNameNode = FocusNode();
  FocusNode _lastNameNode = FocusNode();

  final requiredFormKey = GlobalKey<FormState>();
  final sellerFormKey = GlobalKey<FormState>();
  final etcFormKey = GlobalKey<FormState>();
  late List<GlobalKey<FormState>> keys;
  bool usernameValidated = false;
  bool emailValidated = false;
  bool phoneValidated = false;

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
          resizeToAvoidBottomInset: false,
          key: _scaffoldkey,
          body: SafeArea(
            child: Stepper(
                type: StepperType.horizontal,
                steps: [
                  Step(
                    state: currentStep > 0
                        ? StepState.complete
                        : StepState.indexed,
                    isActive: currentStep >= 0,
                    title: Text(
                      "account".i18n(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12),
                    ),
                    content: SingleChildScrollView(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Form(
                          key: requiredFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "username-constraint".i18n(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              const SizedBox(height: 10),
                              CustomFormField(
                                onComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(_emailNode);
                                },
                                focusNode: _userNameNode,
                                controller: _userNameId,
                                enterKeyAction: TextInputAction.next,
                                type: TextInputType.name,
                                labelText: "username".i18n(),
                                icon: const Icon(Icons.perm_identity),
                                onValidation: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "required-field".i18n();
                                  } else if (!Validator.usernameValidator(
                                      value)) {
                                    return "username-constraint".i18n();
                                  }
                                },
                              ),
                              CustomFormField(
                                onComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(_phoneNode);
                                },
                                focusNode: _emailNode,
                                controller: _emailId,
                                enterKeyAction: TextInputAction.next,
                                type: TextInputType.emailAddress,
                                labelText: "email".i18n(),
                                icon: const Icon(Icons.email),
                                onValidation: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "required-field".i18n();
                                  } else if (!Validator.emailValidator(value)) {
                                    return "invalid-email".i18n();
                                  }
                                },
                              ),
                              CustomFormField(
                                onComplete: () {
                                  FocusScope.of(context)
                                      .requestFocus(_passwordNode);
                                },
                                focusNode: _phoneNode,
                                controller: _phoneId,
                                enterKeyAction: TextInputAction.next,
                                type: TextInputType.phone,
                                labelText: "phone".i18n(),
                                icon: const Icon(Icons.phone),
                                onValidation: (value) {
                                  if ((value != null &&
                                          value.trim().isNotEmpty) &&
                                      !Validator.phoneValidator(value)) {
                                    return "invalid-phone".i18n();
                                  }
                                },
                              ),
                              Text(
                                "password-constraint".i18n(),
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary),
                              ),
                              PasswordFormField(
                                focusNode: _passwordNode,
                                controller: _passwordId,
                                onValidation: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "required-field".i18n();
                                  } else if (!Validator.passwordValidator(
                                      value)) {
                                    return 'password-constraint'.i18n();
                                  }
                                },
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
                    title: Text(
                      "personal".i18n(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12),
                    ),
                    content: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Form(
                        key: sellerFormKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "name-constraint".i18n(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
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
                              onValidation: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) &&
                                    !Validator.nameValidator(value)) {
                                  return "name-constraint".i18n();
                                }
                              },
                            ),
                            Text(
                              "name-constraint".i18n(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
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
                              onValidation: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) &&
                                    !Validator.nameValidator(value)) {
                                  return "name-constraint".i18n();
                                }
                              },
                            ),
                            Text(
                              "name-constraint".i18n(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
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
                              onValidation: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) &&
                                    !Validator.nameValidator(value)) {
                                  return "name-constraint".i18n();
                                }
                              },
                            ),
                            Text(
                              "name-constraint".i18n(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                            ),
                            CustomFormField(
                              onComplete: () {
                                //FocusScope.of(context).requestFocus();
                              },
                              focusNode: _lastNameNode,
                              controller: _lastNameId,
                              enterKeyAction: TextInputAction.next,
                              type: TextInputType.name,
                              labelText: "last-name",
                              icon: const Icon(Icons.perm_identity),
                              onValidation: (value) {
                                if ((value != null &&
                                        value.trim().isNotEmpty) &&
                                    !Validator.nameValidator(value)) {
                                  return "name-constraint".i18n();
                                }
                              },
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
                    title: Text(
                      "finish".i18n(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(fontSize: 12),
                    ),
                    content: Form(
                      key: etcFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("chose-interests".i18n()),
                          CheckboxListTile(
                            title: Text("land".i18n()),
                            secondary: const Icon(Icons.landscape),
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
                            secondary: const Icon(Icons.store),
                            controlAffinity: ListTileControlAffinity.platform,
                            value: _store,
                            onChanged: (value) {
                              setState(() {
                                _store = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text("apartment".i18n()),
                            secondary: const Icon(Icons.home),
                            controlAffinity: ListTileControlAffinity.platform,
                            value: _appartment,
                            onChanged: (value) {
                              setState(() {
                                _appartment = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text("house".i18n()),
                            secondary: const Icon(Icons.apartment),
                            controlAffinity: ListTileControlAffinity.platform,
                            value: _house,
                            onChanged: (value) {
                              setState(() {
                                _house = value!;
                              });
                            },
                          ),
                          CheckboxListTile(
                            title: Text("parking".i18n()),
                            secondary: const Icon(Icons.local_parking),
                            controlAffinity: ListTileControlAffinity.platform,
                            value: _parking,
                            onChanged: (value) {
                              setState(() {
                                _parking = value!;
                              });
                            },
                          ),
                          Text(
                            "pick-up-your-image".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12),
                          ),
                          IconButton(
                            iconSize: 50,
                            icon: const Icon(Icons.image_search),
                            onPressed: pickYourImage,
                          ),
                          if (image != null)
                            CircleAvatar(
                              child: ClipOval(
                                child: Image.file(
                                  File(image!.path),
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              radius: 120,
                            ),
                        ],
                      ),
                    ),
                  )
                ],
                currentStep: currentStep,
                onStepContinue: () async {
                  if (keys[currentStep].currentState!.validate()) {
                    if (currentStep == 0) {
                      try {
                        String notUnique = "";
                        var usernameResponse = await HttpService.uniqueUsername(
                            _userNameId.value.text);
                        var emailResponse =
                            await HttpService.uniqueEmail(_emailId.value.text);
                        var contactNumberResponse =
                            await HttpService.uniqueContactNumber(
                                _phoneId.value.text);
                        // UNIQUE USERNAME
                        if (usernameResponse.statusCode != 200) {
                          notUnique += "username".i18n() + " ";
                          usernameValidated = false;
                        } else {
                          usernameValidated = true;
                        }
                        // UNIQUE EMAIL
                        if (emailResponse.statusCode != 200) {
                          notUnique += "email".i18n() + " ";
                          emailValidated = false;
                        } else {
                          emailValidated = true;
                        }
                        // UNIQUE CONTACT NUMBER
                        if (contactNumberResponse.statusCode != 200 &&
                            _phoneId.value.text.trim().isNotEmpty) {
                          notUnique += "phone".i18n() + " ";
                          phoneValidated = false;
                        } else {
                          phoneValidated = true;
                        }
                        if (usernameValidated &&
                            emailValidated &&
                            phoneValidated) {
                          setState(() => currentStep++);
                        } else {
                          ToastFactory.makeToast(
                              context,
                              TOAST_TYPE.warning,
                              "already-taken".i18n(),
                              notUnique.trim(),
                              false,
                              () {});
                        }
                      } catch (exception) {
                        ToastFactory.makeToast(context, TOAST_TYPE.error, null,
                            "no-connection".i18n(), false, () {});
                      }
                    } else if (currentStep == 2) {
                      // SEND REGISTER REQUEST

                      List<String>? interests = [];
                      if (_land == true) {
                        interests.add("land");
                      }
                      if (_appartment == true) {
                        interests.add("apartment");
                      }
                      if (_store == true) {
                        interests.add("store");
                      }
                      if (_parking == true) {
                        interests.add("parking");
                      }
                      if (_house == true) {
                        interests.add("house");
                      }
                      var user = UserRegister(
                        username: _userNameId.value.text,
                        firstName: _firstNameId.value.text.isEmpty
                            ? null
                            : _firstNameId.value.text,
                        fathersName: _secondNameId.value.text.isEmpty
                            ? null
                            : _secondNameId.value.text,
                        grandfathersName: _thirdNameId.value.text.isEmpty
                            ? null
                            : _thirdNameId.value.text,
                        surName: _lastNameId.value.text.isEmpty
                            ? null
                            : _lastNameId.value.text,
                        email: _emailId.value.text,
                        password: _passwordId.value.text,
                        contactNumber: _phoneId.value.text.isEmpty
                            ? null
                            : _phoneId.value.text,
                        interests: interests.isEmpty ? null : interests,
                      );
                      try {
                        var response = await HttpService.register(user, image);
                        if (response.statusCode == 200) {
                          var notStreamedResponse =
                              await http.Response.fromStream(response);
                          var json = notStreamedResponse.body;
                          Provider.of<UserSession>(context, listen: false)
                              .login(
                            UserSession.fromRawJson(json),
                          );
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => MyHomePage())));
                          // Navigator.of(context).pushNamed('/mainpage');
                        } else {
                          ToastFactory.makeToast(
                              context,
                              TOAST_TYPE.error,
                              null,
                              "something-went-wrong".i18n(),
                              false,
                              () {});
                        }
                        if (currentStep == 1) {
                          setState((() => currentStep++));
                        }
                      } catch (ex) {
                        ToastFactory.makeToast(context, TOAST_TYPE.error, null,
                            "no-connection".i18n(), false, () {});
                      }
                    }
                  }
                },
                onStepCancel: () {
                  Navigator.of(context).pushNamed('/');
                },
                onStepTapped: (step) {
                  if (keys[currentStep].currentState!.validate() &&
                      usernameValidated &&
                      emailValidated &&
                      phoneValidated) {
                    setState((() => currentStep = step));
                  }
                }),
          ),
        ));
  }
}
