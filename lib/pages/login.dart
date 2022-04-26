import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/localemanager.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/signup.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

import '../forgetpassword.dart';
import '../mainpage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

/*
*                              TODO:ERROR *** VERTICAL SCROLLING IS NEEDED
*/
class _LoginPage extends State<LoginPage> {
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.infinity,
          height: double.infinity,
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
          child: Container(
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomFormField(
                      onComplete: () {
                        FocusScope.of(context).requestFocus(passwordNode);
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
                      focusNode: passwordNode,
                      controller: _password,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          focusNode: loginNode,
                          onPressed: () {
                            
                            ToastFactory.makeToast(
                                context,
                                TOAST_TYPE.info,
                                "Login Functionality",
                                "Implement Login Functionality",
                                false,
                                () {});
                          },
                          child: Text("Login".i18n()),
                        ),
                        TextButton(
                          onPressed: (){
                            
                            ToastFactory.makeToast(
                                context,
                                TOAST_TYPE.info,
                                "Sign up Functionality",
                                "Implement Sign up Functionality",
                                false,
                                () {});
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        LocaleManager.selectArabic();
                      },
                      child: const Text("العربية"),
                    ),
                    TextButton(
                      onPressed: () {
                        LocaleManager.selectEnglish();
                      },
                      child: const Text("English"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
