import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/app_string.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/for_bold_text_widget.dart';
import '../widgets/reuseable_span_widget.dart';
import '../widgets/title_text_widget.dart';

class MoneyBackPolicyScreen extends StatelessWidget {
  const MoneyBackPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(title: "Money Back Policy", onTap: (){
        Navigator.pop(context);
      }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLogoWidget(),
                SizedBox(height: 15),
                TitleTextWidget(
                  titleText: AppString.moneyBackPolicyTitle,
                  type: PageTitleType.large,
                ),
                SizedBox(height: 5),
                ReuseableSpanWidget(
                  textBefore: AppString.moneyBackPolicyBeforeText,
                  link: AppString.moneyBackPolicyLinkText,
                  textAfter: AppString.moneyBackPolicyAfterText,
                ),
                SizedBox(height: 10),
                TitleTextWidget(
                  titleText: AppString.importantStatmentTitle,
                  type: PageTitleType.large,
                ),
                ReuseableSpanWidget(
                  textBefore: AppString.importantStatmentBeforeText,
                  link: AppString.importantStatmentEmail,
                  textAfter: " .",
                ),
                SizedBox(height: 10),
                _titleAndDescription(
                  titleText: AppString.genaralRefundRulesTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.genaralRefundRulesBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                BoldText(
                  normalText: AppString.genaralRefundRulesOneText,
                  boldText: AppString.genaralRefundRulesOneBold,
                ),
                SizedBox(height: 10),
                BoldText(
                  normalText: AppString.genaralRefundRulesTwoText,
                  boldText: AppString.genaralRefundRulesTwoBold,
                ),
        
                SizedBox(height: 25),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _titleAndDescription({
    required String titleText,
    required PageTitleType titleType,
    required String beforeText,
    required String mailOrWebLink,
    required String afterText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        TitleTextWidget(titleText: titleText, type: titleType),
        const SizedBox(height: 10),
        ReuseableSpanWidget(
          textBefore: beforeText,
          link: mailOrWebLink,
          textAfter: afterText,
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class SubscriptionTextWidget extends StatelessWidget {
  const SubscriptionTextWidget({super.key});

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black87,
          height: 1.5,
        ),
        children: [
          const TextSpan(text: AppString.subscriptionTermsDesBeforeText),

          // Clickable Apple Support Link
          TextSpan(
            text: AppString.appleSupportWebsiteText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Colors.black87,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchURL(AppString.appleSupportWebsiteTextLink),
          ),

          const TextSpan(text: " , "),

          TextSpan(
            text: AppString.googlePlayHelpText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
              color: Colors.black87,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () => _launchURL(AppString.googlePlayHelpTextLink),
          ),

          const TextSpan(text: AppString.subscriptionTermsDesAfterText),
        ],
      ),
    );
  }
}

class LinkedTextBlock extends StatelessWidget {
  final String? boldPrefix;
  final String? bodyText;
  final String? linkText;
  final String? url;

  const LinkedTextBlock({
    super.key,
    this.boldPrefix,
    this.bodyText,
    this.linkText,
    this.url,
  });

  Future<void> _handleLaunchUrl() async {
    if (url == null) return;
    final Uri uri = Uri.parse(url!);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      debugPrint('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 15,
          color: Colors.black87,
          height: 1.4,
        ),
        children: [
          TextSpan(
            text: "$boldPrefix: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          TextSpan(text: bodyText),

          if (linkText != null && url != null)
            TextSpan(
              text: " $linkText",
              style: const TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              recognizer: TapGestureRecognizer()..onTap = _handleLaunchUrl,
            ),
        ],
      ),
    );
  }
}
