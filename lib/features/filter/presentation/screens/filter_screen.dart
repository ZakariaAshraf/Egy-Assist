import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/core/widgets/custom_button.dart';
import 'package:study_path/features/filter/presentation/screens/filter_results_screen.dart';
import '../../../../core/services/ad_manger.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../home/presentation/cubit/programs_cubit.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<String> degreeTypes = ["Bachelor", "Master", "PhD"];

  // List<String> destinations = ["Bachelor", "Master's", "PhD"];
  List<String> languages = ["English", "German", "France", "Arabic"];
  String? _selectedDestination;

  bool _moiValue = false;
  String? _selectedLanguage;
  String? _selectedDegree;
  String? _selectedField;
  InterstitialAd? interstitialAd;

  bool isLoaded = false;

  load() {
    InterstitialAd.load(
      adUnitId: AdManger.rewardedSchedule,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdShowedFullScreenContent: (ad) {
              // Called when the ad showed the full screen content.
              debugPrint('Ad showed full screen content.');
            },

            onAdFailedToShowFullScreenContent: (ad, err) {
              // Called when the ad failed to show full screen content.
              debugPrint(
                'Ad failed to show full screen content with error: $err',
              );
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            onAdDismissedFullScreenContent: (ad) {
              // Called when the ad dismissed full screen content.
              debugPrint('Ad was dismissed.');
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            onAdImpression: (ad) {
              // Called when an impression occurs on the ad.
              debugPrint('Ad recorded an impression.');
            },
            onAdClicked: (ad) {
              // Called when a click is recorded for an ad.
              debugPrint('Ad was clicked.');
            },
          );
          debugPrint('Ad was loaded.');
          interstitialAd = ad;
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('Ad failed to load with error: $error');
        },
      ),
    );
  }
  @override
  void initState() {
    // _selected = List.generate(languages.length, (_) => false);
    load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n!.programFilter),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _selectedDestination = null;
                _selectedField = null;
                _selectedDegree = null;
                _selectedLanguage = null;
                _moiValue = false;
              });
            },
            child: Text(l10n.reset),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(l10n.filters, style: theme.titleLarge!.copyWith(fontSize: 30)),
              SizedBox(height: 30.h(context)),
              Text(l10n.whereDoYouWantToStudy, style: theme.titleLarge),
              SizedBox(height: 15.h(context)),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                ),
                hint: Row(
                  children: [
                    Icon(CupertinoIcons.globe),
                    SizedBox(width: 10),
                    Text(l10n.selectDestination),
                  ],
                ),
                items: [
                  DropdownMenuItem(value: "Germany", child: Text(l10n.germany)),
                  DropdownMenuItem(value: "Austria", child: Text(l10n.austria)),
                  DropdownMenuItem(
                    value: "Other European Countries",
                    child: Text(l10n.otherEuropeanCountries),
                  ),
                ],
                onChanged: (String? value) {
                  setState(() {
                    _selectedDestination = value;
                  });
                },),
              ?_selectedDestination == "Germany"
                  ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("⚠️ ${l10n.apsCertificateForEgyptians}", style: theme.titleMedium!.copyWith(color: Colors.grey),),
                  )
                  : null,
              SizedBox(height: 20.h(context)),
              Text(l10n.academics, style: theme.titleLarge),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(style: BorderStyle.none),
                  ),
                ),
                hint: Row(
                  children: [
                    Icon(Icons.school_outlined),
                    SizedBox(width: 10),
                    Text(l10n.fieldOfStudy),
                  ],
                ),
                items: [
                  DropdownMenuItem(
                    value: "computer_science",
                    child: Text(l10n.computerScience),
                  ),
                  DropdownMenuItem(value: "business", child: Text(l10n.business)),
                ],
                onChanged: (String? value) {
                  _selectedField = value;
                },
              ),
              SizedBox(height: 20.h(context)),
              Text(
                l10n.degreeType,
                style: theme.titleMedium!.copyWith(color: Colors.grey),
              ),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 8.w(context)),
                    ...degreeTypes.map((dest) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          selectedColor: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide.none,
                          showCheckmark: false,
                          label: Text(
                            dest,
                            style: TextStyle(
                              color: _selectedDegree == dest
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          selected: _selectedDegree == dest,
                          onSelected: (selected) {
                            setState(() {
                              _selectedDegree = selected ? dest : null;
                            });
                            if (selected) {}
                          },
                          labelStyle: TextStyle(
                            decoration: _selectedDegree == dest
                                ? TextDecoration.none
                                : TextDecoration.none,
                            fontSize: _selectedDegree == dest
                                ? 18.sp(context)
                                : 13.sp(context),
                            color: _selectedDegree == dest
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      );
                    }),
                    SizedBox(width: 8.w(context)),
                  ],
                ),
              ),
              SizedBox(height: 15.h(context)),
              Text(l10n.requirements, style: theme.titleLarge),
              SizedBox(height: 10),
              Text(
                l10n.languageOfInstructions,
                style: theme.titleMedium!.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 6.h(context)),
              SizedBox(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    SizedBox(width: 8.w(context)),
                    ...languages.map((dest) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: FilterChip(
                          selectedColor: Colors.black,
                          backgroundColor: Colors.white,
                          side: BorderSide.none,
                          label: Text(
                            dest,
                            style: TextStyle(
                              color: _selectedLanguage == dest
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                          selected: _selectedLanguage == dest,
                          onSelected: (selected) {
                            setState(() {
                              _selectedLanguage = selected ? dest : null;
                            });
                            if (selected) {}
                          },
                          labelStyle: TextStyle(
                            decoration: _selectedLanguage == dest
                                ? TextDecoration.none
                                : TextDecoration.none,
                            fontSize: _selectedLanguage == dest
                                ? 18.sp(context)
                                : 13.sp(context),
                            color: _selectedLanguage == dest
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      );
                    }),
                    SizedBox(width: 8.w(context)),
                  ],
                ),
              ),
              ?_selectedLanguage == "English"
                  ? Column(
                      children: [
                        Text(
                          l10n.languageDetails,
                          style: theme.titleMedium!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                              child: RadioListTile<bool>(
                                title: RichText(
                                  text: TextSpan(
                                    style: theme.bodyLarge,
                                    text: l10n.moi,
                                    children: [
                                      TextSpan(
                                        text: "\n${l10n.previousStudyCertificate}",
                                        style: theme.bodyMedium!.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                value: true,
                                groupValue: _moiValue,
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.black,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _moiValue = value!;
                                  });
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile<bool>(
                                title: RichText(
                                  text: TextSpan(
                                    style: theme.bodyLarge,
                                    text: l10n.englishCertificate,
                                    children: [
                                      TextSpan(
                                        text: "\n${l10n.certificatesLikeIelts}",
                                        style: theme.bodyMedium!.copyWith(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                value: false,
                                groupValue: _moiValue,
                                contentPadding: EdgeInsets.zero,
                                activeColor: Colors.black,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _moiValue = value!;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : null,
              SizedBox(height: 35.h(context)),
              CustomButton(
                title: l10n.showPrograms,
                onTap: () async {
                  if (_selectedDestination == null || _selectedField == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(l10n.pleaseFillMissingFields),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }
                  var data = await context.read<ProgramsCubit>().getPrograms(
                    country: _selectedDestination ?? "",
                    onlyMoi: _moiValue,
                    studyField: _selectedField ?? "",
                    degreeType: _selectedDegree ?? "",
                  );
                  void navigateToResults() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchResultsScreen()),
                    );
                  }

                  if (interstitialAd != null) {
                    interstitialAd!.fullScreenContentCallback =
                        FullScreenContentCallback(
                          onAdDismissedFullScreenContent: (ad) {
                            navigateToResults(); // انتقل بمجرد إغلاق الإعلان
                            ad.dispose();
                          },
                          onAdFailedToShowFullScreenContent: (ad, err) {
                            navigateToResults(); // انتقل لو فشل العرض
                            ad.dispose();
                          },
                        );
                    interstitialAd!.show();
                  } else {
                    navigateToResults();
                  }
                },
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
