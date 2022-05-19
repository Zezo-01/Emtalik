import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';

class Signup2 extends StatefulWidget {
  @override
  _Signup2 createState() => _Signup2();
}

class _Signup2 extends State<Signup2> {
  final items = ['Lands', 'Appartment', 'Stores', 'Parking'];
  String? value;
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

  final formKey = GlobalKey<FormState>();
  String name = "";
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 40, right: 40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height * 0.04,
              ),
              Text("Here To Get Welcomed"),
              SizedBox(
                height: height * 0.05,
              ),
              CustomFormField(
                onComplete: () {},
                focusNode: idNode,
                controller: _id,
                enterKeyAction: TextInputAction.next,
                type: TextInputType.name,
                labelText: "Enter Your Email",
                icon: const Icon(Icons.email),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              CustomFormField(
                onComplete: () {},
                focusNode: idNode,
                controller: _id,
                enterKeyAction: TextInputAction.next,
                type: TextInputType.name,
                labelText: "Enter Your Phone Number",
                icon: const Icon(Icons.phone),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              Text("Your Interset"),
              DropdownButton<String>(
                value: value,
                items: items.map((bulidMenuItem)).toList(),
                onChanged: (value) => setState(() => this.value = value),
              ),
              SizedBox(
                height: height * 0.05,
              ),
              ElevatedButton(
                focusNode: loginNode,
                onPressed: () {
                  Navigator.of(context).pushNamed('/mainpage');
                },
                child: Text("Next".i18n()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


    DropdownMenuItem<String> bulidMenuItem(String item) => DropdownMenuItem(
          value: item,
          child: Text(
            item,
            style: TextStyle(color:Colors.black,fontWeight: FontWeight.bold,fontSize: 22),
          ),
        );