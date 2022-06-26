import 'dart:convert';

import 'package:emtalik/Widgets/displaycard.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/estate_response.dart';
import 'package:emtalik/pages/apartment_display.dart';
import 'package:emtalik/pages/house_display.dart';
import 'package:emtalik/pages/land_display.dart';
import 'package:emtalik/pages/parking_display.dart';
import 'package:emtalik/pages/store_display.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:localization/localization.dart';

class MyEstates extends StatefulWidget {
  MyEstates({Key? key, required this.userId}) : super(key: key);
  int userId;
  @override
  State<MyEstates> createState() => _MyEstatesState(userId: userId);
}

class _MyEstatesState extends State<MyEstates> {
  _MyEstatesState({required this.userId});
  int userId;

  late Future<List<EstateResponse>> estates;

  Future<List<EstateResponse>> getEstates() async {
    List<EstateResponse> estates = List.empty(growable: true);
    http.Response estateResponse = await HttpService.getUserEstates(userId);
    var estatesList = jsonDecode(estateResponse.body);
    if (estatesList.isNotEmpty) {
      for (var estate in estatesList) {
        estates.add(EstateResponse.fromJson(estate));
      }
    }
    return estates;
  }

  @override
  void initState() {
    super.initState();
    estates = getEstates();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("my-estates".i18n()),
        centerTitle: true,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: RefreshIndicator(
          onRefresh: () async {
            setState(() {
              estates = getEstates();
            });
          },
          child: FutureBuilder(
            future: estates,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.hasData) {
                  final estates = snapshot.data as List<EstateResponse>;

                  if (estates.isEmpty) {
                    return Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "no-estates".i18n(),
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                this.estates = getEstates();
                              });
                            },
                            icon: const Icon(
                              Icons.refresh,
                              size: 35,
                            ),
                            color: Theme.of(context).colorScheme.primary,
                          )
                        ],
                      ),
                    );
                  } else {
                    return GridView.builder(
                      itemCount: estates.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 2 / 4,
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (context, index) {
                        return DisplayCard(
                          onPress: () {
                            if (estates.elementAt(index).type == "parking") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ParkingDisplay(
                                    id: estates.elementAt(index).id,
                                  ),
                                ),
                              );
                            } else if (estates.elementAt(index).type ==
                                "apartment") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ApartmentDisplay(
                                    id: estates.elementAt(index).id,
                                  ),
                                ),
                              );
                            } else if (estates.elementAt(index).type ==
                                "house") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HouseDisplay(
                                    id: estates.elementAt(index).id,
                                  ),
                                ),
                              );
                            } else if (estates.elementAt(index).type ==
                                "store") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => StoreDisplay(
                                    id: estates.elementAt(index).id,
                                  ),
                                ),
                              );
                            } else if (estates.elementAt(index).type ==
                                "land") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LandDisplay(
                                    id: estates.elementAt(index).id,
                                  ),
                                ),
                              );
                            }
                          },
                          borderColor: Theme.of(context).colorScheme.primary,
                          header:
                              decodeUtf8ToString(estates.elementAt(index).name),
                          imageNetworkPath: HttpService.getEstateMainPicture(
                              estates.elementAt(index).id),
                          footer1: estates.elementAt(index).province.i18n(),
                          footer2:
                              decodeUtf8ToString(estates.elementAt(index).type)
                                  .i18n(),
                        );
                      },
                    );
                  }
                } else {
                  return Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          "no-connection".i18n(),
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              this.estates = getEstates();
                            });
                          },
                          icon: const Icon(
                            Icons.refresh,
                            size: 35,
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  );
                }
              }
            },
          ),
        ),
      ),
    ));
  }
}
