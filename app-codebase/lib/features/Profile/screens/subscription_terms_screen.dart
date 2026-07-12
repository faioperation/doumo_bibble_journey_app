import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../app/app_string.dart';
import '../../../app/constants.dart';
import '../../../widgets/appbars/custom_appbar.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/reuseable_span_widget.dart';
import '../widgets/title_text_widget.dart';

class SubscriptionTermsScreen extends StatelessWidget {
  const SubscriptionTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(title: "Subscription Terms", onTap: (){
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
                  titleText: AppString.subscriptionTermsTile,
                  type: PageTitleType.large,
                ),
                SizedBox(height: 5),
                SubscriptionTextWidget(),
                _titleAndDescription(
                  titleText: AppString.trilTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.trilBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.subscriptionTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.subscriptionBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),

                _titleAndDescription(
                  titleText: AppString.paymentMethodTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.paymentMethodBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.cancellationTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.cancellationBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                LinkedTextBlock(
                  boldPrefix: AppString.cancellationPartOneBoldText,
                  bodyText: AppString.cancellationPartOneBeforeText,
                  linkText: AppString.cancellationPartOneLinkText,
                  url: AppString.cancellationPartOneLink,
                ),
                SizedBox(height: 10),
                LinkedTextBlock(
                  boldPrefix: AppString.cancellationPartTwoBoldText,
                  bodyText: AppString.cancellationPartTwoBeforeText,
                  linkText: AppString.cancellationPartTwoLinkText,
                  url: AppString.cancellationPartTwoLink,
                ),
                SizedBox(height: 10),
                LinkedTextBlock(
                  boldPrefix: AppString.cancellationPartThreeBoldText,
                  bodyText: AppString.cancellationPartThreeBeforeText,
                  linkText: "",
                  url: "",
                ),
                _titleAndDescription(
                  titleText: AppString.changesTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.changesBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                TitleTextWidget(
                  titleText: AppString.refundsTitle,
                  type: PageTitleType.large,
                ),
                LinkedTextBlock(
                  boldPrefix: AppString.refundsPartOneTextBold,
                  bodyText: AppString.refundsPartOneText,
                  linkText: AppString.refundsPartOneLinkText,
                  url: AppString.refundsPartOneLink,
                ),
                SizedBox(height: 10),
                LinkedTextBlock(
                  boldPrefix: AppString.refundsPartTwoTextBold,
                  bodyText: AppString.refundsPartTwoText,
                  linkText: AppString.refundsPartTwoLinkText,
                  url: AppString.refundsPartTwoLink,
                ),
                SizedBox(height: 10),
                LinkedTextBlock(
                  boldPrefix: AppString.refundsPartThreeTextBold,
                  bodyText: AppString.refundsPartThreeText,
                ),
                SizedBox(height: 10),
                ReuseableSpanWidget(
                  textBefore: AppString.refundsPartFourText,
                  link: AppString.refundsPartFourEmail,
                ),
                SizedBox(height: 10),
                ReuseableSpanWidget(
                  textBefore: AppString.refundsPartFiveText,
                  link: "",
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

  // Helper function to launch URLs
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

          // Clickable Google Play Link
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
  final String? linkText; // Made nullable
  final String? url; // Made nullable

  const LinkedTextBlock({
    super.key,
    this.boldPrefix,
    this.bodyText,
    this.linkText, // Optional
    this.url, // Optional
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
          // 1. Bold Prefix
          TextSpan(
            text: "$boldPrefix: ",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          // 2. Main Body
          TextSpan(text: bodyText),

          // 3. Conditional Link Section
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
