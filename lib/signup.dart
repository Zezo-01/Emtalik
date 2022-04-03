import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'login.dart';
import 'mainpage.dart';

class signup extends StatefulWidget
{
@override
 _signup createState()=>_signup();
}

class _signup extends State<signup>{
  bool isRememerme=false;
  Widget bulidEmail()
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget> [
      Text('Email',
      style: TextStyle(
      color:Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold, 
      ) ,
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.lightBlue
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.email,
              color:Color(0xFF66cccc
) ,
            ),
            hintText: 'Email',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          )
        ),
      )
    ],
  );
}


Widget bulidName()
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget> [
      Text('Enter Full Name',
      style: TextStyle(
      color:Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold, 
      ) ,
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(
            color: Colors.lightBlue
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.person,
              color:Color(0xFF66cccc
) ,
            ),
            hintText: 'Enter Full Name',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          )
        ),
      )
    ],
  );
}




Widget bulidPassword()
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget> [
      Text('Password',
      style: TextStyle(
      color:Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold, 
      ) ,
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
         obscureText: true,
          style: TextStyle(
            color: Colors.lightBlue
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock,
              color:Color(0xFF66cccc) ,
            ),
            hintText: 'Password',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          )
        ),
      )
    ],
  );
}

Widget bulidrePassword()
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget> [
      Text('Re-Enter Password',
      style: TextStyle(
      color:Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold, 
      ) ,
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
         obscureText: true,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.lock,
              color:Color(0xFF66cccc) ,
            ),
            hintText: 'Re-Enter Password',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          )
        ),
      )
    ],
  );
}


Widget bulidPhone()
{
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:<Widget> [
      Text('Enter Phone Number',
      style: TextStyle(
      color:Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold, 
      ) ,
      ),
      SizedBox(height: 10),
      Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.blue,
              blurRadius: 6,
              offset: Offset(0,2)
            )
          ]
        ),
        height: 60,
        child: TextField(
          inputFormatters: [],
         maxLength: 10,
          style: TextStyle(
            color: Colors.black87
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(top: 14),
            prefixIcon: Icon(
              Icons.phone,
              color:Color(0xFF66cccc) ,
            ),
            hintText: 'Phone Number',
            hintStyle: TextStyle(
              color: Colors.black38
            )
          )
        ),
      )
    ],
  );
}


Widget bulidSignUpBtn()
{
  return Container(
    alignment: Alignment.bottomCenter,
    child: TextButton(
  style: TextButton.styleFrom(
    backgroundColor: Colors.blueAccent,
    minimumSize: Size(300, 50)
  ),
  onPressed: () { Navigator.of(context).push(MaterialPageRoute(builder:(context)=>MyHomePage()));},
  child: Text('Sign Up',
  style: TextStyle(
    color: Colors.white
  ),),
)
  );
}



@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children:<Widget> [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF99ead6  ),
                 Color(0xFFc1f2e6
 ),
                  Color(0xFFfff9cc),
                  ]
                )
              ),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 120
              ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children:<Widget> [
                  Text('Sign Up',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  ),
                  ),
                  // Image.asset('images/logo.png'),
                  SizedBox(height:30),
                  bulidName(),
                  SizedBox(height: 10),
                  bulidEmail(),
                  SizedBox(height: 10),
                  bulidPassword(),
                  SizedBox(height: 10),
                  bulidrePassword(),
                  SizedBox(height: 10),
                  bulidPhone(),
                  SizedBox(height: 50),
                  bulidSignUpBtn(),

                  
                ],
              ),
            ),

            )
          ],
        ),
      )

    );
  }
}