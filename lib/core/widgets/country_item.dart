import 'package:flutter/material.dart';
import 'package:study_path/core/data/country_model.dart';
import 'package:study_path/core/utils/screen_util.dart';

import '../../features/home/presentation/screens/country_details_screen.dart';
import '../../l10n/app_localizations.dart';

class CountryItem extends StatelessWidget {
  final CountryModel country;
  const CountryItem({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => CountryDetailsScreen(country:country),));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 200.w(context) ,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(country.imagePath??"assets/images/pattern.png"),
              fit: BoxFit.cover,
              opacity: 0.9,
              colorFilter: ColorFilter.srgbToLinearGamma()
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 10,
                top: 7,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: BoxBorder.all(color: Colors.black12),
                  ),
                  child: ClipOval(child: Image.asset(country.countryFlagPath??"assets/images/pattern.png",width: 30,height: 30,)),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0,left: 8.0 ),
                    child: Text(country.countryName, style: theme.titleLarge!.copyWith(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 19.0,right: 20),
                    child: Text(
                      "${country.programsLength}+ ${l10n.programs}",
                      style: theme.titleSmall!.copyWith(color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
