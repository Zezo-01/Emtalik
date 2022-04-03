import 'dart:js';

import 'package:flutter/material.dart';
import 'login.dart';
import 'login.dart';
class NavBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(

             accountName: Text('Fadi Shalash'),
             accountEmail: Text('fadielshalash@gmail.com'),
             currentAccountPicture: CircleAvatar(
               child: ClipOval(
                 child: Image.network('https://www.google.com/search?q=image&sxsrf=APq-WBucXPDXgmR9cwYLqSHWisRdHDH9Bw:1648551661884&tbm=isch&source=iu&ictx=1&vet=1&fir=nH5liarSz56duM%252C0JWe7yDOKrVFAM%252C_%253Bn5hAWsQ-sgKo_M%252C-UStXW0dQEx4SM%252C_%253BDH7p1w2o_fIU8M%252CBa_eiczVaD9-zM%252C_%253BqXynBYpZpHkhWM%252C4O2GvGuD-Cf09M%252C_%253B2DNOEjVi-CBaYM%252CAOz9-XMe1ixZJM%252C_%253B0DzWhtJoQ1KWgM%252CcIQ7wXCEtJiOWM%252C_%253Bz4_uU0QB2pe-SM%252C7SySw5zvOgPYAM%252C_%253BA4G7eW2zetaunM%252Cl3NoP295SYrYvM%252C_%253BsmRkxzhk74wASM%252CbUbrhOtxELp8CM%252C_%253BMOAYgJU89sFKnM%252CygIoihldBPn-LM%252C_%253BxE4uU8uoFN00aM%252CpEU77tdqT8sGCM%252C_%253BbDjlNH-20Ukm8M%252CG9GbNX6HcZ2O_M%252C_&usg=AI4_-kRfUkisRJwpq4sQ_YbWyZ5klnmr7A&sa=X&ved=2ahUKEwj_6szBlev2AhUJUcAKHV2_AtEQ9QF6BAgqEAE#imgrc=qXynBYpZpHkhWM',
                 width: 90,
                 height: 90,
                 fit: BoxFit.cover,
                 ),
               ),
             ),
             decoration: BoxDecoration(
               color: Color.fromARGB(255, 122, 191, 247),
               image: DecorationImage(
                 image: NetworkImage('https://www.google.com/search?q=background&sxsrf=APq-WBv_MhXNQhU7rWEP2weTPuHQMr0pRg:1648550349754&source=lnms&tbm=isch&sa=X&ved=2ahUKEwj97_bPkOv2AhUKXMAKHfJSDBcQ_AUoAXoECAEQAw&biw=1031&bih=912&dpr=1#imgrc=2G2gzgfrWcYnjM'
                 ),

                 fit: BoxFit.cover,
               ),
             ), 
          ),
          ListTile(
        leading: Icon(Icons.favorite),
        title: Text('Favorite'),
        onTap: ()=>print("Favorite Pressed"),
        trailing: Container(
          color: Color.fromARGB(255, 120, 234, 238),
          width: 20,
          height: 20,
          child:Center(child: Text(
            '8',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20
            ),
          ),),
          
        ),
          ),

          

          ListTile(
        leading: Icon(Icons.settings),
        title: Text('Settings'),
        onTap: ()=>print("Settings Pressed"),
        
        ),
          

          ListTile(
        leading: Icon(Icons.description),
        title: Text('Policies'),
        onTap: ()=>print("Polices Pressed"),
          ),

          ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Exit'),
        onTap:(){
          Navigator.of(context).push(MaterialPageRoute(builder:(context)=>login()));
        },
          ),
        ],
      ),
    );
  }
}