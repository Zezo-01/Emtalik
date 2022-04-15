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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 90),
              Text(
                "Text Theme Body Text 1",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              Text(
                "Text Theme Body Text 2",
                style: Theme.of(context).textTheme.bodyText2,
              ),
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
                "Text Theme Button",
                style: Theme.of(context).textTheme.button,
              ),
              Text(
                "Text Theme Body Caption",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                "Text Theme Display Large",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Display Medium",
                style: Theme.of(context).textTheme.displayMedium,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Display Small",
                style: Theme.of(context).textTheme.displaySmall,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line 1",
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line 2",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line 3",
                style: Theme.of(context).textTheme.headline3,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line 4",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line 5",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.center,
              ),
              Text(
                "Text Theme Head Line 6",
                style: Theme.of(context).textTheme.headline6,
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
                "Text Theme Overline",
                style: Theme.of(context).textTheme.overline,
              ),
              Text(
                "Text Theme Overline",
                style: Theme.of(context).textTheme.overline,
              ),
              Text(
                "Text Theme Subtitle 1",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                "Text Theme Subtitle 2",
                style: Theme.of(context).textTheme.subtitle2,
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
