import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkify/linkify.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class DSLinkify {
  static List<InlineSpan> linkifyPlainText({
    required String text,
    TextStyle? defaultStyle,
    Color? linkColor,
  }) {
    return linkifyTextSpan(
      textSpan: TextSpan(text: text),
      defaultStyle: defaultStyle,
      linkColor: linkColor,
    );
  }

  static List<InlineSpan> linkifyTextSpan({
    required InlineSpan textSpan,
    TextStyle? defaultStyle,
    Color? linkColor,
  }) {
    final List<InlineSpan> formattedText = [];

    textSpan.visitChildren(
      (child) {
        final String? spanText = (child as TextSpan).text;
        final TextStyle? spanStyle = (child.style ?? defaultStyle);

        if (spanText?.isNotEmpty ?? false) {
          final List<LinkifyElement> elements = linkify(
            spanText!,
            linkifiers: const [
              UrlLinkifier(),
            ],
          );

          for (var element in elements) {
            if (element is TextElement) {
              formattedText.add(
                TextSpan(
                  text: element.text,
                  style: spanStyle,
                ),
              );
            } else {
              final Uri? url = Uri.tryParse(
                (element as UrlElement).url,
              );

              if (url != null) {
                formattedText.add(
                  TextSpan(
                    text: url.toString(),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () => launchUrl(
                            url,
                            mode: LaunchMode.inAppWebView,
                          ),
                    style: spanStyle?.copyWith(
                      color: linkColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                );
              }
            }
          }
        }

        return true;
      },
    );

    return formattedText;
  }

  static Uri getFirstUrlFromText(String text) {
    final List<LinkifyElement> elements = linkify(
      text,
      linkifiers: const [
        UrlLinkifier(),
      ],
    );

    final LinkifyElement firstUrlElement = elements.firstWhere(
      (element) {
        if (element is UrlElement) {
          return Uri.tryParse(element.url) != null;
        }

        return false;
      },
      orElse: () => UrlElement(''),
    );

    return Uri.parse((firstUrlElement as UrlElement).url);
  }
}
