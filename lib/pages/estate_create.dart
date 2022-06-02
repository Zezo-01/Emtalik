import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

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

  late String estateType;
  late int currentStep;
  @override
  void initState() {
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
                      .copyWith(fontSize: 14),
                ),
                content: SingleChildScrollView(
                  // padding: EdgeInsets.only(
                  //     bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  "details-on".i18n() + _estateNameController.value.text,
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 12),
                ),
                content: SingleChildScrollView(
                  // padding: EdgeInsets.only(
                  //     bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                                      ? Icons
                                                          .door_sliding_rounded
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
                                  // TODO: THIS IS LEFT NEEDS CHECK BOXES
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
                                                    Icons.car_repair),
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
                                                secondary:
                                                    const Icon(Icons.bus_alert),
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
                                                    Icons.car_repair),
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
                                                            "storage-room"
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
                  // padding: EdgeInsets.only(
                  //     bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Form(
                      key: _detailsForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
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
                            focusNode: _descriptionNode,
                            onComplete: () {
                              FocusScope.of(context).requestFocus(_sizeNode);
                            },
                            labelText: "description".i18n(),
                            icon: const Icon(Icons.description),
                            controller: _descriptionController,
                            type: TextInputType.name,
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
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
            onStepCancel: () {
              Navigator.of(context).pushNamed('/mainpage');
            },
            onStepContinue: () {
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
              } else if (currentStep == 1) {
                if (_detailsForm.currentState!.validate()) {
                  setState(() {
                    currentStep++;
                  });
                }
              }
            },
            onStepTapped: (step) {
              if (currentStep == 0) {
                if (_generalForm.currentState!.validate()) {
                  setState(() {
                    currentStep = step;
                  });
                } else if (currentStep == 1 && step != 0) {
                  if (_detailsOnForm.currentState!.validate()) {
                    setState(() {
                      currentStep = step;
                    });
                  } else {
                    setState(() {
                      currentStep = step;
                    });
                  }
                } else if (currentStep == 2) {
                  setState(() {
                    currentStep = step;
                  });
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
