import 'dart:io';

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/models/user_details.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

import '../etc/validator.dart';

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
            "not-supported-file".i18n(), false, () {});
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

  late Future<UserDetails> user;

  late bool initilized;

  late bool modefiedPfp;

  final _formKey = GlobalKey<FormState>();
  Future<UserDetails> getUser() async {
    var response = await HttpService.getUserById(
        Provider.of<UserSession>(context, listen: false).id ?? 0);
    return UserDetails.fromRawJson(response.body);
  }

  @override
  void initState() {
    modefiedPfp = false;
    initilized = false;
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
                body: Center(
              child: CircularProgressIndicator(),
            ));
          } else {
            UserDetails user = snapshot.data as UserDetails;
            if (!initilized) {
              _userNameId.text = user.username;
              _emailId.text = user.email;
              _phoneId.text = user.contactNumber ?? "";
              _firstNameId.text = user.firstName ?? "";
              _secondNameId.text = user.fathersName ?? "";
              _thirdNameId.text = user.grandfathersName ?? "";
              _lastNameId.text = user.surName ?? "";
              List<String> interests =
                  user.interests ?? List.empty(growable: true);
              interests.contains("land") ? _land = true : _land = false;
              interests.contains("store") ? _store = true : _store = false;
              interests.contains("apartment")
                  ? _appartment = true
                  : _appartment = false;
              interests.contains("house") ? _house = true : _house = false;
              interests.contains("parking")
                  ? _parking = true
                  : _parking = false;
              initilized = true;
            }

            return Scaffold(
              body: Form(
                key: _formKey,
                child: GestureDetector(
                  onTap: FocusManager.instance.primaryFocus?.unfocus,
                  child: SingleChildScrollView(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 350,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CircleAvatar(
                                  child: ClipOval(
                                    child: modefiedPfp
                                        ? image == null
                                            ? Image.asset(
                                                "assets/user/default_pfp.png",
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                              )
                                            : Image.file(
                                                File(image!.path),
                                                height: MediaQuery.of(context)
                                                    .size
                                                    .height,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                              )
                                        : Image.network(
                                            HttpService.getProfilePictureRoute(
                                                Provider.of<UserSession>(
                                                            context,
                                                            listen: false)
                                                        .id ??
                                                    0),
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                  radius: 120,
                                ),
                                Container(
                                  child: IconButton(
                                    alignment: Alignment.topRight,
                                    onPressed: () {
                                      setState(() {
                                        modefiedPfp = true;
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.cancel,
                                      size: 35,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  alignment: Alignment.bottomLeft,
                                  onPressed: () async {
                                    await pickYourImage();
                                    setState(() {
                                      modefiedPfp = true;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.image_search,
                                    size: 35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "username-constraint".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 10),
                          CustomFormField(
                            onComplete: () {
                              FocusScope.of(context).requestFocus(_emailNode);
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
                              } else if (!Validator.usernameValidator(value)) {
                                debugPrint("Not valid : " + value);
                                return "username-constraint".i18n();
                              }
                            },
                          ),
                          CustomFormField(
                            onComplete: () {
                              FocusScope.of(context).requestFocus(_phoneNode);
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
                              if ((value != null && value.trim().isNotEmpty) &&
                                  !Validator.phoneValidator(value)) {
                                return "invalid-phone".i18n();
                              }
                            },
                          ),
                          Text("new-password".i18n(),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary)),
                          Text(
                            "password-constraint".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          PasswordFormField(
                            focusNode: _passwordNode,
                            controller: _passwordId,
                            onValidation: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "required-field".i18n();
                              } else if (!Validator.passwordValidator(value)) {
                                return 'password-constraint'.i18n();
                              }
                            },
                          ),
                          Text(
                            "name-constraint".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 10),
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
                              if ((value != null && value.trim().isNotEmpty) &&
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 10),
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
                              if ((value != null && value.trim().isNotEmpty) &&
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 10),
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
                              if ((value != null && value.trim().isNotEmpty) &&
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
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 10),
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
                              if ((value != null && value.trim().isNotEmpty) &&
                                  !Validator.nameValidator(value)) {
                                return "name-constraint".i18n();
                              }
                            },
                          ),
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
