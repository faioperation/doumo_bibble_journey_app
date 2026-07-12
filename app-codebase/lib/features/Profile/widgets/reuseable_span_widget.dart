import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ReuseableSpanWidget extends StatelessWidget {
  final String textBefore;
  final String link;
  final String textAfter;
  final TextStyle? normalStyle;
  final TextStyle? linkStyle;
  final String? subject;
  final String? body;

  const ReuseableSpanWidget({
    super.key,
    required this.textBefore,
    required this.link,
    this.textAfter = '',
    this.normalStyle,
    this.linkStyle,
    this.subject,
    this.body,
  });

  Future<void> _launchLink() async {
    final Uri uri;

    if (_isEmail(link)) {
      uri = Uri(
        scheme: 'mailto',
        path: link,
        query: _encodeQueryParameters({
          if (subject != null) 'subject': subject!,
          if (body != null) 'body': body!,
        }),
      );
    } else {
      final String url = link.startsWith('http') ? link : 'https://$link';
      uri = Uri.parse(url);
    }

    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  bool _isEmail(String value) {
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$').hasMatch(value);
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    if (params.isEmpty) return null;
    return params.entries
        .map(
          (e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
    )
        .join('&');
  }

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: normalStyle ?? DefaultTextStyle.of(context).style,
        children: [
          TextSpan(text: textBefore),
          WidgetSpan(
            alignment: PlaceholderAlignment.baseline,
            baseline: TextBaseline.alphabetic,
            child: GestureDetector(
              onTap: _launchLink,
              child: Text(
                link,
                style:
                linkStyle ??
                    const TextStyle(
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          TextSpan(text: textAfter),
        ],
      ),
    );
  }
}




// ClickableLinkText(
//   textBefore: 'Contact us at ',
//   link: 'support@bibliejourney.pro',
//   textAfter: '.',
//   subject: 'Privacy Policy Question',
// )


// ClickableLinkText(
//   textBefore: 'Visit our website: ',
//   link: 'bibliejourney.pro',
// )


// ClickableLinkText(
//   textBefore: 'Read more at ',
//   link: 'https://example.com/privacy-policy',
// )