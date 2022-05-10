import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';

class Signup2 extends StatefulWidget{
  @override
  _Signup2 createState()=>_Signup2();
  
}

class _Signup2 extends State<Signup2>{
  final formKey=GlobalKey<FormState>();
  String name="";
  @override
  Widget build(BuildContext context) {
    final double height=MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldkey=GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFffffff),
      body: Container(
        padding: const EdgeInsets.only(left: 40,right: 40),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.04,),
              Text("Here To Get Welcomed"),
              SizedBox(height: height*0.05,),


              TextFormField(
                    decoration:InputDecoration(labelText: "Enter Your Phone Number"),
                    validator: (value){
                      if(value!.isEmpty || RegExp(r'^[+]*[(]{0,1})[0-9]{1,4}[)]{0,1}[-\s\./0-9]+$').hasMatch(value)){
                        return "Enter Correct Phone Number";
                        
                      }
                      else {
                        return null;
                      }

                    },
              ),


              SizedBox(height: height*0.05,),
              TextFormField(
                    decoration:InputDecoration(labelText: "Enter Your Email"),
                    validator: (value){
                      if(value!.isEmpty || RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}]').hasMatch(value)){
                        return "Enter Correct Email";
                        
                      }
                      else {
                        return null;
                      }

                    },
              ),


              SizedBox(height: height*0.05,),
              Row(),
              SizedBox(height: height*0.01,),
              Row(),

    ElevatedButton(
                          
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              final snackBar=SnackBar(content: Text('Submiting Sign Up'));
                              _scaffoldkey.currentState!.showSnackBar(snackBar);
                            }
                            Navigator.of(context).pushNamed('/mainpage');
                          },
                          child: Text("Submit".i18n()),
                        ),

            ],
          ),
        ),
      ),
    );

  }

  
}