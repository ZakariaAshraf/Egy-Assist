import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:study_path/core/cache/cache_helper.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/features/filter/presentation/screens/filter_screen.dart';
import 'package:study_path/features/search/presentation/search_screen.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/app_colors.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    final direction = Directionality.of(context);

    return Padding(
      padding: EdgeInsets.all(10.w(context)),
      child: Container(
        clipBehavior: Clip.antiAlias,
        height: 280.h(context),
        width: 400.w(context),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/pattern.png"),fit: BoxFit.cover),
          color: AppColors.blackSecondary,
          border: Border.all(strokeAlign: 0.5),
          borderRadius: BorderRadius.circular(30.r(context)),
        ),
        child: Stack(
          children: [
            Positioned.directional(
              textDirection: direction,
              start: 10.w(context),
              top: 20,
              child: SizedBox(
                width: 280.w(context),
                child: Text(
                  l10n!.findYourDreamMasters,
                  style: theme.titleLarge!.copyWith(
                    fontSize: 28.sp(context),
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Positioned.directional(
              textDirection: direction,
              top: 100.h(context),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    l10n.searchOverDegrees,
                    style: theme.bodyMedium!.copyWith(color: AppColors.secondary),
                  ),
                ),
              ),
            ),
            Positioned.directional(
              start: 20.w(context),
              textDirection: direction,
              top: 180.h(context),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen(),));
                },
                child: Container(
                  height: 60.h(context),
                  width: 320.w(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          l10n.startNewSearch,
                          style: theme.titleMedium!.copyWith(
                            color: Colors.blueAccent.shade400,
                            fontWeight: FontWeight.bold,
                            fontSize: 17.sp(context),
                          ),
                        ),
                        Container(
                          // height: 40,
                          // width: 64.w(context),
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // shape: BoxShape.circle,
                            color: Colors.blueAccent,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                                size: 30.r(context),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
