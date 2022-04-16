import 'package:flutter/material.dart';

/*
*                                       This Sanbox is used for TextStyle types and definding
*                                            You define the TextStyle in lib/etc/appenv.dart
*                                                   In AppEnv class
*/
class SandBoxText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              Text(
                "Text Theme Body Large",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Text(
                "Text Theme Body Medium",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Text(
                "Text Theme Body Small",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              Text(
                "Emtalik",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                "Medium",
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                "Small",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line Large",
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line Medium",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line Small",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Text(
                "Text Theme Label Large",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              Text(
                "Text Theme Label Medium",
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                "Text Theme Label Small",
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                "Text Theme Title Large",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Text(
                "Text Theme Title Medium",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "Text Theme Title Small",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 90),
            ],
          ),
        ),
      ),
    );
  }
}
