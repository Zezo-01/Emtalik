import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'forgetpassword.dart';
import 'package:localization/localization.dart';
import 'main.dart';
import 'mainpage.dart';
import 'settings.dart';
import 'signup.dart';

class login extends StatefulWidget {
  @override
  _login createState() => _login();
}

class _login extends State<login> {
  bool isRememerme = false;
  Widget bulidEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email'.i18n(),
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.lightBlue,
                    blurRadius: 6,
                    offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Color(0xFF66cccc),
                  ),
                  hintText: 'Email',
                  hintStyle: TextStyle(color: Colors.black38))),
        )
      ],
    );
  }

  Widget bulidPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.lightBlue,
                    blurRadius: 6,
                    offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextField(
              obscureText: true,
              style: TextStyle(color: Colors.black87),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Color(0xFF66cccc),
                  ),
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.black38))),
        )
      ],
    );
  }

  Widget bulidForgetPassword() {
    return Container(
        alignment: Alignment.centerRight,
        child: TextButton(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ForgotPassword()));
          },
          child: Text('Forger Password'),
        ));
  }

  Widget bulidLogInBtn() {
    return Container(
        alignment: Alignment.bottomCenter,
        child: TextButton(
          style: TextButton.styleFrom(
              backgroundColor: Colors.blueAccent, minimumSize: Size(300, 50)),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => MyHomePage()));
          },
          child: Text(
            'Login',
            style: TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget bulidRememberCb() {
    return Container(
      height: 20,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.black),
            child: Checkbox(
              value: isRememerme,
              checkColor: Colors.black,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  isRememerme = value!;
                });
              },
            ),
          ),
          Text(
            'Remember Me',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  Widget bulidSignupBtn() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => signup()));
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: 'Dont Have an Account?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold))
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xFF99ead6),
                  Color(0xFFc1f2e6),
                  Color(0xFFfff9cc),
                ])),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 120),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Sign in',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  // Image.asset('images/logo.png'),
                  SizedBox(height: 50),
                  bulidEmail(),
                  SizedBox(height: 20),
                  bulidPassword(),
                  SizedBox(height: 20),
                  bulidSignupBtn(),
                  bulidForgetPassword(),
                  bulidRememberCb(),
                  bulidLogInBtn()
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}
