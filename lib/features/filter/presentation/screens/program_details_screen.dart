import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/core/widgets/feature_container.dart';
import '../../../../core/services/ad_manger.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/extenstions.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../favorite/cubit/favourite_cubit.dart';
import '../../../home/data/model/program_model.dart';
import '../widgets/feature_tile.dart';
import '../widgets/link_previewer.dart';

class ProgramDetailsScreen extends StatefulWidget {
  final ProgramModel program;

  const ProgramDetailsScreen({super.key, required this.program});

  @override
  State<ProgramDetailsScreen> createState() => _ProgramDetailsScreenState();
}

class _ProgramDetailsScreenState extends State<ProgramDetailsScreen> {
  bool _isLoading = true;
  BannerAd? _bannerAd;
  bool _isLoaded = false;
  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: AdManger.bannerDetailsScreen,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          ad.dispose();
        },
      ),
    )..load();
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(widget.program.programName), centerTitle: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  LinkPreviewer(
                    url: widget.program.websiteLink ?? widget.program.applyLink,
                    // imageHeight: 200,
                    // imageWidth: 200,
                  ),
                  if (widget.program.moiAccepted)
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Container(
                        // height: 40,
                        // width: 64.w(context),
                        padding: EdgeInsets.all(7),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          // shape: BoxShape.circle,
                          color: Colors.black.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            Text(
                              l10n.moiAccepted,
                              style: theme.bodyMedium!.copyWith(
                                color: Colors.green,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.key_outlined,
                              color: Colors.green,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  Positioned(
                    right: 10,
                    top: 10,
                    child: BlocBuilder<FavouriteCubit, FavouriteState>(
                      builder: (context, state) {
                        final isFavorite = context
                            .read<FavouriteCubit>()
                            .isFavorite(widget.program.id ?? "");
                        return InkWell(
                          onTap: () async {
                            await context.read<FavouriteCubit>().addToFavourite(
                              widget.program,
                            );
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    isFavorite
                                        ? l10n.removedFromBookmarks
                                        : l10n.addedToSavedPrograms,
                                  ),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
                          },
                          child: Container(
                            // height: 40,
                            // width: 64.w(context),
                            padding: EdgeInsets.all(7),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              // shape: BoxShape.circle,
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Icon(
                              isFavorite
                                  ? Icons.bookmark
                                  : Icons.bookmark_border,
                              color: isFavorite ? Colors.white : Colors.black,
                              size: 25,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h(context)),
              Text(widget.program.universityName, style: theme.titleLarge),
              SizedBox(height: 5.h(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.pin_drop, color: Colors.red),
                  SizedBox(width: 10.w(context)),
                  Text(
                    widget.program.country,
                    style: theme.bodyMedium!.copyWith(color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(height: 8.h(context)),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FeatureContainer(
                      icon: CupertinoIcons.money_euro,
                      featureTitle: l10n.tuition,
                      data: "${widget.program.tuitionFees ?? l10n.notAvailable}",
                      iconColor: Colors.green,
                    ),
                    FeatureContainer(
                      icon: CupertinoIcons.globe,
                      featureTitle: l10n.language,
                      data: widget.program.language ?? l10n.countryLanguage,
                      iconColor: Colors.blueAccent,
                    ),
                    FeatureContainer(
                      icon: CupertinoIcons.time_solid,
                      featureTitle: l10n.duration,
                      data: "${widget.program.duration ?? l10n.notAvailable} ${l10n.semesters}",
                      iconColor: Colors.orange,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.h(context)),
              _buildAboutSection(
                city: widget.program.city,
                deadline: widget.program.deadline,
                intake: widget.program.intake,
                isPublicUniversity: widget.program.isPublicUniversity,
                context: context,
              ),
              SizedBox(height: 8.h(context)),
              _buildAdmissionRequirementsSection(
                context: context,
                country: widget.program.country,
                germanLevel: widget.program.germanLevel,
                ieltsRequirement: widget.program.ieltsRequirement,
                toeflRequirement: widget.program.toeflRequirement,
                moiPolicy: widget.program.moiPolicy,
                requiresAPS: widget.program.requiresAps,
                requiresBlockedAccount: widget.program.requiresBlockedAccount,
                moiAccepted: widget.program.moiAccepted,
              ),
              SizedBox(height: 30.h(context)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      textStyle: theme.titleMedium!.copyWith(
                        color: Colors.black,
                      ),
                      title: l10n.officialWebsite,
                      isInvert: false,
                      onTap: () async {
                        await launchUrls(
                          widget.program.websiteLink ?? widget.program.applyLink,
                        );
                      },
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 12.w(context)),
                  Expanded(
                    flex: 1,
                    child: CustomButton(
                      textStyle: theme.titleMedium!.copyWith(
                        color: Colors.white,
                      ),
                      title: l10n.viewPortal,
                      onTap: () async {
                        await launchUrls(widget.program.applyLink);
                      },
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h(context)),
              if (_isLoaded)
                SizedBox(
                  height: _bannerAd!.size.height.toDouble(),
                  width: _bannerAd!.size.width.toDouble(),
                  child: AdWidget(ad: _bannerAd!),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAboutSection({
    String? deadline,
    String? city,
    String? intake,
    bool? isPublicUniversity,
    required BuildContext context,
  }) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.aboutUniversity, style: theme.titleLarge),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Text(
                    "📍 ",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp(context),
                    ),
                  ),
                  Text(
                    l10n.city,
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp(context),
                    ),
                  ),
                  SizedBox(width: 3.w(context)),
                  Text(city ?? l10n.notAvailableCheckWebsite),
                ],
              ),
              Row(
                children: [
                  Text(
                    "📅 ",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp(context),
                    ),
                  ),
                  Text(
                    l10n.deadline,
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp(context),
                    ),
                  ),
                  SizedBox(width: 6.w(context)),
                  Text(deadline ?? l10n.notAvailableCheckWebsite),
                ],
              ),
              Row(
                children: [
                  Text(
                    "🎓 ",
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 17.sp(context),
                    ),
                  ),
                  Text(
                    l10n.intake,
                    style: theme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.sp(context),
                    ),
                  ),
                  SizedBox(width: 6.w(context)),
                  Text(intake ?? l10n.notAvailableCheckWebsite),
                ],
              ),
              if (isPublicUniversity != null)
                Row(
                  children: [
                    Text(
                      l10n.university,
                      style: theme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp(context),
                      ),
                    ),
                    SizedBox(width: 6.w(context)),
                    Text(
                      isPublicUniversity
                          ? l10n.publicUniversity
                          : l10n.privateUniversity,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAdmissionRequirementsSection({
    double? ieltsRequirement,
    double? toeflRequirement,
    String? germanLevel,
    bool? requiresBlockedAccount,
    bool? requiresAPS,
    bool? moiAccepted,
    String? moiPolicy,
    String? country,
    required BuildContext context,
  }) {
    final l10n = AppLocalizations.of(context)!;
    var theme = Theme.of(context).textTheme;
    String languageSubtitle;
    if (country == "Austria") {
      if (ieltsRequirement != null && toeflRequirement != null) {
        languageSubtitle =
            "IELTS: $ieltsRequirement or TOEFL: $toeflRequirement";
      } else if (ieltsRequirement != null) {
        languageSubtitle = "IELTS: $ieltsRequirement";
      } else if (toeflRequirement != null) {
        languageSubtitle = "TOEFL: $toeflRequirement";
      } else {
        languageSubtitle = l10n.englishRequirementsNotAvailable;
      }
    } else {
      languageSubtitle = germanLevel ?? l10n.germanLevelNotAvailable;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(l10n.admissionRequirements, style: theme.titleLarge),
        Column(
          children: [
            FeatureTile(
              title: l10n.languageLevel,
              subTitle: languageSubtitle,
              iconData: Icons.translate,
              iconColor: Colors.blueAccent,
            ),
            SizedBox(height: 4.h(context)),
            country == "German"
                ? FeatureTile(
                    iconColor: Colors.green,
                    iconData: Icons.account_balance_wallet_outlined,
                    title: l10n.requiresBlockAccount,
                    subTitle: requiresBlockedAccount == true ? l10n.yes : l10n.no,
                  )
                : SizedBox.shrink(),
            SizedBox(height: 4.h(context)),
            country == "German"
                ? FeatureTile(
                    iconColor: Colors.red,
                    iconData: Icons.policy_outlined,
                    title: l10n.requiresApsCertificate,
                    subTitle: "${requiresAPS ?? l10n.notAvailableShort}",
                  )
                : SizedBox.shrink(),
            SizedBox(height: 4.h(context)),
            if (moiAccepted == true)
              FeatureTile(
                iconColor: Colors.redAccent,
                iconData: Icons.policy_outlined,
                title: l10n.moiPolicy,
                subTitle: moiPolicy ?? l10n.notAvailableShort,
              ),
          ],
        ),
      ],
    );
  }
}
