import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/models/error.dart';
import 'package:emtalik/pages/mainpage.dart';
import 'package:emtalik/pages/signup.dart';
import 'package:emtalik/providers/locale_provider.dart';
import 'package:emtalik/providers/theme_provider.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import '../etc/http_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _id = TextEditingController();
  final TextEditingController _password = TextEditingController();

  FocusNode idNode = FocusNode();
  FocusNode passwordNode = FocusNode();

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
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).colorScheme.onPrimary,
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
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
                              onPressed: () async {
                                final form = formKey.currentState!;
                                if (form.validate()) {
                                  var request;
                                  try {
                                    request = await HttpService.validateUser(
                                        _id.value.text, _password.value.text);
                                  } catch (exception) {
                                    ToastFactory.makeToast(
                                        context,
                                        TOAST_TYPE.error,
                                        null,
                                        "no-connection".i18n(),
                                        false,
                                        () {});
                                  }
                                  if (request != null) {
                                    // USER LOGIN
                                    if (request.statusCode == 200) {
                                      Provider.of<UserSession>(context,
                                              listen: false)
                                          .login(UserSession.fromRawJson(
                                              request.body));
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: ((context) =>
                                                  MyHomePage())));
                                    } else {
                                      // ERROR HANDLING
                                      ToastFactory.makeToast(
                                          context,
                                          TOAST_TYPE.error,
                                          "error".i18n(),
                                          Error.fromRawJson(request.body)
                                              .message
                                              .i18n(),
                                          false,
                                          () {});
                                    }
                                  }
                                }
                              },
                              child: Text("login".i18n()),
                              style:
                                  Theme.of(context).elevatedButtonTheme.style,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: ((context) => Signup())));
                              },
                              child: Text("no-account?".i18n()),
                            ),
                          ],
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed('/mainpage');
                          },
                          child: Text("login-as-guest".i18n()),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      IconButton(
                        onPressed: () {
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme();
                        },
                        icon: Icon(
                          Provider.of<ThemeProvider>(context).theme ==
                                  ThemeMode.dark
                              ? Icons.light_mode
                              : Icons.dark_mode,
                          color: Provider.of<ThemeProvider>(context).theme ==
                                  ThemeMode.dark
                              ? Colors.indigoAccent
                              : Colors.yellow[900],
                        ),
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
