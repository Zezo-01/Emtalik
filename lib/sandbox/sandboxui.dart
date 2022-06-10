import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/Widgets/displaycard.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/pages/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class SandBoxUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
<<<<<<< HEAD
      child: UserProfile(),
      // child: Scaffold(
      //   body: SingleChildScrollView(
      //     child: DisplayCard(
      //       onPress: () {
      //         debugPrint("HELLO");
      //       },
      //       header: "Header",
      //       footer1: "Footer1",
      //       footer2: "Footer2",
      //       imageNetworkPath:
      //           "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&w=1000&q=80",
      //       borderColor: Colors.amber,
      //     ),
      //   ),
      // ),
=======
      child: GridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        childAspectRatio: 2/4,
        children: List.generate(10, (index){
         return Card(
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
           child: DisplayCard(borderColor: Colors.blue,footer1: 'Abo Sator',footer2: 'ابو ساطور',header: 'Bab Al7ara',imageNetworkPath: 'https://al-arrab.com/wp-content/uploads/2022/01/Doc-P-907467-637778562956208455.jpg'),
         );
        },
      ),
      
    )
>>>>>>> 983d59b933ffd13f76810a769b61ddecbdd4940a
    );
  }
}
