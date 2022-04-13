import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:flutter/material.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:motion_toast/motion_toast.dart';

class SandBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SandBox();
}

class _SandBox extends State<StatefulWidget> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        body: Container(
          margin: const EdgeInsets.fromLTRB(50, 50, 50, 0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 25),
                PasswordFormField(),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ToastFactory.makeToast(context, TOAST_TYPE.success,
                          "Submited", "Worked", false, () {});
                    } else {
                      ToastFactory.makeToast(context, TOAST_TYPE.error,
                          "Didn't submit", "Something is wrong", false, () {});
                    }
                  },
                  child: const Icon(Icons.subdirectory_arrow_right_outlined),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
