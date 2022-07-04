// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:emtalik/etc/http_service.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class MySearch extends SearchDelegate {
  String? searchMethod;
  String? province;
  String? estateType;

  List<String> searchMethods = ["estates", "users", "offers"];
  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 0,
      itemBuilder: (context, index) {
        return Center();
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: query == "estates".i18n() + ": " ? 1 : searchMethods.length,
      itemBuilder: (context, index) {
        if (query == "estates".i18n() + ": ") {
          searchMethod = "estate";
          return Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                      constraints: BoxConstraints.loose(Size(
                          (MediaQuery.of(context).size.width - 20) / 2,
                          MediaQuery.of(context).size.height))),
                  value: province,
                  onChanged: (value) {
                    province = value!;
                  },
                  hint: Text("pick-province".i18n()),
                  items: [
                    DropdownMenuItem(
                      child: Text("nablus".i18n()),
                      value: "nablus",
                    ),
                    DropdownMenuItem(
                      child: Text("ramallah".i18n()),
                      value: "ramallah",
                    ),
                    DropdownMenuItem(
                      child: Text("selfeet".i18n()),
                      value: "selfeet",
                    ),
                    DropdownMenuItem(
                      child: Text("hebrone".i18n()),
                      value: "hebrone",
                    ),
                    DropdownMenuItem(
                      child: Text("tubas".i18n()),
                      value: "tubas",
                    ),
                    DropdownMenuItem(
                      child: Text("bethleem".i18n()),
                      value: "bethleem",
                    ),
                    DropdownMenuItem(
                      child: Text("jenin".i18n()),
                      value: "jenin",
                    ),
                    DropdownMenuItem(
                      child: Text("jericho".i18n()),
                      value: "jericho",
                    ),
                    DropdownMenuItem(
                      child: Text("tulkarem".i18n()),
                      value: "tulkarem",
                    ),
                    DropdownMenuItem(
                      child: Text("qalqilya".i18n()),
                      value: "qalqilya",
                    ),
                    DropdownMenuItem(
                      child: Text("jerusalem".i18n()),
                      value: "jerusalem",
                    ),
                  ],
                ),
                DropdownButtonFormField<String>(
                  value: estateType,
                  decoration: InputDecoration(
                      constraints: BoxConstraints.loose(Size(
                          (MediaQuery.of(context).size.width - 20) / 2,
                          MediaQuery.of(context).size.height))),
                  hint: Text("pick-estate-type".i18n()),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "required-field".i18n();
                    }
                  },
                  onChanged: (value) {
                    estateType = value!;
                  },
                  items: <DropdownMenuItem<String>>[
                    DropdownMenuItem(
                      value: "parking",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("parking".i18n()),
                          const Icon(Icons.local_parking),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "house",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("house".i18n()),
                          const Icon(Icons.house),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "apartment",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("apartment".i18n()),
                          const Icon(Icons.apartment),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "store",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("store".i18n()),
                          const Icon(Icons.store),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: "land",
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("land".i18n()),
                          const Icon(Icons.landscape),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return ListTile(
            title: Text(searchMethods[index].i18n()),
            onTap: () {
              query = searchMethods[index].i18n() + ": ";
            },
          );
        }
      },
    );
  }
}
