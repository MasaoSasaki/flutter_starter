import 'package:flutter/material.dart';
import 'package:flutter_starter/utility/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// Style guidelines:
/// See: https://creative.line.me/ja/guide/brand-guideline/color-ja
class LineButton extends StatelessWidget {

  /// Constructor
  const LineButton({super.key});

  @override
  Widget build(BuildContext context) {
    final isAndroid = Theme.of(context).platform == TargetPlatform.android;
    final color = isAndroid
        ? const Color.fromRGBO(76, 199, 100, 1) // Android Primary Palette
        : const Color.fromRGBO(6, 199, 85, 1); // iOS Primary Palette
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(FontAwesomeIcons.line, color: Colors.white, size: 34),
            SizedBox(width: 8),
            Text(
              '公式LINE',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
      onPressed: () async {
        final uri = Uri.parse(UrlLauncher().lineUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
    );
  }
}
