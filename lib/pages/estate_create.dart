import 'dart:io';

import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:emtalik/etc/enums.dart';
import 'package:emtalik/etc/http_service.dart';
import 'package:emtalik/etc/toastfactory.dart';
import 'package:emtalik/models/apartment_register.dart';
import 'package:emtalik/models/house_register.dart';
import 'package:emtalik/models/land_register.dart';
import 'package:emtalik/models/parking_register.dart';
import 'package:emtalik/models/store_register.dart';
import 'package:emtalik/pages/mainpage.dart';
import 'package:emtalik/providers/user_session.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:localization/localization.dart';
import 'package:open_file/open_file.dart';
import 'package:provider/provider.dart';

class EstateCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EstateCreate();
}

class _EstateCreate extends State<EstateCreate> {
  final _generalForm = GlobalKey<FormState>();
  GlobalKey<FormState> _detailsOnForm = GlobalKey<FormState>();
  final _apartmentForm = GlobalKey<FormState>();
  final _houseForm = GlobalKey<FormState>();
  final _landForm = GlobalKey<FormState>();
  final _parkingForm = GlobalKey<FormState>();
  final _storeForm = GlobalKey<FormState>();
  final _detailsForm = GlobalKey<FormState>();

  final _estateNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sizeController = TextEditingController();
  final _apartmentFloorNumberController = TextEditingController();
  final _apartmentNumberController = TextEditingController();
  final _houseNumberOfFloorsController = TextEditingController();
  final _houseNumberOfRoomsController = TextEditingController();
  final _numberOfFridgesController = TextEditingController();
  final _vehicleCapacityController = TextEditingController();

  final _apartmentFloorNumber = FocusNode();
  final _apartmentNumber = FocusNode();
  final _addressNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _sizeNode = FocusNode();
  final _houseNumberOfFloors = FocusNode();
  final _houseNumberOfRooms = FocusNode();
  bool swimmingPoolIncluded = false;
  bool storageRoomIncluded = false;
  bool cityHallElectricitySupport = false;
  bool _automobile = false;
  bool _bus = false;
  bool _truck = false;
  bool _bike = false;
  XFile? estateMainImage;
  List<PlatformFile>? media;

  late String province;
  late String estateType;
  late int currentStep;
  @override
  void initState() {
    province = "";
    currentStep = 0;
    estateType = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Stepper(
            type: StepperType.horizontal,
            currentStep: currentStep,
            steps: <Step>[
              Step(
                state: currentStep > 0 ? StepState.complete : StepState.indexed,
                isActive: currentStep >= 0,
                title: Text(
                  "general".i18n(),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 12),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Form(
                      key: _generalForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "estate-name-constraint".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 10),
                          CustomFormField(
                            labelText: "estate-name",
                            icon: const Icon(Icons.other_houses),
                            controller: _estateNameController,
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
                          DropdownButtonFormField<String>(
                            hint: Text("pick-estate-type".i18n()),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "required-field".i18n();
                              }
                            },
                            onChanged: (value) {
                              setState(() {
                                estateType = value!;
                                switch (value) {
                                  case "apartment":
                                    {
                                      _detailsOnForm = _apartmentForm;
                                      break;
                                    }
                                  case "house":
                                    {
                                      _detailsOnForm = _houseForm;
                                      break;
                                    }
                                  case "parking":
                                    {
                                      _detailsOnForm = _parkingForm;
                                      break;
                                    }
                                  case "store":
                                    {
                                      _detailsOnForm = _storeForm;
                                      break;
                                    }
                                  case "land":
                                    {
                                      _detailsOnForm = _landForm;
                                      break;
                                    }
                                }
                              });
                            },
                            items: <DropdownMenuItem<String>>[
                              DropdownMenuItem(
                                value: "parking",
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("parking".i18n()),
                                    const Icon(Icons.local_parking),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "house",
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("house".i18n()),
                                    const Icon(Icons.house),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "apartment",
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("apartment".i18n()),
                                    const Icon(Icons.apartment),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "store",
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("store".i18n()),
                                    const Icon(Icons.store),
                                  ],
                                ),
                              ),
                              DropdownMenuItem(
                                value: "land",
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                    ),
                  ),
                ),
              ),
              Step(
                title: Text(
                  "details-on".i18n() +
                      (_estateNameController.text.length > 12
                          ? ""
                          : _estateNameController.text),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 12),
                ),
                content: SingleChildScrollView(
                  child: Container(
                      margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: estateType == "apartment"
                          ? Form(
                              key: _apartmentForm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomFormField(
                                    focusNode: _apartmentFloorNumber,
                                    onComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(_apartmentNumber);
                                    },
                                    labelText: "apartment-floor-number".i18n(),
                                    icon: const Icon(Icons.elevator),
                                    controller: _apartmentFloorNumberController,
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
                                  CustomFormField(
                                    focusNode: _apartmentNumber,
                                    labelText: "apartment-number".i18n(),
                                    icon: const Icon(Icons.door_back_door),
                                    controller: _apartmentNumberController,
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
                          : estateType == "house"
                              ? Form(
                                  key: _houseForm,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      CustomFormField(
                                        focusNode: _houseNumberOfFloors,
                                        onComplete: () {
                                          FocusScope.of(context).requestFocus(
                                              _houseNumberOfRooms);
                                        },
                                        labelText: "house-number-floors".i18n(),
                                        icon: const Icon(
                                            Icons.format_list_numbered),
                                        controller:
                                            _houseNumberOfFloorsController,
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
                                      CustomFormField(
                                        focusNode: _houseNumberOfRooms,
                                        labelText: "house-number-rooms".i18n(),
                                        icon: const Icon(Icons.meeting_room),
                                        controller:
                                            _houseNumberOfRoomsController,
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
                                            value: swimmingPoolIncluded,
                                            onChanged: (value) {
                                              setState(() {
                                                swimmingPoolIncluded = value;
                                              });
                                            },
                                          ),
                                          Wrap(
                                            crossAxisAlignment:
                                                WrapCrossAlignment.center,
                                            children: [
                                              Icon(swimmingPoolIncluded
                                                  ? Icons.pool
                                                  : Icons
                                                      .not_interested_outlined),
                                              const SizedBox(width: 2),
                                              Text(
                                                "swimming-pool".i18n(),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              : estateType == "store"
                                  ? Form(
                                      key: _storeForm,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          CustomFormField(
                                            labelText: "number-fridges".i18n(),
                                            icon: const Icon(Icons.ac_unit),
                                            controller:
                                                _numberOfFridgesController,
                                            type: TextInputType.number,
                                            enterKeyAction:
                                                TextInputAction.done,
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
                                  : estateType == "parking"
                                      ? Form(
                                          key: _parkingForm,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CheckboxListTile(
                                                title:
                                                    Text("automobile".i18n()),
                                                secondary: const Icon(
                                                    FontAwesomeIcons.car),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .platform,
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
                                                secondary: const Icon(
                                                    FontAwesomeIcons.bus),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .platform,
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
                                                secondary: const Icon(
                                                    FontAwesomeIcons.truck),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .platform,
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
                                                secondary: const Icon(
                                                    FontAwesomeIcons.bicycle),
                                                controlAffinity:
                                                    ListTileControlAffinity
                                                        .platform,
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
                                                labelText:
                                                    "vehicle-capacity".i18n(),
                                                icon: const Icon(
                                                    Icons.car_repair_rounded),
                                                controller:
                                                    _vehicleCapacityController,
                                                type: TextInputType.number,
                                                enterKeyAction:
                                                    TextInputAction.done,
                                                onValidation: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
                                                    return "required-field"
                                                        .i18n();
                                                  }
                                                  try {
                                                    int.parse(value);
                                                  } catch (e) {
                                                    return "must-be-number"
                                                        .i18n();
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        )
                                      : estateType == "land"
                                          ? Form(
                                              key: _landForm,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Switch(
                                                        value:
                                                            cityHallElectricitySupport,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            cityHallElectricitySupport =
                                                                value;
                                                          });
                                                        },
                                                      ),
                                                      Wrap(
                                                        crossAxisAlignment:
                                                            WrapCrossAlignment
                                                                .center,
                                                        children: [
                                                          Icon(cityHallElectricitySupport
                                                              ? Icons.power
                                                              : Icons
                                                                  .power_off),
                                                          const SizedBox(
                                                              width: 2),
                                                          Text(
                                                            "electric-support"
                                                                .i18n(),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            )
                                          : null),
                ),
              ),
              Step(
                title: Text(
                  "extra-details".i18n(),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 12),
                ),
                content: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Form(
                      key: _detailsForm,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
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
                          const SizedBox(height: 10),
                          Text(
                            "address-constraint".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall!
                                .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                          ),
                          const SizedBox(height: 10),
                          CustomFormField(
                            focusNode: _addressNode,
                            onComplete: () {
                              FocusScope.of(context)
                                  .requestFocus(_descriptionNode);
                            },
                            labelText: "address".i18n(),
                            icon: const Icon(Icons.location_on),
                            controller: _addressController,
                            type: TextInputType.name,
                            enterKeyAction: TextInputAction.done,
                            onValidation: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "required-field".i18n();
                              } else if (value.length > 45) {
                                return "too-long".i18n();
                              }
                            },
                          ),
                          CustomFormField(
                            focusNode: _sizeNode,
                            labelText: "size-in-square-meters".i18n(),
                            icon: const Icon(Icons.height),
                            controller: _sizeController,
                            type: TextInputType.number,
                            enterKeyAction: TextInputAction.done,
                            onValidation: (value) {
                              if (estateType == "land" && value == null ||
                                  value!.isEmpty) {
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
                            focusNode: _descriptionNode,
                            onComplete: () {
                              FocusScope.of(context).requestFocus(_sizeNode);
                            },
                            labelText: "description".i18n(),
                            icon: const Icon(Icons.description),
                            controller: _descriptionController,
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
                          Text(
                            "pick-estate-main-image".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12),
                          ),
                          IconButton(
                            iconSize: 50,
                            icon: const Icon(Icons.image_search),
                            onPressed: () async {
                              try {
                                final userImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                if (userImage != null &&
                                    (userImage.name.split('.')[1] == "jpeg" ||
                                        userImage.name.split('.')[1] == "jpg" ||
                                        userImage.name.split('.')[1] == "png" ||
                                        userImage.name.split('.')[1] ==
                                            "webp")) {
                                  if (await userImage.length() < 5 * 1000000) {
                                    setState(() {
                                      estateMainImage = userImage;
                                    });
                                  } else {
                                    ToastFactory.makeToast(
                                        context,
                                        TOAST_TYPE.error,
                                        "file-size-error".i18n(),
                                        "profile-picture-constraint".i18n(),
                                        false,
                                        () {});
                                    setState(() {
                                      estateMainImage = null;
                                    });
                                  }
                                } else {
                                  ToastFactory.makeToast(
                                      context,
                                      TOAST_TYPE.error,
                                      null,
                                      "not-supported-file".i18n(),
                                      false,
                                      () {});
                                  setState(() {
                                    estateMainImage = null;
                                  });
                                }
                              } on PlatformException catch (e) {
                                estateMainImage = null;
                                ToastFactory.makeToast(
                                    context,
                                    TOAST_TYPE.error,
                                    "Error",
                                    "Cant Pick Up Image",
                                    false,
                                    () {});
                              }
                            },
                          ),
                          if (estateMainImage != null)
                            Wrap(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      estateMainImage = null;
                                    });
                                  },
                                  icon: const Icon(Icons.cancel),
                                ),
                                CircleAvatar(
                                  child: ClipOval(
                                    child: Image.file(
                                      File(estateMainImage!.path),
                                      height:
                                          MediaQuery.of(context).size.height,
                                      width: MediaQuery.of(context).size.width,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  radius: 120,
                                ),
                              ],
                            ),
                          Text(
                            "pick-estate-media".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontSize: 12),
                          ),
                          IconButton(
                            icon: const Icon(Icons.perm_media),
                            iconSize: 50,
                            onPressed: () async {
                              FilePickerResult? pickedMedia =
                                  await FilePicker.platform.pickFiles(
                                allowMultiple: true,
                                allowedExtensions: [
                                  'mp4',
                                  'jpg',
                                  'jpeg',
                                  'png'
                                ],
                                type: FileType.custom,
                              );

                              if (pickedMedia == null) {
                                return;
                              } else if (pickedMedia.count < 3) {
                                ToastFactory.makeToast(
                                    context,
                                    TOAST_TYPE.warning,
                                    null,
                                    "atleast-3".i18n(),
                                    false,
                                    () {});
                                return;
                              } else {
                                int allMediaSizes = 0;
                                int maxSize = 0;

                                pickedMedia.files.forEach((file) {
                                  allMediaSizes += file.size;
                                  file.size > maxSize
                                      ? maxSize = file.size
                                      : maxSize = maxSize;
                                });

                                try {
                                  while (allMediaSizes > (250 * 1000000)) {
                                    pickedMedia.files.removeWhere(
                                      (file) {
                                        if (file.size == maxSize ||
                                            file.size >= (250 * 1000000)) {
                                          allMediaSizes -= file.size;

                                          maxSize = 0;
                                          pickedMedia.files.forEach((file) {
                                            file.size > maxSize
                                                ? maxSize = file.size
                                                : maxSize = maxSize;
                                          });

                                          return true;
                                        } else {
                                          return false;
                                        }
                                      },
                                    );
                                  }
                                } catch (e) {
                                  ToastFactory.makeToast(
                                      context,
                                      TOAST_TYPE.warning,
                                      "files-removed".i18n(),
                                      "unsupported-files-selected".i18n(),
                                      false,
                                      () {});
                                }

                                if (pickedMedia.files.length < 3) {
                                  ToastFactory.makeToast(
                                    context,
                                    TOAST_TYPE.warning,
                                    "files-removed".i18n(),
                                    "unsupported-files-selected".i18n(),
                                    false,
                                    () {},
                                  );
                                } else {
                                  setState(() {
                                    media = pickedMedia.files;
                                  });
                                }
                              }
                            },
                          ),
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 25,
                            ),
                            shrinkWrap: true,
                            itemCount: media == null ? 0 : media!.length,
                            itemBuilder: (context, index) => Wrap(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      media!.removeAt(index);
                                    });
                                  },
                                  icon: const Icon(Icons.cancel),
                                ),
                                InkWell(
                                  onTap: () {
                                    OpenFile.open(media![index].path);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Text(
                                            media![index].extension == "mp4"
                                                ? "video".i18n()
                                                : "image".i18n(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelMedium,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          media![index].name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                        Text(
                                          (media![index].size > 1024 * 1000)
                                              ? (media![index].size / 1000000)
                                                      .toString() +
                                                  " MB"
                                              : (media![index].size / 1000)
                                                      .toString() +
                                                  " KB",
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 50),
                          Text(
                            "estate-media-constraint".i18n(),
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    fontSize: 10, fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            onStepCancel: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: ((context) => MyHomePage())));
            },
            onStepContinue: () async {
              if (currentStep == 0) {
                if (_generalForm.currentState!.validate()) {
                  setState(() {
                    currentStep++;
                  });
                }
              } else if (currentStep == 1) {
                if (_detailsOnForm.currentState!.validate()) {
                  setState(() {
                    currentStep++;
                  });
                }
              } else if (currentStep == 2) {
                if (_detailsForm.currentState!.validate()) {
                  if (estateMainImage == null) {
                    ToastFactory.makeToast(context, TOAST_TYPE.error, null,
                        "image-required".i18n(), false, () {});
                  }
                  if (media == null || media!.length < 3) {
                    ToastFactory.makeToast(context, TOAST_TYPE.error, null,
                        "atleast-3".i18n(), false, () {});
                  } else {
                    var estate;
                    // SEND REQUEST TO SERVER
                    switch (estateType) {
                      case 'house':
                        {
                          estate = HouseRegister(
                              name: _estateNameController.text,
                              address: _addressController.text,
                              type: estateType,
                              description: _descriptionController.text.isEmpty
                                  ? null
                                  : _descriptionController.text,
                              size: int.parse(_sizeController.text),
                              numberOfFloors: int.parse(
                                  _houseNumberOfFloorsController.text),
                              rooms:
                                  int.parse(_houseNumberOfRoomsController.text),
                              swimmingPool: swimmingPoolIncluded,
                              province: province);
                          break;
                        }
                      case 'apartment':
                        {
                          estate = ApartmentRegister(
                            name: _estateNameController.text,
                            address: _addressController.text,
                            type: estateType,
                            description: _descriptionController.text.isEmpty
                                ? null
                                : _descriptionController.text,
                            size: int.parse(_sizeController.text),
                            apartmentFloorNumber:
                                int.parse(_apartmentFloorNumberController.text),
                            apartmentNumber:
                                int.parse(_apartmentNumberController.text),
                            province: province,
                          );
                          break;
                        }
                      case 'parking':
                        {
                          List<String> carsAllowed = List.empty(growable: true);
                          if (_automobile) {
                            carsAllowed.add("automobile");
                          }
                          if (_bike) {
                            carsAllowed.add("bike");
                          }
                          if (_bus) {
                            carsAllowed.add("bus");
                          }
                          if (_truck) {
                            carsAllowed.add("truck");
                          }
                          estate = ParkingRegister(
                            name: _estateNameController.text,
                            address: _addressController.text,
                            type: estateType,
                            size: int.parse(_sizeController.text),
                            description: _descriptionController.text,
                            vehicleCapacity:
                                int.parse(_vehicleCapacityController.text),
                            carsAllowed: carsAllowed,
                            province: province,
                          );
                          break;
                        }
                      case 'land':
                        {
                          estate = LandRegister(
                            name: _estateNameController.text,
                            address: _addressController.text,
                            type: estateType,
                            size: int.parse(_sizeController.text),
                            description: _descriptionController.text,
                            cityHallElectricitySupport:
                                cityHallElectricitySupport,
                            province: province,
                          );
                          break;
                        }
                      case 'store':
                        {
                          estate = StoreRegister(
                            name: _estateNameController.text,
                            address: _addressController.text,
                            type: estateType,
                            size: int.parse(_sizeController.text),
                            description: _descriptionController.text,
                            fridges: int.parse(_numberOfFridgesController.text),
                            storageRoom: storageRoomIncluded,
                            province: province,
                          );
                          break;
                        }
                    }
                    try {
                      var request = await HttpService.createEstate(
                          estate,
                          estateType,
                          Provider.of<UserSession>(context, listen: false).id ??
                              0,
                          estateMainImage,
                          media);
                      if (request.statusCode == 200) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: ((context) => MyHomePage())));
                      } else {
                        ToastFactory.makeToast(context, TOAST_TYPE.error, null,
                            "error".i18n(), false, () {});
                      }
                    } catch (e, s) {
                      ToastFactory.makeToast(context, TOAST_TYPE.error, null,
                          "no-connection".i18n(), false, () {});
                    }
                  }
                }
              }
            },
            onStepTapped: (step) {
              if (currentStep == 0) {
                if (_generalForm.currentState!.validate()) {
                  setState(() {
                    currentStep = step;
                  });
                }
              } else if (currentStep == 1) {
                if (_detailsOnForm.currentState!.validate()) {
                  setState(() {
                    currentStep = step;
                  });
                }
              } else if (currentStep == 2) {
                setState(() {
                  currentStep = step;
                });
              }
            },
          ),
        ),
      ),
    );
  }
}
