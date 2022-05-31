import 'package:emtalik/Widgets/UserInfoWidgets/customformfield.dart';
import 'package:flutter/material.dart';
import 'package:localization/localization.dart';

class EstateCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EstateCreate();
}

class _EstateCreate extends State<EstateCreate> {
  final firstForm = GlobalKey<FormState>();

  final estateNameController = TextEditingController();

  final estateNameNode = FocusNode();

  int currentStep = 0;

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
                title: Text(
                  "general".i18n(),
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall!
                      .copyWith(fontSize: 14),
                ),
                content: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Form(
                      key: firstForm,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomFormField(
                            focusNode: estateNameNode,
                            labelText: "estate-name",
                            icon: const Icon(Icons.other_houses),
                            controller: estateNameController,
                            type: TextInputType.name,
                            enterKeyAction: TextInputAction.done,
                            onValidation: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "required-field".i18n();
                              } else if (value.length > 35) {
                                return "too-long".i18n();
                              }
                              // TODO: IMPLEMETNT DROP DOWN MENU
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
                if (firstForm.currentState!.validate()) {
                  setState(() {
                    currentStep++;
                  });
                }
              }
            },
            onStepTapped: (step) {
              // TODO: REQUIRED VALIDATION
              setState(() {
                currentStep = step;
              });
            },
          ),
        ),
      ),
    );
  }
}
