import 'package:flutter/material.dart';
import 'package:study_path/core/utils/screen_util.dart';

class FeatureContainer extends StatelessWidget {
  final IconData icon;
  final String? imageIconPath;
  final String featureTitle;
  final String data;
  final Color iconColor;

  const FeatureContainer({super.key, required this.icon, required this.featureTitle, this.imageIconPath, required this.data, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        // width: 150.w(context),
        // height: 140.h(context),
        // margin: EdgeInsets.only(left: 7),
        decoration: BoxDecoration(
          border: BoxBorder.all(color: Colors.grey.shade300),
          // color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(
                icon,
                color: iconColor,
              ),
            ),
            SizedBox(height: 10.h(context)),
            Text(
              featureTitle,
              style: theme.bodySmall!.copyWith(
                fontSize: 14.sp(context),
              ),
            ),
            SizedBox(height: 2.h(context)),
            Text(
              data,
              style: theme.titleMedium!.copyWith(
                fontSize: 17.sp(context),
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
