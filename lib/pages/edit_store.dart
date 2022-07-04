// ignore_for_file: no_logic_in_create_state, must_be_immutable, prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/Widgets/UserInfoWidgets/passwordformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/etc/utils.dart';
import 'package:emtalik/models/error.dart';
import 'package:emtalik/models/store.dart';
import 'package:emtalik/models/store_register.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';

class EditStore extends StatefulWidget {
  EditStore({
    Key? key,
    required this.id,
  }) : super(key: key);
  int id;
  late String province;

  @override
  State<StatefulWidget> createState() => _EditStore(id: id);
}

class _EditStore extends State<EditStore> {
  _EditStore({
    required this.id,
  });

  int id;
  final _formKey = GlobalKey<FormState>();

  final _storeName = TextEditingController();
  final _storeAddress = TextEditingController();

  final _storeDescription = TextEditingController();
  final _storeSize = TextEditingController();
  final _confirmPasswordId = TextEditingController();
  final _storeFridges = TextEditingController();

  late String province;
  late Future<Store> store;
<<<<<<< HEAD
  final _numberOfFridgesController = TextEditingController();
  bool storageRoomIncluded = false;
=======

  bool _storageRoom = false;

  late bool initlized;
>>>>>>> d842e3739c81d65023b1c9cb3e55b816b56c53f9
  Future<Store> getEstate() async {
    var response = await HttpService.getEstateByTypeAndId("store", id);
    return Store.fromRawJson(response.body);
  }

  @override
  void initState() {
    initlized = false;
    super.initState();
    store = getEstate();
    province = "";
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: FutureBuilder(
          future: store,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                  appBar: AppBar(),
                  body: Center(child: CircularProgressIndicator()));
            } else {
              var store = snapshot.data as Store;
              if (initlized == false) {
                _storeName.text = decodeUtf8ToString(store.name);
                _storeAddress.text = decodeUtf8ToString(store.address);

                _storeDescription.text =
                    store.description == null || store.description!.isEmpty
                        ? ""
                        : decodeUtf8ToString(store.description!);
                province = store.province;
                _storeSize.text = store.size.toString();
                store.storageRoom != null && store.storageRoom!
                    ? _storageRoom = true
                    : _storageRoom = false;
                _storeFridges.text =
                    store.fridges != null ? store.fridges.toString() : "";
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
                              controller: _storeName,
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
                              controller: _storeAddress,
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
                              controller: _storeSize,
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
                              controller: _storeDescription,
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
                              labelText: "number-fridges".i18n(),
                              icon: const Icon(Icons.ac_unit),
                              controller: _storeFridges,
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
                                  value: _storageRoom,
                                  onChanged: (value) {
                                    setState(() {
                                      _storageRoom = value;
                                    });
                                  },
                                ),
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    Icon(_storageRoom
                                        ? Icons.warehouse
                                        : Icons.not_interested_outlined),
                                    const SizedBox(width: 2),
                                    Text(
                                      "storage-room".i18n(),
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
<<<<<<< HEAD
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
                                    CustomFormField(
                                      labelText: "number-fridges".i18n(),
                                      icon: const Icon(Icons.ac_unit),
                                      controller: _numberOfFridgesController,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Switch(
                                          value: storageRoomIncluded,
                                          onChanged: (value) {
                                            setState(() {
                                              storageRoomIncluded = value;
                                            });
                                          },
                                        ),
                                        Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Icon(storageRoomIncluded
                                                ? Icons.warehouse
                                                : Icons
                                                    .not_interested_outlined),
                                            const SizedBox(width: 2),
                                            Text(
                                              "storage-room".i18n(),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
=======
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
                                                                  StoreRegister
                                                                      newStore =
                                                                      StoreRegister(
                                                                    name: _storeName
                                                                        .text,
                                                                    address:
                                                                        _storeAddress
                                                                            .text,
                                                                    type:
                                                                        "store",
                                                                    size: double.parse(
                                                                            _storeSize.text)
                                                                        .toInt(),
                                                                    description:
                                                                        _storeDescription
                                                                            .text,
                                                                    fridges: int.parse(
                                                                        _storeFridges
                                                                            .text),
                                                                    storageRoom:
                                                                        _storageRoom,
                                                                    province:
                                                                        province,
                                                                  );

                                                                  var response = await HttpService.updateEstate(
                                                                      newStore
                                                                          .toRawJson(),
                                                                      "store",
                                                                      store.id);
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
>>>>>>> d842e3739c81d65023b1c9cb3e55b816b56c53f9
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
