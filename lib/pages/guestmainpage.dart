// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, annotate_overrides, prefer_const_constructors_in_immutables

import 'package:emtalik/pages/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class GuestPage extends StatefulWidget {
  GuestPage({Key? key}) : super(key: key);

  _GuestPage createState() => _GuestPage();
}

class _GuestPage extends State<GuestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            bulidCard(),
          ],
        ),
      ),
    );
  }

  Widget bulidCard() => Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Stack(
                children: [
                  Ink.image(
                    image: NetworkImage(
                      'https://images.unsplash.com/photo-1514888286974-6c03e2ca1dba?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1327&q=80',
                    ),
                    child: InkWell(
                      onTap: () {},
                    ),
                    height: 500,
                    width: 1000,
                    fit: BoxFit.cover,
                  ),
                  // ignore: prefer_const_constructors
                  Positioned(
                    bottom: 16,
                    right: 16,
                    left: 16,
                    // ignore: prefer_const_constructors
                    child: Text(
                      "land".i18n(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.all(16).copyWith(bottom: 0),
                  child: Column(
                    children: [
                      Text(
                        'Location:- Arraba',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Area:- 500',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Owner:- Yazeed Mograby',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Price :- 500000',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Contact:- 04-67447748',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  )),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [],
              )
            ],
          ),
        ),
      );
}
