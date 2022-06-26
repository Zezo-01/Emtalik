// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/estate_response.dart';
import 'package:emtalik/models/parking.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';

class EditParking extends StatefulWidget {
  EditParking({
    Key? key,
    required this.id,
  }) : super(key: key);
  int id;
  late String province;

  @override
  State<StatefulWidget> createState() => _EditParking(id: id);
}

class _EditParking extends State<EditParking> {
  _EditParking({
    required this.id,
  });

  int id;
  late String province;
  late Future<Parking> parking;
  bool _automobile = false;
  bool _bus = false;
  bool _truck = false;
  bool _bike = false;
  final _vehicleCapacityController = TextEditingController();

  Future<Parking> getEstate() async {
    var response = await HttpService.getEstateByTypeAndId("parking", id);
    return Parking.fromRawJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    parking = getEstate();
    province = "";
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureBuilder(
          future: parking,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              var parking = snapshot.data as Parking;
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
                        decodeUtf8ToString(parking.name),
                        style: Theme.of(context).textTheme.bodyMedium,
                      )),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10),
                        child: Image.network(
                          HttpService.getEstateMainPicture(parking.id),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: FaIcon(FontAwesomeIcons.city)),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 20, bottom: 5, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text("Enter New Name :-"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomFormField(labelText: "Enter New Name"),
                                ],
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: FaIcon(FontAwesomeIcons.ruler)),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 20, bottom: 5, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text("Enter New Address :-"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomFormField(
                                      labelText: "Enter New Address"),
                                ],
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: FaIcon(FontAwesomeIcons.squareParking)),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 20, bottom: 5, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text("Enter New Province :-"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  DropdownButtonFormField<String>(
                                    onChanged: (value) {
                                      setState(() {
                                        province = value!;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return "required-field".i18n();
                                      }
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
                                ],
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(
                                left: 20,
                              ),
                              child: FaIcon(FontAwesomeIcons.squareParking)),
                          Container(
                              margin:
                                  EdgeInsets.only(left: 20, bottom: 5, top: 10),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  Text("Enter New Size :-"),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  CustomFormField(labelText: "Enter New Size"),
                                ],
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              ElevatedButton.icon(
                                icon: Icon(Icons.save),
                                label: Text("save-changes".i18n()),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Theme.of(context).colorScheme.secondary),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text(
                                          "save-changes".i18n(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              child: Text(
                                                "estate-change-confirmation"
                                                    .i18n(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () async {
                                                    var response =
                                                        await HttpService
                                                            .deleteEstateById(
                                                                id);
                                                    if (response.statusCode ==
                                                        200) {
                                                      Navigator.pop(context);
                                                      Navigator.popAndPushNamed(
                                                          context, "mainpage");
                                                    } else {
                                                      Navigator.pop(context);
                                                      ToastFactory.makeToast(
                                                          context,
                                                          TOAST_TYPE.warning,
                                                          null,
                                                          "error".i18n(),
                                                          false,
                                                          () {});
                                                    }
                                                  },
                                                  child: Text("yes".i18n(),
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .error)),
                                                ),
                                                OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
                                                    "no".i18n(),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2,
                                                  ),
                                                  style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .all(Theme.of(
                                                                      context)
                                                                  .colorScheme
                                                                  .primary)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Form(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CheckboxListTile(
                                      title: Text("automobile".i18n()),
                                      secondary:
                                          const Icon(FontAwesomeIcons.car),
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                      value: _automobile,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            _automobile = value!;
                                          },
                                        );
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("bus".i18n()),
                                      secondary:
                                          const Icon(FontAwesomeIcons.bus),
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                      value: _bus,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            _bus = value!;
                                          },
                                        );
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("truck".i18n()),
                                      secondary:
                                          const Icon(FontAwesomeIcons.truck),
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                      value: _truck,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            _truck = value!;
                                          },
                                        );
                                      },
                                    ),
                                    CheckboxListTile(
                                      title: Text("bike".i18n()),
                                      secondary:
                                          const Icon(FontAwesomeIcons.bicycle),
                                      controlAffinity:
                                          ListTileControlAffinity.platform,
                                      value: _bike,
                                      onChanged: (value) {
                                        setState(
                                          () {
                                            _bike = value!;
                                          },
                                        );
                                      },
                                    ),
                                    CustomFormField(
                                      labelText: "vehicle-capacity".i18n(),
                                      icon:
                                          const Icon(Icons.car_repair_rounded),
                                      controller: _vehicleCapacityController,
                                      type: TextInputType.number,
                                      enterKeyAction: TextInputAction.done,
                                      onValidation: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "required-field".i18n();
                                        }
                                        try {
                                          int.parse(value);
                                        } catch (e) {
                                          return "must-be-number".i18n();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      );
  Future openDialop() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("save-changes?".i18n()),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding: EdgeInsets.all(10),
                      side: BorderSide(color: Colors.blue),
                      primary: Color.fromARGB(239, 253, 233, 199),
                      onPrimary: Colors.black),
                  onPressed: () {},
                  child: Text("yes".i18n())),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                      padding: EdgeInsets.all(10),
                      side: BorderSide(color: Colors.blue),
                      primary: Color.fromARGB(239, 253, 233, 199),
                      onPrimary: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("no".i18n())),
            ],
          ));
}
