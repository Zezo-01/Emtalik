import 'dart:convert';

import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/models/offer.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';

class MyOffers extends StatefulWidget {
  MyOffers({Key? key, required this.userId}) : super(key: key);

  int userId;
  @override
  State<MyOffers> createState() => _MyOffersState(userId: userId);
}

class _MyOffersState extends State<MyOffers> {
  _MyOffersState({required this.userId});

  late Future<List<Offer>> offers;

  Future<List<Offer>> getOffers() async {
    List<Offer> offers = List.empty(growable: true);
    http.Response offerResponse = await HttpService.getUserOffers(userId);
    var offersList = jsonDecode(offerResponse.body);
    if (offersList.isNotEmpty) {
      for (var estate in offersList) {
        offers.add(Offer.fromJson(estate));
      }
    }
    return offers;
  }

  @override
  void initState() {
    super.initState();
    offers = getOffers();
  }

  int userId;
  @override
  Widget build(BuildContext context) {}
}
