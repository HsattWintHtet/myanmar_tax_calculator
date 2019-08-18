import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class AboutUsFragment extends StatelessWidget {

  AboutUsFragment();


  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    final TextStyle aboutTextStyle = themeData.textTheme.body2;
    final TextStyle linkStyle = themeData.textTheme.body2.copyWith(color: themeData.accentColor);


    return  ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(20.0),
        children: <Widget>[
          RichText(
            text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                  style: themeData.textTheme.body2.copyWith(color: Colors.black,fontSize: 18),
                  text: """ပြည်တွင်းအခွန်များဦးစီးဌာန နောက်ခံသမိုင်း""",
                ),
                TextSpan(
                  style: aboutTextStyle,
                  text: """
            

၁။      ပြည်ထောင်စုမြန်မာနိုင်ငံတွင် တည်ရှိနေသောအုပ်ချုပ်ရေးစနစ်သည် အခြေခံအားဖြင့် ဗြိတိ သျှကိုလိုနီဘဝတွင် မြန်မာနိုင်ငံ၌တပ်ဆင်ခဲ့သော အုပ်ချုပ်ရေးစနစ်ကို အနည်းငယ် ပြုပြင်ထား သည့် စနစ်သာဖြစ်ရာ ပြည်ထောင်စုမြန်မာနိုင်ငံတော်၏ အကျိုး၊ တိုင်းရင်းသား ပြည်သူများ၏ အကျိုးကို ထိရောက်စွာ မသယ်ပိုး မဆောင်ရွက်နိုင်၍ ယင်းသို့ဆောင်ရွက်စိမ့်သောငှာ အုပ်ချုပ်ရေး စနစ်သစ်ကို ဖော်ထုတ်ရန် လိုအပ်လျက်ရှိနေသဖြင့် တော်လှန်ရေးကောင်စီသည် အုပ်ချုပ်ရေး ယန္တရားကို ပြန်လည်ဖွဲ့စည်းရန် လုပ်ကိုင်ပုံနည်းစနစ်များကို အသစ်ပြဌာန်းကြောင်း  ၁၉၇၂ ခုနှစ်၊ မတ်လ (၁၅) ရက်နေ့ပါ အမိန်ကြော်ငြာစာအမှတ်(၉၇)ကို ထုတ်ပြန်ခဲ့ပါသည်။

၂။      ၎င်းအမိန့်ကြော်ငြာစာအမှတ် (၉၇) အရ စီမံကိန်းနှင့် ဘဏ္ဍာရေးဝန်ကြီးဌာနသည် ယင်း အုပ်ချုပ်ရေးစနစ်သစ် ဖော်ထုတ်ရေးအစီအစဉ်အရ ယခင်က သီးခြားစီရှိခဲ့သော အမြတ်ခွန်ဌာန၊ ကုန်သွယ်လုပ်ငန်းခွန်ဌာန၊ ယစ်မျိုးခွန်ဌာန၊ အောင်ဘာလေသိန်းဆုခွန်ဌာန၊ တံဆိပ်ခေါင်းခွန်ဌာန၊ အထွေထွေအုပ်ချုပ်ရေးဦးစီးဌာနမှ အခွန်ဌာနနှင့် ဘဏ္ဍာတော် မင်းကြီးရုံးတို့ ပူးပေါင်း၍ အခွန် အရပ်ရပ် စည်းကြပ်ကောက်ခံမှုဆိုင်ရာ လုပ်ငန်း တာဝန်များကို ဌာနတစ်ခုတည်းက လွဲပြောင်း တာဝန်ယူဆောင်ရွက်နိုင်ရန်အတွက် (၁-၁၀-၁၉၇၂) ရက်နေ့တွင် ပြည်တွင်းအခွန်များဦးစီးဌာနကို စတင် ဖွဲ့စည်းခဲ့ပါသည်။

၃။      စတင်ဖွင့်လှစ်ခဲ့သော ရုံးများမှာ ပြည်တွင်းအခွန်များဦးစီးဌာန(ရုံးချုပ်) (၁)ရုံး၊ ဌာနခွဲ (၆)ရုံး၊ ပြည်နယ်/တိုင်းဒေသကြီးရုံးများ (၁၄)ရုံး၊ မြို့နယ်ရုံးများ (၂၅၀)ရုံး၊ စုစုပေါင်း (၂၇၁)ရုံး ဖြစ်ပြီး ရုံးချုပ်ကို ရန်ကုန်မြို့တွင်ဖွင့်လှစ်ခဲ့ပါသည်။ ဖွဲ့စည်းစဉ်က ဦးစီးဌာန၏ အကြီးအကဲ ရာထူးကို ဥက္ကဋ္ဌအမည်ဖြင့် ရှိခဲ့ပါသည်။ နောင်တွင် ညွှန်ကြားရေးမှူးချုပ် အမည်ဖြင့် ပြောင်းလဲ ခဲ့ပါသည်။ ထိုသို့ စတင်ဖွဲ့စည်းခဲ့စဉ်က ပြည်တွင်းအခွန်များဦးစီးဌာနက ကောက်ခံသော အခွန် (၁၀) မျိုးရှိခဲ့ပါသည်။ ထိုအခွန်များ မှာ ဝင်ငွေခွန်၊ အမြတ်ခွန်၊ ကုန်သွယ်လုပ်ငန်းခွန်၊ ယစ်မျိုးခွန်၊ အောင်ဘာလေသိန်းဆုခွန်၊ တံဆိပ်ခေါင်းခွန်၊ မြေခွန်၊ ရေခွန်နှင့် တာတမံခွန်၊ အင်းအိုင်ခွန်၊ ဓာတ်သတ္တုခွန် (ရှမ်းပြည်နယ်တွင် သီးနှံခွန်ဟူ၍ သီးခြားပါဝင်ခဲ့ပါသည်) တို့ ဖြစ်ပါသည်။

၄။      ၁၉၈၈ ခုနှစ် မတိုင်မီက နိုင်ငံတော်သည် ဆိုရှယ်လစ်စီးပွားရေးစနစ်ကို ကျင့်သုံးခဲ့ပြီး    ၁၉၈၈ ခုနှစ် နောက်ပိုင်း တပ်မတော်အစိုးရလက်ထက်တွင် နိုင်ငံတော်သည် ဈေးကွက်စီးပွားရေး စနစ်ကို ပြောင်းလဲကျင့်သုံးခဲ့ပါသည်။ ခေတ်စနစ်အရ အခွန်ကောက်ခံမှုစနစ် ပိုမိုထိရောက် ကောင်းမွန်စေရန် အခွန် (၅)မျိုးကို သက်ဆိုင်ရာဌာနများသို့ လွှဲပြောင်းပေးခဲ့ပါသည်။ မြေခွန်၊ ရေခွန်နှင့် တာတမံခွန်၊ ယစ်မျိုးခွန်၊ ဓာတ်သတ္တုခွန်တို့ကို အထွေထွေအုပ်ချုပ်ရေးဦးစီးဌာနသို့ လည်းကောင်း၊ အင်းအိုင်ခွန်ကို ငါးလုပ်ငန်းဦးစီးဌာနသို့လည်းကောင်း (၁-၄-၁၉၈၉) နေ့တွင် လွှဲပြောင်းပေးခဲ့ပါသည်။

၅။      ပြည်တွင်းအခွန်များဦးစီးဌာန မဖွဲ့စည်းမီနှင့် ဖွဲ့စည်းပြီးနောက်ပိုင်း ခေတ်ကာလ အလိုက် ကောက်ခံခဲ့သော အခွန်အမျိုးအစားများနှင့် ယင်းအခွန်များကိုစည်းကြပ် ကောက်ခံနိုင်ရန် ပြဋ္ဌာန်း သည့် အခွန်ဥပဒေများမှာ အောက်ပါ link အတိုင်းဖြစ်ပါသည် -

""",
                ),
                _LinkTextSpan(
                  style: linkStyle,
                  url: 'https://www.irdmyanmar.gov.mm/sites/default/files/IRD%20History%20%288-8-18%29%20Update.pdf',
                  text: """ပြည်တွင်းအခွန်များဦးစီးဌာန၏ နောက်ခံသမိုင်းအကျဉ်းချုပ်"""
                ),
              ],
            ),
          ),
        ]
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