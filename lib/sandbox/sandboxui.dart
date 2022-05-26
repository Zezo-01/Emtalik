import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class SandBoxUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          extendBodyBehindAppBar: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: const Text("E"),
                onPressed: () {},
              ),
              const SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                child: const Text("عـ"),
                onPressed: () {},
              )
            ],
          ),
          appBar: AppBar(
            title: const Icon(Icons.search),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  stops: const [
                    0.85,
                    0.2,
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
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 200,
                    ),
                    Text(
                      "app-name".i18n(),
                      style: Theme.of(context).textTheme.displayLarge,
                      textAlign: TextAlign.end,
                    ),
                    PasswordFormField(),
                    CustomFormField(
                      enterKeyAction: TextInputAction.done,
                      type: TextInputType.emailAddress,
                      icon: const Icon(
                        Icons.alternate_email_rounded,
                      ),
                      labelText: "Enter your email",
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text("Text Button"),
                    ),
                    OutlinedButton(
                      onPressed: () {},
                      child: const Text("Outlined Button"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        ToastFactory.makeToast(context, TOAST_TYPE.success,
                            "worked", "worked", false, () {});
                      },
                      child: const Text("Elevated Button"),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
