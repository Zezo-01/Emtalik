import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/Widgets/displaycard.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class SandBoxUi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
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
    );
  }
}
