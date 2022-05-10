import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:localization/localization.dart';

class Signup extends StatefulWidget{
  @override
  _Signup createState()=>_Signup();
  
}

class _Signup extends State<Signup>{
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
                    decoration:InputDecoration(labelText: "Enter Your First Name"),
                    validator: (value){
                      if(value!.isEmpty || RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                        return "Enter Correct Name";
                        
                      }
                      else {
                        return null;
                      }

                    },
              ),


              SizedBox(height: height*0.05,),
              TextFormField(
                    decoration:InputDecoration(labelText: "Enter Your Second Name"),
                    validator: (value){
                      if(value!.isEmpty || RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                        return "Enter Correct Name";
                        
                      }
                      else {
                        return null;
                      }

                    },
              ),


              SizedBox(height: height*0.05,),
              TextFormField(
                    decoration:InputDecoration(labelText: "Enter Your Last Name"),
                    validator: (value){
                      if(value!.isEmpty || RegExp(r'^[a-z A-Z]+$').hasMatch(value)){
                        return "Enter Correct Name";
                        
                      }
                      else {
                        return null;
                      }

                    },
              ),
              SizedBox(height: height*0.05,),

    ElevatedButton(
                          
                          onPressed: () {
                            if(formKey.currentState!.validate()){
                              
                              final snackBar=SnackBar(content: Text('Next'));
                              
                              _scaffoldkey.currentState!.showSnackBar(snackBar);
                              
                            }

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