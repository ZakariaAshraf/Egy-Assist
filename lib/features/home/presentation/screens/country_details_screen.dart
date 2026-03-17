import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:study_path/core/data/country_model.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/core/widgets/custom_button.dart';
import '../../../../core/utils/extenstions.dart';
import '../../../../core/widgets/feature_container.dart';
import '../../../../l10n/app_localizations.dart';

class CountryDetailsScreen extends StatelessWidget {
  final CountryModel country;

  const CountryDetailsScreen({super.key, required this.country});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h(context)),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Container(
                height: 450.h(context),
                width: 400.w(context),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      country.imagePath ?? "assets/images/pattern.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      start: 10,
                      top: 7,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: BoxBorder.all(color: Colors.black12),
                          // color: Colors.white.withOpacity(0.9),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            // Directionality.of(context) == TextDirection.rtl
                            //     ? Icons.arrow_forward
                            //     :
                          Icons.arrow_back,
                          ),
                        ),
                      ),
                    ),
                    Positioned.directional(
                      textDirection: Directionality.of(context),
                      end: 10,
                      bottom: 30,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: BoxBorder.all(color: Colors.black12),
                          color: Colors.white.withOpacity(0.9),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            country.countryFlagPath ??
                                "assets/images/pattern.png",
                            width: 40,
                            height: 40,
                          ),
                        ),
                      ),
                    ).animate()
                        .fade(duration: 500.ms)
                        .scale(delay: 500.ms),
                    Align(
                      alignment: AlignmentDirectional.bottomStart,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: 12,
                          end: 12,
                          bottom: 19,
                          top: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: BoxBorder.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.blue,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              child: Text(
                                l10n.mostPopular,
                                style: theme.labelMedium,
                                textDirection: Directionality.of(context),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              country.countryName,
                              style: theme.titleLarge!.copyWith(
                                color: Colors.white,
                                fontSize: 40.sp(context),
                              ),
                              textDirection: Directionality.of(context),
                            ),
                            SizedBox(height: 4),
                            Text(
                              "${country.programsLength}+ ${l10n.programs}",
                              style: theme.titleSmall!.copyWith(
                                color: Colors.grey,
                                fontSize: 20.sp(context),
                              ),
                              textDirection: Directionality.of(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// body
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FeatureContainer(
                          icon: CupertinoIcons.money_euro,
                          featureTitle: l10n.tuitionFees,
                          data: country.studyTuitionFeesState ?? l10n.almostFree,
                          iconColor: Colors.green,
                        ),
                        FeatureContainer(
                          icon: Icons.work_outline,
                          featureTitle: l10n.studentWorkHours,
                          data: country.studentWorkingHours ?? l10n.studentWorkHoursValue,
                          iconColor: Colors.blueAccent,
                        ),
                        FeatureContainer(
                          icon: CupertinoIcons.globe,
                          featureTitle: l10n.language,
                          data: country.language ?? l10n.countryLanguage,
                          iconColor: Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h(context)),
                  Text(l10n.countryOverview, style: theme.titleLarge),
                  SizedBox(height: 8.h(context)),
                  Text(
                    country.description,
                    style: theme.titleMedium!.copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 20.h(context)),
                  if (country.requirements != null)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.basicRequirements, style: theme.titleLarge),
                          SizedBox(height: 10.h(context)),
                          Container(
                            // height: 500.h(context),
                            decoration: BoxDecoration(
                              border: BoxBorder.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: country.requirements?.length ?? 0,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.verified, color: Colors.green),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child: Text(
                                        country.requirements![index],
                                        softWrap: true,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 10.h(context)),
                  if (country.countryStudySteps != null)
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.stepsToStudy, style: theme.titleLarge),
                          SizedBox(height: 10.h(context)),
                          Container(
                            // height: 550.h(context),
                            decoration: BoxDecoration(
                              border: BoxBorder.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: ListView.builder(
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(vertical: 8),
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: country.countryStudySteps?.length ?? 0,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 8.0, left: 8.0, right: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(Icons.circle, color: Colors.blueAccent,size: 12,),
                                        SizedBox(width: 4),
                                        Text(
                                          l10n.stepN(index + 1), style: theme.titleMedium!.copyWith(color: Colors.blueAccent),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(country.countryStudySteps![index].title, style: theme.titleLarge!.copyWith(fontSize: 18)),
                                          Text(
                                            country.countryStudySteps![index].description ,
                                            style: theme.titleMedium!.copyWith(color: Colors.grey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 10.h(context)),

                  Text(l10n.linksWillHelpYou, style: theme.titleLarge),
                  SizedBox(height: 10.h(context)),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await launchUrls(
                                    country.embassyAppointmentLink ??"www.google.com",
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: BoxBorder.all(color: Colors.grey.shade300),
                                  ),
                                  child: Icon(CupertinoIcons.link,size: 30,color: Colors.brown,),
                                ),
                              ),
                              Text(l10n.embassy, style: theme.titleMedium),
                              Text(l10n.toMakeVisaAppointment, style: theme.titleSmall!.copyWith(color: Colors.grey),),
                            ],
                          ),
                          SizedBox(width: 10.w(context),),
                          Column(
                              children: [
                                InkWell(
                                  onTap: () async {
                                    await launchUrls(
                                      country.vfsAppointmentLink ??"www.google.com",
                                    );
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: BoxBorder.all(color: Colors.grey.shade300),
                                    ),
                                    child: Icon(Icons.file_copy_outlined,size: 30,color: Colors.yellow,),
                                  ),
                                ),
                                Text(l10n.vfs, style: theme.titleMedium),
                                Text(l10n.toMakeLegalizationAppointment, style: theme.titleSmall!.copyWith(color: Colors.grey),),
                              ],
                            ),
                          SizedBox(width: 10.w(context),),
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  await launchUrls(
                                    country.embassyLocationLink ??"www.google.com",
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: BoxBorder.all(color: Colors.grey.shade300),
                                  ),
                                  child: Icon(CupertinoIcons.location,size: 30,color: Colors.blue,),
                                ),
                              ),
                              Text(l10n.embassyLocation, style: theme.titleMedium),
                              Text(l10n.toAttendYourAppointment, style: theme.titleSmall!.copyWith(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h(context)),
                  // Divider(),
                   Padding(
                     padding: const EdgeInsets.all(25),
                     child: Container(
                        padding: EdgeInsets.all(30.w(context)),
                        clipBehavior: Clip.antiAlias,
                        // height: 200.h(context),
                        // width: 400.w(context),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(30.r(context)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              textAlign:TextAlign.center,
                              l10n.readyToStartJourney,
                              style: theme.titleLarge!.copyWith(
                                fontSize: 28.sp(context),
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              l10n.findOpenProgramsAndApply,
                              style: theme.titleMedium!.copyWith(
                                color: Colors.white60,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10.h(context)),
                            CustomButton(title: l10n.browsePrograms, onTap: (){
                              Navigator.pop(context);
                            },color: Colors.white,isInvert: false,textStyle: theme.titleLarge!.copyWith(
                              color: Colors.blueAccent,
                            ),width: 240.w(context),height: 80.h(context),)
                          ],
                        ),
                      ).animate()
                        .fade(duration: 500.ms)
                        .slideX(delay: 300.ms),
                   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
