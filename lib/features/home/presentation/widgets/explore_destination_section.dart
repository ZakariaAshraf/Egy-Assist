import 'package:flutter/material.dart';
import 'package:study_path/core/data/country_model.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/core/widgets/country_item.dart';

import '../../../../l10n/app_localizations.dart';

class ExploreDestinationSection extends StatelessWidget {
  const ExploreDestinationSection({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final countries = getCountries(l10n);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(l10n.exploreDestinations, style: theme.titleLarge),
        ),
        SizedBox(
          height: 210.h(context),
          width: double.infinity,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: countries.length,
            itemBuilder: (context, index) =>
                CountryItem(country: countries[index]),
            // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 2,
            //   childAspectRatio: 0.7,
            // ),
          ),
        ),
      ],
    );
  }
}
