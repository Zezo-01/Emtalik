import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class EstateCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EstateCreate();
}

class _EstateCreate extends State<EstateCreate> {
  final _generalForm = GlobalKey<FormState>();
  final _detailsOnForm = GlobalKey<FormState>();
  final _detailsForm = GlobalKey<FormState>();

  final _estateNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sizeController = TextEditingController();

  final _addressNode = FocusNode();
  final _descriptionNode = FocusNode();
  final _sizeNode = FocusNode();

  late String estateType;
  late int currentStep;
  late List<GlobalKey<FormState>> formKeys;
  @override
  void initState() {
    currentStep = 0;
    estateType = "";
    formKeys = [
      _generalForm,
      _detailsOnForm,
      _detailsForm,
    ];
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
                          // TODO: IMPLEMETNT DROP DOWN MENU
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
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (estateType == "apartment")
                            Text("apartment".i18n())
                          else if (estateType == "house")
                            Text("house".i18n())
                          else if (estateType == "store")
                            Text("store".i18n())
                          else if (estateType == "parking")
                            Text("parking".i18n())
                          else if (estateType == "land")
                            Text("land".i18n())
                        ],
                      ),
                    ),
                  ),
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
              if (formKeys[currentStep].currentState!.validate()) {
                setState(() {
                  currentStep++;
                });
              }
            },
            onStepTapped: (step) {
              // TODO: REQUIRED VALIDATION
              if (formKeys[currentStep].currentState!.validate()) {
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
