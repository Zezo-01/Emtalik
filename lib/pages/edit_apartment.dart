// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/apartment.dart';
import 'package:emtalik/models/apartment_register.dart';
import 'package:emtalik/models/error.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class EditAppartmnet extends StatefulWidget {
  EditAppartmnet({
    Key? key,
    required this.id,
  }) : super(key: key);
  int id;
  late String province;

  @override
  State<StatefulWidget> createState() => _EditAppartmnet(id: id);
}

class _EditAppartmnet extends State<EditAppartmnet> {
  _EditAppartmnet({
    required this.id,
  });

  int id;
  final _formKey = GlobalKey<FormState>();

  final _apartmentName = TextEditingController();
  final _apartmentAddress = TextEditingController();

  final _apartmentDescription = TextEditingController();
  final _apartmentSize = TextEditingController();
  final _confirmPasswordId = TextEditingController();

  final _apartmentFloorNumberController = TextEditingController();
  final _apartmentNumberController = TextEditingController();

  late String province;
  late Future<Apartment> apartment;

  late bool initlized;

  Future<Apartment> getEstate() async {
    var response = await HttpService.getEstateByTypeAndId("apartment", id);
    return Apartment.fromRawJson(response.body);
  }

  @override
  void initState() {
    initlized = false;
    super.initState();
    apartment = getEstate();
    province = "";
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureBuilder(
          future: apartment,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  appBar: AppBar(),
                  body: Center(child: CircularProgressIndicator()));
            } else {
              var apartment = snapshot.data as Apartment;
              if (initlized == false) {
                _apartmentName.text = decodeUtf8ToString(apartment.name);
                _apartmentAddress.text = decodeUtf8ToString(apartment.address);

                _apartmentDescription.text = apartment.description == null ||
                        apartment.description!.isEmpty
                    ? ""
                    : decodeUtf8ToString(apartment.description!);
                province = apartment.province;
                _apartmentSize.text = apartment.size.toString();
                _apartmentFloorNumberController.text =
                    apartment.apartmentFloorNumber != null
                        ? apartment.apartmentFloorNumber.toString()
                        : "";
                _apartmentNumberController.text =
                    apartment.apartmentNumber != null
                        ? apartment.apartmentNumber.toString()
                        : "";
                initlized = true;
              }
              return Scaffold(
                appBar: AppBar(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(1000),
                        bottomRight: Radius.circular(1000),
                      ),
                      side: BorderSide(width: 3, color: Colors.black)),
                  bottom: PreferredSize(
                      preferredSize: Size.fromHeight(20), child: SizedBox()),
                  backgroundColor:
                      Theme.of(context).appBarTheme.backgroundColor,
                  centerTitle: true,
                  shadowColor: Colors.black,
                  title: Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Text(
                        "edit-estate".i18n(),
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                body: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              "estate-name-constraint".i18n(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            CustomFormField(
                              labelText: "estate-name",
                              icon: const Icon(Icons.other_houses),
                              controller: _apartmentName,
                              type: TextInputType.name,
                              enterKeyAction: TextInputAction.done,
                              onValidation: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "required-field".i18n();
                                } else if (value.length > 35) {
                                  return "too-long".i18n();
                                }
                              },
                            ),
                            Text(
                              "province".i18n(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            DropdownButtonFormField<String>(
                              onChanged: (value) {
                                setState(() {
                                  province = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "required-field".i18n();
                                }
                              },
                              value: province,
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
                            Text(
                              "address-constraint".i18n(),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                            CustomFormField(
                              labelText: "address",
                              icon: const Icon(Icons.other_houses),
                              controller: _apartmentAddress,
                              type: TextInputType.name,
                              enterKeyAction: TextInputAction.done,
                              onValidation: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "required-field".i18n();
                                } else if (value.length > 35) {
                                  return "too-long".i18n();
                                }
                              },
                            ),
                            CustomFormField(
                              labelText: "size-in-square-meters".i18n(),
                              icon: const Icon(Icons.height),
                              controller: _apartmentSize,
                              type: TextInputType.number,
                              enterKeyAction: TextInputAction.done,
                              onValidation: (value) {
                                if (value == null || value!.isEmpty) {
                                  return "required-field".i18n();
                                } else {
                                  try {
                                    double.parse(value);
                                  } catch (e) {
                                    return "must-be-number".i18n();
                                  }
                                }
                              },
                            ),
                            CustomFormField(
                              minLines: 3,
                              maxLines: 5,
                              labelText: "description".i18n(),
                              icon: const Icon(Icons.description),
                              controller: _apartmentDescription,
                              type: TextInputType.multiline,
                              enterKeyAction: TextInputAction.done,
                              onValidation: (value) {
                                if (value == null ||
                                    value.trim().isNotEmpty &&
                                        value.length > 255) {
                                  return "too-long".i18n();
                                }
                              },
                            ),
                            CustomFormField(
                              labelText: "apartment-floor-number".i18n(),
                              icon: const Icon(Icons.elevator),
                              controller: _apartmentFloorNumberController,
                              type: TextInputType.number,
                              enterKeyAction: TextInputAction.done,
                              onValidation: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "required-field".i18n();
                                }
                                try {
                                  int.parse(value);
                                } catch (e) {
                                  return "must-be-number".i18n();
                                }
                              },
                            ),
                            CustomFormField(
                              labelText: "apartment-number".i18n(),
                              icon: const Icon(Icons.door_back_door),
                              controller: _apartmentNumberController,
                              type: TextInputType.number,
                              enterKeyAction: TextInputAction.done,
                              onValidation: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return "required-field".i18n();
                                }
                                try {
                                  int.parse(value);
                                } catch (e) {
                                  return "must-be-number".i18n();
                                }
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton.icon(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Center(
                                                  child: Text(
                                                    "confirm-password".i18n(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium,
                                                  ),
                                                ),
                                                content: SizedBox(
                                                  width: 450,
                                                  height: 250,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text("password".i18n()),
                                                      PasswordFormField(
                                                        controller:
                                                            _confirmPasswordId,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                var response = await HttpService.validateUser(
                                                                    decodeUtf8ToString(
                                                                        Provider.of<UserSession>(context, listen: false).username ??
                                                                            ""),
                                                                    _confirmPasswordId
                                                                        .text);
                                                                if (response
                                                                        .statusCode ==
                                                                    200) {
                                                                  // TODO: SEND ESTATE MODIFy
                                                                  ApartmentRegister
                                                                      newApartment =
                                                                      ApartmentRegister(
                                                                    name: _apartmentName
                                                                        .text,
                                                                    address:
                                                                        _apartmentAddress
                                                                            .text,
                                                                    type:
                                                                        "apartment",
                                                                    size: double.parse(
                                                                            _apartmentSize.text)
                                                                        .toInt(),
                                                                    province:
                                                                        province,
                                                                    apartmentFloorNumber:
                                                                        int.parse(
                                                                            _apartmentFloorNumberController.text),
                                                                    apartmentNumber:
                                                                        int.parse(
                                                                            _apartmentNumberController.text),
                                                                    description:
                                                                        _apartmentDescription
                                                                            .text,
                                                                  );

                                                                  var response = await HttpService.updateEstate(
                                                                      newApartment
                                                                          .toRawJson(),
                                                                      "apartment",
                                                                      id);
                                                                  if (response
                                                                          .statusCode ==
                                                                      200) {
                                                                    Navigator.pop(
                                                                        context);
                                                                    Navigator.pushNamed(
                                                                        context,
                                                                        "/mainpage");
                                                                  } else {
                                                                    ToastFactory.makeToast(
                                                                        context,
                                                                        TOAST_TYPE
                                                                            .error,
                                                                        null,
                                                                        "error"
                                                                            .i18n(),
                                                                        false,
                                                                        () {});
                                                                  }
                                                                } else {
                                                                  ToastFactory.makeToast(
                                                                      context,
                                                                      TOAST_TYPE
                                                                          .error,
                                                                      "error"
                                                                          .i18n(),
                                                                      Error.fromRawJson(
                                                                              response.body)
                                                                          .message
                                                                          .i18n(),
                                                                      false,
                                                                      () {});
                                                                }
                                                              },
                                                              child: const Icon(
                                                                  Icons.check),
                                                              style: ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all(Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .error)),
                                                            ),
                                                            OutlinedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Icon(
                                                                  Icons
                                                                      .cancel_outlined),
                                                              style: ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all(Theme.of(
                                                                          context)
                                                                      .colorScheme
                                                                      .primary)),
                                                            ),
                                                          ]),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      } else {
                                        ToastFactory.makeToast(
                                            context,
                                            TOAST_TYPE.error,
                                            "error".i18n(),
                                            "empty-fields".i18n(),
                                            false,
                                            () {});
                                      }
                                    },
                                    icon: const Icon(Icons.check),
                                    label: Text("confirm".i18n())),
                                ElevatedButton.icon(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: const Icon(Icons.cancel_outlined),
                                    label: Text("cancel".i18n())),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );
}
