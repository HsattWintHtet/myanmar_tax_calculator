import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutUsFragment extends StatelessWidget {

  AboutUsFragment();


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body1;
    final TextStyle linkStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);


    return Center(
      child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(20.0),
          children: <Widget>[
            RichText(
              text: TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    style: aboutTextStyle,
                    text: """
KYAW SWAR AUNG
Senior Software Developer
Email: kyawswaaung87@gmail.com

အခွန်တွက်ပုံများကို Internal Revenue Department Myanmar(https://www.ird.gov.mm/my) မှကူးယူမှီညမ်းထားခြင်းဖြစ်ပါသည်။

Any issues? Any Error? please contact me.
အကြံပြုလိုပါက ‌အထက်ပါ email သို့ဆက်သွယ်နိင်ပါသည်။

I used some logo from this free websites https://icon-icons.com/


                    """,
                  ),
                ],
              ),
            ),
          ]
      ),
    );
  }

}

class _LinkTextSpan extends TextSpan {

  // Beware!
  //
  // This class is only safe because the TapGestureRecognizer is not
  // given a deadline and therefore never allocates any resources.
  //
  // In any other situation -- setting a deadline, using any of the less trivial
  // recognizers, etc -- you would have to manage the gesture recognizer's
  // lifetime and call dispose() when the TextSpan was no longer being rendered.
  //
  // Since TextSpan itself is @immutable, this means that you would have to
  // manage the recognizer from outside the TextSpan, e.g. in the State of a
  // stateful widget that then hands the recognizer to the TextSpan.

  _LinkTextSpan({ TextStyle style, String url, String text }) : super(
      style: style,
      text: text ?? url,
      recognizer: TapGestureRecognizer()..onTap = () {
        launch(url, forceSafariVC: false);
      }
  );
}