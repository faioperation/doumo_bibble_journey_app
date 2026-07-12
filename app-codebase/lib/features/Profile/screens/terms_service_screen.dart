
import 'package:flutter/material.dart';
import '../../../app/app_string.dart';
import '../../../app/constants.dart';
import '../../../widgets/appbars/custom_appbar.dart';
import '../widgets/app_logo_widget.dart';
import '../widgets/reuseable_span_widget.dart';
import '../widgets/title_text_widget.dart';

class TermsAndConditionsOfUseScreen extends StatelessWidget {
  const TermsAndConditionsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(title: "Terms and Condition", onTap: (){
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
                _titleAndDescription(
                  titleText: AppString.termsAndConditionsOfUseTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.termsAndConditionsOfUseBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.acceptanceOfTermsTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.acceptanceOfTermsBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
        
                _titleAndDescription(
                  titleText: AppString.importantDisclaimersTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.importantDisclaimersBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.accountRegistrationTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.accountRegistrationBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.serviceTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.serviceBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.propertyUserContentTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.propertyUserContentBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.paymentsAndRefundsTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.paymentsAndRefundsBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.representationsAndRestrictionsTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.representationsAndRestrictionsBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.disclaimerOfWarrantiesTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.disclaimerOfWarrantiesTitleBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.limitationOfLiabilityTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.limitationOfLiabilityTitleBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.indemnityTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.indemnityTitleBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.internationalUseTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.internationalUseTitleBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.mandatoryBindingArbitrationTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.mandatoryBindingArbitrationBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.governingLawTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.governingLawTitleBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.miscellaneousProvisionsTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.miscellaneousProvisionsTitleBody,
                  mailOrWebLink: '',
                  afterText: '',
                ),
                _titleAndDescription(
                  titleText: AppString.miscellaneousProvisionsTitle,
                  titleType: PageTitleType.large,
                  beforeText: AppString.miscellaneousProvisionsTitleBody,
                  mailOrWebLink: '',
                  afterText: '',
                ), //
                TitleTextWidget(
                  titleText: AppString.contactTitle,
                  type: PageTitleType.large,
                ),
        
                ReuseableSpanWidget(
                  textBefore: AppString.contactBeforeText,
                  link: AppString.contactBeforeEmail,
                ),
                SizedBox(height: 5),
                Divider(height: 1),
                SizedBox(height: 5),
                ReuseableSpanWidget(
                  textBefore: AppString.footerTextTitle,
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
