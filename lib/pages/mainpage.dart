// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, annotate_overrides, prefer_const_constructors_in_immutables

import 'package:emtalik/pages/NavBar.dart';
import 'package:emtalik/pages/search.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  _MyHomePage createState() => _MyHomePage();
}

class _MyHomePage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("search".i18n()),
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
          backgroundColor:Theme.of(context).backgroundColor,
          bottom: TabBar(

            tabs: [
              Tab(
                text: "offers".i18n(),
                icon: Icon(Icons.local_offer),
              ),
              Tab(
                text: "settings".i18n(),
                icon: Icon(Icons.settings),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [bulidCard(), NavBar()],
        ),
      ));

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
                        color:Theme.of(context).colorScheme.primary ,
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
                        style: TextStyle(fontSize: 16,color:Theme.of(context).colorScheme.primary ,),
                        
                      ),
                      Text(
                        "estate".i18n(),
                        style: TextStyle(fontSize: 16,color:Theme.of(context).colorScheme.primary ,),
                      ),
                      Text(
                        "name-estate".i18n(),
                        style: TextStyle(fontSize: 16,color:Theme.of(context).colorScheme.primary ,),
                      ),
                    ],
                  )),
              ButtonBar()
            ],
          ),
        ),
      );
}
