import 'dart:io';

import 'package:emtalik/etc/validator.dart';
import 'package:flutter/material.dart';

import 'package:localization/localization.dart';

/*





*                                        DONT USE
*                                       DEPRECATED




*/
@deprecated
class PasswordField extends StatefulWidget {
  PasswordField({
    Key? key,
    this.onChange,
    this.enable,
    this.info,
    this.controller,
    this.focusNode,
  }) : super(key: key);
  // INFO: Optional parameter to pass a function that will be excuted when ever the value of the textfield's change
  void Function(String value)? onChange;
  // INFO: this deals with the submit button (the enter key on the keyboard)

  // INFO: this is to set the textfiedl as enabled or not
  bool? enable;
  // INFO: this is to display an info under the textifled
  String? info;
  // INFO: this is a controller to control the text field from outside when used
  TextEditingController? controller;
  //INFO: focus node used for focus configurations used for outside this widget
  FocusNode? focusNode;
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _PasswordField(
        onChange: onChange,
        enable: enable,
        controller: controller,
        focusNode: focusNode,
        info: info,
      );
}

class _PasswordField extends State<PasswordField> {
  bool showPassword = true;
  bool? enable;
  String? info;
  TextEditingController? controller;
  void Function(String value)? onChange;
  FocusNode? focusNode;
  _PasswordField({
    this.onChange,
    this.enable,
    this.info,
    this.controller,
    this.focusNode,
  });

  @override
  void initState() {
    controller ??= TextEditingController();
    controller?.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      obscureText: showPassword,
      keyboardType: TextInputType.visiblePassword,
      onChanged: onChange,
      enabled: enable,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: controller == null || controller!.text.isEmpty
            ? const Icon(Icons.password)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  controller!.clear();
                },
              ),
        label: Text("password".i18n()),
        counter: Text(
          enable == false || info == null ? "" : info.toString().i18n(),
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              showPassword = !showPassword;
            });
          },
          icon: showPassword
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          gapPadding: 4,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          gapPadding: 4,
          borderSide: BorderSide(color: Colors.red.shade400, width: 3),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          gapPadding: 4,
          borderSide: const BorderSide(
            style: BorderStyle.none,
          ),
        ),
      ),
    );
  }
}
