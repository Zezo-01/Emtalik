import 'package:flutter/material.dart';

import 'package:localization/localization.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    Key? key,
    this.onChange,
  }) : super(key: key);
  // TODO: Optional parameter to pass a function that will be excuted when ever the value of the textfield's change
  final void Function(String value)? onChange;
  @override
  State<StatefulWidget> createState() => _PasswordField(onChange: onChange);
}

class _PasswordField extends State<StatefulWidget> {
  bool show = true;
  final void Function(String value)? onChange;
  _PasswordField({this.onChange});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        label: Text("password".i18n()),
        hintText: "password".i18n(),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              show = !show;
            });
          },
          icon: show
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          gapPadding: 4,
        ),
      ),
      obscureText: show,
      keyboardType: TextInputType.visiblePassword,
      onChanged: onChange,
    );
  }
}
