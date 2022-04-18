import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:flutter/material.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:localization/localization.dart';

import '../etc/validator.dart';

/*
*                           THIS IS A SANDBOX CLASS USED FOR TESTING WIDGETS
*/

class SandBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SandBox();
}

class _SandBox extends State<StatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Container(
          margin: const EdgeInsets.fromLTRB(50, 50, 50, 0),
          child: CustomFormField(
            labelText: "someshit",
            icon: const Icon(
              Icons.perm_identity,
            ),
          ),
        ),
      ),
    );
  }
}
