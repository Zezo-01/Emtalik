
import 'package:emtalik/pages/login.dart';
import 'package:emtalik/pages/mainpage.dart';
import 'package:emtalik/pages/signup1.dart';
import 'package:emtalik/pages/signup2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SettigsAdmin extends StatefulWidget{
  @override
  _SettingState createState() => _SettingState();

}


class _SettingState extends State<SettigsAdmin>{
  bool valNotify1=true;
bool valNotify2=true;


onChangeFunction1(bool newVAlue1){
  setState(() {
    valNotify1=newVAlue1;
  });
}

onChangeFunction2(bool newVAlue2){
  setState(() {
    valNotify1=newVAlue2;
  });
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Settings"),
        leading: IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40),
            Row(
              children:[
                Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                SizedBox(width: 10),
                Text('Account',style: TextStyle(fontSize: 22),)
              ]
            ),
            Divider(height: 20,thickness: 1),
            SizedBox(height: 10),
            bulidOptions(context, "Change Password"),
            bulidOptions(context, "Language"),
            bulidOptions(context, "Terms And Conditions"),
              Divider(height: 20,thickness: 1),
            SizedBox(height: 10),


            Divider(height: 20,thickness: 1),
            SizedBox(height: 40),
            Row(

children: [
  Icon(Icons.volume_up_outlined,color: Colors.blue),
  SizedBox(width: 10),
  Text("Notification",style: TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold
  ),)
],

            ),
            Divider(height: 20,thickness: 1),
            SizedBox(height: 10),
            BulidNotifications("Theme Dark",valNotify1, onChangeFunction1),
            BulidNotifications("Receive Notification",valNotify2, onChangeFunction2),
            SizedBox(height: 50),

            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal:40 ),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                onPressed: (){Navigator.of(context).pushNamed('/');},
                child: Text("Sign Out")
              ),
            )


          ],
        ),
      ),
    );

  
  
}
 
 
 Padding BulidNotifications(String title,bool value,Function onChangeMethod){
   return Padding(padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
   
   child: Row(


     mainAxisAlignment: MainAxisAlignment.spaceBetween,
     children: [

Text(title,style: TextStyle(
  fontSize: 20,
  fontWeight:FontWeight.w500,
  color: Colors.grey[600],
)),
Transform.scale(
  scale: 0.7,
  child: CupertinoSwitch(
    activeColor: Colors.blue,
    trackColor: Colors.grey,
    value: value,
    onChanged: (bool newValue){
      onChangeMethod(newValue);
    }
  ),
)

     ],
   ),
   );
 }
 
 

 
 
  GestureDetector bulidOptions(BuildContext context, String title){
    return GestureDetector(
      onTap: (){

if(title=="Change Password")
{
Navigator.of(context).pushNamed('/changepassword');
}
if(title=="Language")
{
Navigator.of(context).pushNamed('/');
}
if(title=="Terms And Conditions")
{
Navigator.of(context).pushNamed('/terms');
}
   


      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        child: Row(
          children: [
            Text(title,style:TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600]
            )),
            Icon(Icons.arrow_forward_ios,color: Colors.grey)
          ],
        ),
      ),
    );

  }
  
} 


