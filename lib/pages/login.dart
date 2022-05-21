import 'dart:convert';
import 'dart:ffi';

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/localemanager.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/providers/locale_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

/*
*                              TODO:ERROR *** VERTICAL SCROLLING IS NEEDED
*/
class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _password = TextEditingController();

  FocusNode idNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode loginNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    idNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              stops: const [
                0.85,
                0.5,
              ],
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).colorScheme.onPrimary,
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
          // TODO: FADI HERE
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    "app-name".i18n(),
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomFormField(
                          onComplete: () {
                            FocusScope.of(context).requestFocus(passwordNode);
                          },
                          onValidation: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'required-field'.i18n();
                            }
                          },
                          focusNode: idNode,
                          controller: _id,
                          enterKeyAction: TextInputAction.next,
                          type: TextInputType.name,
                          labelText: "id-types",
                          icon: const Icon(Icons.perm_identity),
                        ),
                        PasswordFormField(
                          onComplete: () {
                            FocusScope.of(context).requestFocus(loginNode);
                          },
                          onValidation: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'required-field'.i18n();
                            }
                          },
                          focusNode: passwordNode,
                          controller: _password,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              focusNode: loginNode,
                              onPressed: () async {
                                final form = formKey.currentState!;
                                if (form.validate()) {
                                  // TODO: IMPLEMENT VALIDATION
                                  // Navigator.of(context).pushNamed('/mainpage');
                                }
                              },
                              child: Text("login".i18n()),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/signup1');
                              },
                              child: Text("no-account?".i18n()),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            ToastFactory.makeToast(
                                context,
                                TOAST_TYPE.info,
                                "Guest Functionality",
                                "Implement Guest Functionality",
                                false,
                                () {});
                          },
                          child: Text("login-as-guest".i18n()),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Provider.of<LocaleProvider>(context, listen: false)
                              .toggleLanguage();
                        },
                        child: Text(
                            Provider.of<LocaleProvider>(context).locale ==
                                    const Locale('ar')
                                ? 'English'
                                : 'العربية'),
                      ),
                    ],
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
