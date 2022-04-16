import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SandBoxUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
          ),
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
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
                ],
              ),
            ),
          )),
    );
  }
}
