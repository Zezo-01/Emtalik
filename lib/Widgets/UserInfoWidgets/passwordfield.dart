import 'dart:io';

import 'package:flutter/material.dart';

import 'package:localization/localization.dart';

class PasswordField extends StatefulWidget {
  PasswordField(
      {Key? key, this.onChange, this.enable, this.info, this.controller})
      : super(key: key);
  // INFO: Optional parameter to pass a function that will be excuted when ever the value of the textfield's change
  void Function(String value)? onChange;
  // INFO: this is to set the textfiedl as enabled or not
  bool? enable;
  // INFO: this is to display an info under the textifled
  String? info;
  TextEditingController? controller;
  @override
  State<StatefulWidget> createState() => _PasswordField(
      onChange: onChange, enable: enable, info: info, controller: controller);
}

class _PasswordField extends State<StatefulWidget> {
  bool showPassword = true;
  bool? enable;
  String? info;
  TextEditingController? controller;
  void Function(String value)? onChange;
  _PasswordField({this.onChange, this.enable, this.info, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: showPassword,
      keyboardType: TextInputType.visiblePassword,
      onChanged: onChange,
      enabled: enable,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: controller!.text.isEmpty
            ? const Icon(Icons.password)
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  controller!.clear();
                },
              ),
        label: Text("password".i18n()),
        hintText: "password".i18n(),
        counterText: info == null ? "" : info.toString().i18n(),
        counter: Text(
          info == null ? "" : info.toString().i18n(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.amber,
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          gapPadding: 4,
        ),
      ),
    );
  }
}
