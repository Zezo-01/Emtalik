import 'dart:convert';

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/estate_response.dart';
import 'package:emtalik/models/offer.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class OfferCreate extends StatefulWidget {
  const OfferCreate({Key? key}) : super(key: key);

  @override
  State<OfferCreate> createState() => _OfferCreateState();
}

class _OfferCreateState extends State<OfferCreate> {
  int? _offerType;
  int? _negotiable;
  int? estateId;

  List<EstateResponse>? estates = List.empty(growable: true);

  final _formKey = GlobalKey<FormState>();

  final _offerNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _rentPerMonthController = TextEditingController();
  final _rentPerYearController = TextEditingController();
  final _rentPerSeassonController = TextEditingController();

  void getCurrentUserEstates() async {
    var response = await HttpService.getUserApprovedEstates(
        Provider.of<UserSession>(context, listen: false).id ?? 0);
    if (response.statusCode == 200) {
      var lists = jsonDecode(response.body);
      for (var estate in lists) {
        setState(() {
          estates!.add(EstateResponse.fromJson(estate));
        });
      }
    } else {
      ToastFactory.makeToast(
          context, TOAST_TYPE.error, null, "error".i18n(), false, () {
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    _negotiable = 0;
    _offerType = 1;
    super.initState();
    getCurrentUserEstates();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            title: Text("add-offer".i18n()),
            elevation: 0,
            centerTitle: true,
          ),
          body: Container(
            margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  CustomFormField(
                    onComplete: () {},
                    type: TextInputType.name,
                    controller: _offerNameController,
                    enterKeyAction: TextInputAction.done,
                    onValidation: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "required-field".i18n();
                      }
                      if (value.length > 25) {
                        return "";
                      }
                    },
                    labelText: "offer-name".i18n(),
                    icon: const Icon(Icons.handshake),
                  ),
                  Text(
                    "offer-name-constraint".i18n(),
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: Theme.of(context).colorScheme.primary),
                  ),
                  DropdownButtonFormField<int>(
                    hint: Text("pick-estate".i18n()),
                    validator: (value) {
                      if (value == null) {
                        return "required-field".i18n();
                      }
                    },
                    onChanged: (value) {
                      estateId = value;
                    },
                    items: estates!.map((e) {
                      return DropdownMenuItem<int>(
                          child: Text(decodeUtf8ToString(e.name)), value: e.id);
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("rent".i18n(),
                              style: Theme.of(context).textTheme.labelMedium),
                          Radio(
                            value: 1,
                            groupValue: _offerType,
                            onChanged: (value) {
                              setState(() {
                                _offerType = 1;
                              });
                            },
                          ),
                        ],
                      ),
                      Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text("sell".i18n(),
                              style: Theme.of(context).textTheme.labelMedium),
                          Radio(
                            value: 2,
                            groupValue: _offerType,
                            onChanged: (value) {
                              setState(() {
                                _offerType = 2;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _offerType == 1
                      ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              CustomFormField(
                                labelText: "rent-per-month".i18n(),
                                controller: _rentPerMonthController,
                                enterKeyAction: TextInputAction.done,
                                type: TextInputType.number,
                                icon: const Icon(Icons.price_check),
                              ),
                              CustomFormField(
                                labelText: "rent-per-year".i18n(),
                                controller: _rentPerYearController,
                                enterKeyAction: TextInputAction.done,
                                type: TextInputType.number,
                                icon: const Icon(Icons.price_check),
                              ),
                              CustomFormField(
                                labelText: "rent-per-seasson".i18n(),
                                controller: _rentPerSeassonController,
                                enterKeyAction: TextInputAction.done,
                                type: TextInputType.number,
                                icon: const Icon(Icons.price_check),
                              ),
                              RadioListTile(
                                title: Text("negotiable".i18n(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                value: 1,
                                groupValue: _negotiable,
                                toggleable: true,
                                onChanged: (value) {
                                  if (_negotiable == 1) {
                                    setState(() {
                                      _negotiable = 0;
                                    });
                                  } else {
                                    setState(() {
                                      _negotiable = 1;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              CustomFormField(
                                labelText: "price".i18n(),
                                controller: _priceController,
                                enterKeyAction: TextInputAction.done,
                                type: TextInputType.number,
                                icon: const Icon(Icons.price_check),
                              ),
                              RadioListTile(
                                title: Text("negotiable".i18n(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium),
                                value: 1,
                                groupValue: _negotiable,
                                toggleable: true,
                                onChanged: (value) {
                                  if (_negotiable == 1) {
                                    setState(() {
                                      _negotiable = 0;
                                    });
                                  } else {
                                    setState(() {
                                      _negotiable = 1;
                                    });
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var response = await HttpService.createOffer(
                            Offer(
                              name: _offerNameController.text,
                              type: _offerType == 1 ? "rent" : "sell",
                              negotiable: _negotiable == 0 ? false : true,
                              sellPrice: int.parse(_priceController.text),
                              rentPricePerMonth:
                                  int.parse(_rentPerMonthController.text),
                              rentPricePerYear:
                                  int.parse(_rentPerYearController.text),
                              rentPricePerSeasson:
                                  int.parse(_rentPerSeassonController.text),
                            ),
                            estateId ?? 0);
                        if (response.statusCode == 200) {
                          Navigator.of(context).pop();
                        } else {
                          ToastFactory.makeToast(context, TOAST_TYPE.error,
                              null, "error".i18n(), false, () {});
                        }
                      }
                    },
                    child: Text(
                      "submit".i18n(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
