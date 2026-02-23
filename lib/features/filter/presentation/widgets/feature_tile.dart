import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';

class FeatureTile extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Color? iconColor;
  final IconData? iconData;
  const FeatureTile({super.key, required this.title, this.subTitle, this.iconColor, this.iconData});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.redAccent.withOpacity(0.1),
            ),
            child: iconData != null ? Icon(iconData, color: iconColor) : SizedBox.shrink(),
          ),
        ),
        title: Text(title),
        subtitle: Text(subTitle ?? l10n.notAvailableShort),
      ),
    );
  }
}
