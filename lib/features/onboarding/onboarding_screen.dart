import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:study_path/core/utils/screen_util.dart';
import '../../l10n/app_localizations.dart';
import '../../core/cache/cache_helper.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    var theme =Theme.of(context).textTheme;
    return Scaffold(
      body: OnBoardingSlider(
        skipTextButton: Text(l10n!.skip,style: theme.bodySmall!.copyWith(
          fontSize: 18.0.sp(context),
          fontWeight: FontWeight.w600,
        ),),
        centerBackground: true,
        finishButtonText: l10n.letsStart,
        onFinish: () async {
          await CacheHelper.set(key: CacheKeys.isOnBoardingSeen, value: true);
          if (!context.mounted) return;
          Navigator.pushReplacementNamed(context, '/signIn');
        },
        finishButtonStyle: const FinishButtonStyle(
          backgroundColor: Colors.black,
        ),
        totalPage: 3,
        headerBackgroundColor: Colors.white,
        controllerColor: Colors.grey,
        background: [
          Image.asset(
            "assets/images/onboarding_1.png",
            width: 400.w(context),
            height: 400.h(context),
          ),
          Image.asset(
            "assets/images/onboarding_2.png",
            width: 400.w(context),
            height: 400.h(context),
          ),
          Image.asset(
            "assets/images/onboarding_3.png",
            width: 400.w(context),
            height: 400.h(context),
          ),
        ],
        speed: 1.8,
        pageBodies: [
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 SizedBox(height: 400.h(context)),
                Text(
                  l10n.unlockEurope,
                  textAlign: TextAlign.center,
                  style: theme.titleLarge!.copyWith(
                    // color: Colors.black,
                    fontSize: 24.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                 SizedBox(height: 5.h(context)),
                 Text(
                  l10n.onboardingDescription1,
                  textAlign: TextAlign.center,
                  style: theme.bodySmall!.copyWith(
                    fontSize: 18.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 400.h(context)),
                Text(
                  l10n.filterByWhatMatters,
                  textAlign: TextAlign.center,
                  style: theme.titleLarge!.copyWith(
                    fontSize: 24.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                 SizedBox(height: 5.h(context)),
                 Text(
                  l10n.onboardingDescription2,
                  textAlign: TextAlign.center,
                  style: theme.bodySmall!.copyWith(
                    fontSize: 18.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.start,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 400.h(context)),
                Text(
                  l10n.yourFutureAwaits,
                  textAlign: TextAlign.center,
                  style: theme.titleLarge!.copyWith(
                    fontSize: 24.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                 SizedBox(height: 5.h(context)),
                 Text(
                  l10n.onboardingDescription3,
                  textAlign: TextAlign.center,
                  style: theme.bodySmall!.copyWith(
                    fontSize: 18.0.sp(context),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
