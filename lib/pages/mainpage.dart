// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, annotate_overrides, prefer_const_constructors_in_immutables

import 'package:emtalik/pages/navbar.dart';
import 'package:emtalik/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  int index = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: Text(
            "search".i18n(),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MySearch(),
                );
              },
            ),
          ],
        ),
        body: Column(children: <Widget>[
          Spacer(),
          Padding(
            padding: EdgeInsets.only(
              top: 10.0,
              left: 18,
              right: 18,
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 0;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: index == 0
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.local_offer_outlined,
                            color: index == 0 ? Colors.white : Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 1;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: index == 1
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.real_estate_agent,
                            color: index == 1 ? Colors.white : Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 2;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: index == 2
                            ? Theme.of(context).colorScheme.onPrimary
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.account_balance,
                            color: index == 2 ? Colors.white : Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      index = 3;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: index == 3
                          ? Theme.of(context).colorScheme.onPrimary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 10),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.report_problem,
                            color: index == 3 ? Colors.white : Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]),
      );

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
                    height: 200,
                    width: 500,
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
                        color: Theme.of(context).colorScheme.primary,
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
                        "location".i18n(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "estate".i18n(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        "name-estate".i18n(),
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  )),
              ButtonBar()
            ],
          ),
        ),
      );
}
