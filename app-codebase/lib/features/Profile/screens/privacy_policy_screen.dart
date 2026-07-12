import 'package:flutter/material.dart';
import '../../../app/app_string.dart';
import '../../../app/constants.dart';
import '../../../widgets/appbars/custom_appbar.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/for_bold_text_widget.dart';
import '../widgets/reuseable_span_widget.dart';
import '../widgets/title_text_widget.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(title: "Privacy policy", onTap: (){
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
                  titleText: AppString.privacyPolicyText,
                  type: PageTitleType.large,
                ),
                SizedBox(height: 5),
        
                _importantPrivacyInformation(),
                _titleAndDescription(
                  titleText: AppString.tableOfContentsTextTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.tableOfContentsTextBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.personalDataControllerTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.personalDataControllerBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _personalDataCollectSection(),
                _weProcessPersonalDataSection(),
                _policyFourSection(),
                _policyFiveSection(),
                _titleAndDescription(
                  titleText: AppString.exerciseYourPrivacyRightsTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.exerciseYourPrivacyRightsTextBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.additionalInformationTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.additionalInformationTextBody,
                  mailOrWebLink: AppString.additionalInformationTextEmail,
                  afterText: '',
                ),
        
                _titleAndDescription(
                  titleText: AppString.ageLimitationTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.ageLimitationTextBody,
                  mailOrWebLink: "",
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.internationalDataTransfersTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.internationalDataTransfersTextBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.changesToThisPolicyTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.changesToThisPolicyTextBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
        
                _titleAndDescription(
                  titleText: AppString.californiaPrivacyRightsTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.californiaPrivacyRightsBeforeTextBody,
                  mailOrWebLink: AppString.californiaPrivacyRightsEmail,
                  afterText: AppString.californiaPrivacyRightsAfterText,
                ),
        
                _titleAndDescription(
                  titleText: AppString.dataRetentionTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.dataRetentionTextBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.requestsAreHandledTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.requestsAreHandledTextBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.contactUsTextTitle,
                  titleType: PageTitleType.medium,
                  beforeText: AppString.contactUsBeforeText,
                  mailOrWebLink: AppString.contactUsEmail,
                  afterText: '',
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _policyFiveSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleAndDescription(
          titleText: AppString.shareYourPersonalDataTextTitle,
          titleType: PageTitleType.large,
          beforeText: AppString.shareYourPersonalDataTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.serviceProvidersTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.serviceProvidersTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.otherPublicAuthoritiesTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.otherPublicAuthoritiesTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.partOfMergerOrAcquisitionTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.partOfMergerOrAcquisitionTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
      ],
    );
  }

  Widget _policyFourSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleAndDescription(
          titleText: AppString.underWeProcessYourPersonalDataTextTitle,
          titleType: PageTitleType.large,
          beforeText: AppString.underWeProcessYourPersonalDataTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.performOurContractWithYouTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.performOurContractWithYouTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.legitimateInterestsTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.legitimateInterestsTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _boldText(),
      ],
    );
  }

  Widget _weProcessPersonalDataSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleAndDescription(
          titleText: AppString.weProcessPersonalDataTextTitle,
          titleType: PageTitleType.large,
          beforeText: AppString.weProcessPersonalDataTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.provideOurServiceTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.provideOurServiceTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.customizeYourExperienceTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.customizeYourExperienceTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.customerSupportTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.customerSupportTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.communicateOurServiceTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.communicateOurServiceTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.researchAndAnalyzeTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.researchAndAnalyzeTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),

        _titleAndDescription(
          titleText: AppString.marketingCommunicationsTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.marketingCommunicationsTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.personalizeOurAdsTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.personalizeOurAdsTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        SizedBox(height: 10),
        TitleTextWidget(
          titleText: AppString.influencePersonalizedAdvertisingTextTitle,
          type: PageTitleType.medium,
        ),
        SizedBox(height: 10),
        BoldText(
          normalText: AppString.influencePersonalizedAdvertisingTextIos,
          boldText: 'iOS: ',
        ),
        BoldText(
          normalText: AppString.influencePersonalizedAdvertisingTextAndroid,
          boldText: 'Android: ',
        ),
        BoldText(
          normalText: AppString.influencePersonalizedAdvertisingTextMacOS,
          boldText: 'macOS: ',
        ),
        BoldText(
          normalText: AppString.influencePersonalizedAdvertisingTextWindows,
          boldText: 'Windows: ',
        ),
        SizedBox(height: 15),
        ReuseableSpanWidget(
          textBefore: AppString.oneBeforeText,
          link: AppString.oneBeforeLink,
          textAfter: "",
        ),
        ReuseableSpanWidget(
          textBefore: AppString.twoBeforeText,
          link: AppString.twoBeforeLink,
          textAfter: "",
        ),
        ReuseableSpanWidget(
          textBefore: AppString.threeBeforeText,
          link: AppString.threeBeforeLink,
          textAfter: "",
        ),
        ReuseableSpanWidget(
          textBefore: AppString.fourBeforeText,
          link: AppString.fourBeforeLink,
          textAfter: "",
        ),
        ReuseableSpanWidget(
          textBefore: AppString.fiveBeforeText,
          link: AppString.fiveBeforeLink,
          textAfter: "",
        ),
        SizedBox(height: 15),
        BoldText(
          normalText: AppString.influencePersonalizedAdvertisingTextBrowsers,
          boldText: 'Browsers: ',
        ),

        _titleAndDescription(
          //influencePersonalizedAdvertisingTextTitle
          titleText: AppString.processYourPaymentsTextTitle,
          titleType: PageTitleType.large,
          beforeText: AppString.processYourPaymentsTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.preventAndCombatFraudTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.preventAndCombatFraudTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.complyWithLegalObligationsTextTitle,
          titleType: PageTitleType.medium,
          beforeText: AppString.complyWithLegalObligationsTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
      ],
    );
  }

  Widget _personalDataCollectSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleAndDescription(
          titleText: AppString.personalDataCollectTextTitle,
          titleType: PageTitleType.large,
          beforeText: AppString.personalDataCollectTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.dataYouGiveUsTextTitle,
          titleType: PageTitleType.large,
          beforeText: AppString.dataYouGiveUsTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        SizedBox(height: 10),
        TitleTextWidget(
          titleText: AppString.dataWeCollectAutoTextTitle,
          type: PageTitleType.medium,
        ),
        _titleAndDescription(
          titleText: AppString.dataAboutFoundTextTitle,
          titleType: PageTitleType.small,
          beforeText: AppString.dataAboutFoundTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.deviceAndLocationDataTextTitle,
          titleType: PageTitleType.small,
          beforeText: AppString.deviceAndLocationDataTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.usageDataTextTitle,
          titleType: PageTitleType.small,
          beforeText: AppString.usageDataTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.advertisingIdsTextTitle,
          titleType: PageTitleType.small,
          beforeText: AppString.advertisingIdsTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.transactionDataTextTitle,
          titleType: PageTitleType.small,
          beforeText: AppString.transactionDataTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
        _titleAndDescription(
          titleText: AppString.cookiesTextTitle,
          titleType: PageTitleType.small,
          beforeText: AppString.cookiesTextBody,
          mailOrWebLink: '',
          afterText: '',
        ),
      ],
    );
  }

  Widget _importantPrivacyInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleTextWidget(
          titleText: AppString.policyInformationText,
          type: PageTitleType.large,
        ),
        SizedBox(height: 10),
        ReuseableSpanWidget(
          textBefore: AppString.policyInformationTextPartOne,
          link: AppString.policyInformationTextPartOneEmail,
          textAfter: ".",
          subject: 'Privacy Policy Question',
        ),
        SizedBox(height: 10),
        Divider(height: 1),
        SizedBox(height: 10),
        ReuseableSpanWidget(
          textBefore: AppString.policyInformationTextPartTwoBeforeText,
          link: AppString.policyInformationTextPartTwoLink,
          textAfter: AppString.policyInformationTextPartTwoAfterText,
        ),
      ],
    );
  }

  Widget _boldText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText(
          normalText: AppString.legitimateInterestsTextBodyOne,
          boldText: AppString.legitimateInterestsTextTitleOne,
        ),
        BoldText(
          normalText: AppString.legitimateInterestsTextBodyTwo,
          boldText: AppString.legitimateInterestsTextTitleTwo,
        ),
        BoldText(
          normalText: AppString.legitimateInterestsTextBodyThree,
          boldText: AppString.legitimateInterestsTextTitleThree,
        ),
        BoldText(
          normalText: AppString.legitimateInterestsTextBodyFour,
          boldText: AppString.legitimateInterestsTextTitleFour,
        ),
        BoldText(
          normalText: AppString.legitimateInterestsTextBodyFive,
          boldText: AppString.legitimateInterestsTextTitleFive,
        ),
        TitleTextWidget(
          titleText: AppString.complyWithObligationsTextTitle,
          type: PageTitleType.medium,
        ),
      ],
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
