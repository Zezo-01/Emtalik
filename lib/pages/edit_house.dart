// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, unnecessary_import

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/error.dart';
import 'package:emtalik/models/house.dart';
import 'package:emtalik/models/house_register.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class EditHouse extends StatefulWidget {
  EditHouse({
    Key? key,
    required this.id,
  }) : super(key: key);
  int id;

  @override
  State<StatefulWidget> createState() => _EditHouse(id: id);
}

class _EditHouse extends State<EditHouse> {
  _EditHouse({
    required this.id,
  });

  int id;
  final _formKey = GlobalKey<FormState>();

  final _houseName = TextEditingController();
  final _houseAddress = TextEditingController();

  final _houseDescription = TextEditingController();
  final _houseSize = TextEditingController();

  final _houseRooms = TextEditingController();
  final _houseFloors = TextEditingController();

  final _confirmPasswordId = TextEditingController();

  bool _swimmingPool = false;

  late String province;
  late Future<House> house;

  late bool initlized;
  Future<House> getEstate() async {
    var response = await HttpService.getEstateByTypeAndId("house", id);
    return House.fromRawJson(response.body);
  }

  @override
  void initState() {
    initlized = false;
    super.initState();
    house = getEstate();
    province = "";
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureBuilder(
          future: house,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  appBar: AppBar(),
                  body: Center(child: CircularProgressIndicator()));
            } else {
              var house = snapshot.data as House;
              if (initlized == false) {
                _houseName.text = decodeUtf8ToString(house.name);
                _houseAddress.text = decodeUtf8ToString(house.address);

                _houseDescription.text =
                    house.description == null || house.description!.isEmpty
                        ? ""
                        : decodeUtf8ToString(house.description!);
                province = house.province;
                _houseSize.text = house.size.toString();

                _houseRooms.text =
                    house.rooms != null ? house.rooms.toString() : "";

                _houseFloors.text = house.numberOfFloors != null
                    ? house.numberOfFloors.toString()
                    : "";

                _swimmingPool =
                    house.swimmingPool != null ? house.swimmingPool! : false;

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
                              controller: _houseName,
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
                              controller: _houseAddress,
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
                              controller: _houseSize,
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
                              controller: _houseDescription,
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
                              labelText: "house-number-floors".i18n(),
                              icon: const Icon(Icons.format_list_numbered),
                              controller: _houseFloors,
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
                              labelText: "house-number-rooms".i18n(),
                              icon: const Icon(Icons.meeting_room),
                              controller: _houseRooms,
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
                                Switch(
                                  value: _swimmingPool,
                                  onChanged: (value) {
                                    setState(() {
                                      _swimmingPool = value;
                                    });
                                  },
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(_swimmingPool
                                        ? Icons.pool
                                        : Icons.not_interested_outlined),
                                    const SizedBox(width: 2),
                                    Text(
                                      "swimming-pool".i18n(),
                                    ),
                                  ],
                                ),
                              ],
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
                                                                  HouseRegister newHouse = HouseRegister(
                                                                      name: _houseName
                                                                          .text,
                                                                      address:
                                                                          _houseAddress
                                                                              .text,
                                                                      type:
                                                                          "house",
                                                                      size: int.parse(
                                                                          _houseSize
                                                                              .text),
                                                                      province:
                                                                          province,
                                                                      description:
                                                                          _houseDescription
                                                                              .text,
                                                                      numberOfFloors:
                                                                          int.parse(_houseFloors
                                                                              .text),
                                                                      rooms: int.parse(
                                                                          _houseRooms
                                                                              .text),
                                                                      swimmingPool:
                                                                          _swimmingPool);
                                                                  var response =
                                                                      await HttpService.updateEstate(
                                                                          newHouse
                                                                              .toRawJson(),
                                                                          "house",
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
