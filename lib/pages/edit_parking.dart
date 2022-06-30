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

  final _parkingName = TextEditingController();
  final _parkingAddress = TextEditingController();

  final _parkingDescription = TextEditingController();
  final _parkingSize = TextEditingController();
  final _vehicleCapacityController = TextEditingController();

  late String province;
  bool _automobile = false;
  bool _bus = false;
  bool _bike = false;
  bool _truck = false;
  late Future<Parking> parking;

  late bool initlized;
  Future<Parking> getEstate() async {
    var response = await HttpService.getEstateByTypeAndId("parking", id);
    return Parking.fromRawJson(response.body);
  }

  @override
  void initState() {
    super.initState();
    initlized = false;
    province = "";
    parking = getEstate();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureBuilder(
          future: parking,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  appBar: AppBar(),
                  body: Center(child: CircularProgressIndicator()));
            } else {
              var parking = snapshot.data as Parking;
              if (!initlized) {
                _parkingName.text = decodeUtf8ToString(parking.name);
                _parkingAddress.text = decodeUtf8ToString(parking.address);

                _parkingDescription.text =
                    parking.description == null || parking.description!.isEmpty
                        ? ""
                        : decodeUtf8ToString(parking.description!);
                province = parking.province;
                _parkingSize.text = parking.size.toString();
                List<String> allowedVehicles = List.of(
                    parking.carsAllowd == null || parking.carsAllowd!.isEmpty
                        ? parking.carsAllowd!.split(",")
                        : List.empty(growable: true));
                _vehicleCapacityController.text =
                    parking.vehicleCapacity.toString();
                if (allowedVehicles.contains("automobile")) {
                  _automobile = true;
                }
                if (allowedVehicles.contains("bus")) {
                  _bus = true;
                }
                if (allowedVehicles.contains("bike")) {
                  _bike = true;
                }
                if (allowedVehicles.contains("truck")) {
                  _truck = true;
                }

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
                  child: Container(
                    margin: EdgeInsets.all(20),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Text(
                          "estate-name-constraint".i18n(),
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        CustomFormField(
                          labelText: "estate-name",
                          icon: const Icon(Icons.other_houses),
                          controller: _parkingName,
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
                          controller: _parkingAddress,
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
                          controller: _parkingSize,
                          type: TextInputType.number,
                          enterKeyAction: TextInputAction.done,
                          onValidation: (value) {
                            if (value == null || value!.isEmpty) {
                              return "required-field".i18n();
                            } else {
                              try {
                                int.parse(value);
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
                          controller: _parkingDescription,
                          type: TextInputType.multiline,
                          enterKeyAction: TextInputAction.done,
                          onValidation: (value) {
                            if (value == null ||
                                value.trim().isNotEmpty && value.length > 255) {
                              return "too-long".i18n();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        ),
      );
}
