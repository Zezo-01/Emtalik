import 'dart:io';

import 'package:emtalik/etc/validator.dart';
import 'package:flutter/material.dart';

import 'package:localization/localization.dart';

class CustomFormField extends StatefulWidget {
  CustomFormField(
      {Key? key,
      this.onChange,
      this.enable,
      this.controller,
      this.focusNode,
      this.info,
      this.onValidation,
      this.icon,
      this.type,
      this.enterKeyAction,
      this.labelText,
      this.onSave})
      : super(key: key);
  // INFO: Optional parameter to pass a function that will be excuted when ever the value of the textfield's change
  void Function(String value)? onChange;
  // INFO: this deals with the submit button (the enter key on the keyboard)
  String? Function(String? value)? onValidation;
  // INFO: this is to set the textfiedl as enabled or not
  bool? enable;
  // INFO: this is to display an info under the textifled
  String? info;
  // INFO: this is a controller to control the text field from outside when used
  TextEditingController? controller;
  //INFO: focus node used for focus configurations used for outside this widget
  FocusNode? focusNode;
  // INFO: this is the suffix icon
  Widget? icon;
  // INFO: Keyboard layout
  TextInputType? type;
  // INFO: Keyboar's enter key
  TextInputAction? enterKeyAction;
  // INFO: The label's text
  String? labelText;
  //INFO : Calls onSaved
  void Function(String? name)? onSave;
  @override
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => _CustomFormField(
      onChange: onChange,
      enable: enable,
      controller: controller,
      focusNode: focusNode,
      info: info,
      onValidation: onValidation,
      icon: icon,
      type: type,
      enterKeyAction: enterKeyAction,
      labelText: labelText,
      onSave: onSave);
}

class _CustomFormField extends State<CustomFormField> {
  bool? enable;
  TextEditingController? controller;
  void Function(String value)? onChange;
  String? Function(String? value)? onValidation;
  FocusNode? focusNode;
  String? info;
  Widget? icon;
  TextInputType? type;
  TextInputAction? enterKeyAction;
  String? labelText;
  void Function(String? name)? onSave;
  _CustomFormField(
      {this.onChange,
      this.enable,
      this.controller,
      this.focusNode,
      this.info,
      this.onValidation,
      this.icon,
      this.type,
      this.enterKeyAction,
      this.labelText,
      this.onSave});
  @override
  void initState() {
    controller ??= TextEditingController();
    controller?.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSave,
      validator: onValidation,
      focusNode: focusNode,
      controller: controller,
      keyboardType: type,
      onChanged: onChange,
      enabled: enable,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: controller == null || controller!.text.isEmpty
            ? icon
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  controller!.clear();
                },
              ),
        labelText: labelText,
        counter: Text(
          enable == false || info == null || info!.isEmpty
              ? ""
              : info.toString().i18n(),
          style: const TextStyle(
            fontSize: 12,
            color: Colors.amber,
          ),
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
