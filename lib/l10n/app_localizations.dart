import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme Mode'**
  String get themeMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'logout'**
  String get logout;

  /// No description provided for @pleaseWriteEmail.
  ///
  /// In en, this message translates to:
  /// **'Please write your Email Address'**
  String get pleaseWriteEmail;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @profileUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdatedSuccessfully;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @forgetPassword.
  ///
  /// In en, this message translates to:
  /// **'Forget Password ?'**
  String get forgetPassword;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get dontHaveAccount;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create!'**
  String get create;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account'**
  String get alreadyHaveAccount;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed Please check your email or password'**
  String get loginFailed;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Register failed please check all fields'**
  String get registerFailed;

  /// No description provided for @continuee.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continuee;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// Error message with error details
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String error(Object error);

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @letsStart.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Start ->'**
  String get letsStart;

  /// No description provided for @unlockEurope.
  ///
  /// In en, this message translates to:
  /// **'Unlock Europe'**
  String get unlockEurope;

  /// No description provided for @onboardingDescription1.
  ///
  /// In en, this message translates to:
  /// **'Explore thousands of Master\'s programs across the continent filtered by your specific needs.'**
  String get onboardingDescription1;

  /// No description provided for @filterByWhatMatters.
  ///
  /// In en, this message translates to:
  /// **'Filter by what matters'**
  String get filterByWhatMatters;

  /// No description provided for @onboardingDescription2.
  ///
  /// In en, this message translates to:
  /// **'Narrow down thousands of European programs based on your budget, language, and interests.'**
  String get onboardingDescription2;

  /// No description provided for @yourFutureAwaits.
  ///
  /// In en, this message translates to:
  /// **'Your Future Awaits'**
  String get yourFutureAwaits;

  /// No description provided for @onboardingDescription3.
  ///
  /// In en, this message translates to:
  /// **'Access thousands of European master\'s programs tailored to your goals. Let\'s find your perfect match today.'**
  String get onboardingDescription3;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back,'**
  String get welcomeBack;

  /// No description provided for @signInDescription.
  ///
  /// In en, this message translates to:
  /// **'Find your future in Europe. Continue your journey to a Master\'s degree'**
  String get signInDescription;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'Continue as a Guest'**
  String get continueAsGuest;

  /// No description provided for @joinApplication.
  ///
  /// In en, this message translates to:
  /// **'Join Application'**
  String get joinApplication;

  /// No description provided for @signUpDescription.
  ///
  /// In en, this message translates to:
  /// **'Find your dream Master\'s program in Europe'**
  String get signUpDescription;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @chooseYourCharacter.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Character'**
  String get chooseYourCharacter;

  /// No description provided for @chooseCharacterDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the profile that best describes you to personalize your journey to Europe.'**
  String get chooseCharacterDescription;

  /// No description provided for @pleaseSelectCharacter.
  ///
  /// In en, this message translates to:
  /// **'Please select a character first'**
  String get pleaseSelectCharacter;

  /// No description provided for @directScholarshipApplications.
  ///
  /// In en, this message translates to:
  /// **'Direct Scholarship Applications! Stay tuned'**
  String get directScholarshipApplications;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'COMING SOON'**
  String get comingSoon;

  /// No description provided for @willBeAvailableSoon.
  ///
  /// In en, this message translates to:
  /// **'Will be available soon'**
  String get willBeAvailableSoon;

  /// No description provided for @savedPrograms.
  ///
  /// In en, this message translates to:
  /// **'Saved Programs'**
  String get savedPrograms;

  /// No description provided for @noSavedPrograms.
  ///
  /// In en, this message translates to:
  /// **'You don\'t save any programmes'**
  String get noSavedPrograms;

  /// No description provided for @favorite.
  ///
  /// In en, this message translates to:
  /// **'favorite'**
  String get favorite;

  /// No description provided for @reloadPage.
  ///
  /// In en, this message translates to:
  /// **'Reload page'**
  String get reloadPage;

  /// No description provided for @findYourDreamMasters.
  ///
  /// In en, this message translates to:
  /// **'Find your dream\nMaster\'s in Europe'**
  String get findYourDreamMasters;

  /// No description provided for @searchOverDegrees.
  ///
  /// In en, this message translates to:
  /// **'Search over 100 degrees'**
  String get searchOverDegrees;

  /// No description provided for @startNewSearch.
  ///
  /// In en, this message translates to:
  /// **'Start New Search'**
  String get startNewSearch;

  /// No description provided for @errorFetchingProperties.
  ///
  /// In en, this message translates to:
  /// **'Error fetching properties'**
  String get errorFetchingProperties;

  /// No description provided for @noPropertiesFound.
  ///
  /// In en, this message translates to:
  /// **'No properties found'**
  String get noPropertiesFound;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No Results'**
  String get noResults;

  /// No description provided for @programFilter.
  ///
  /// In en, this message translates to:
  /// **'Program Filter'**
  String get programFilter;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @filters.
  ///
  /// In en, this message translates to:
  /// **'Filters'**
  String get filters;

  /// No description provided for @programs.
  ///
  /// In en, this message translates to:
  /// **'Programs'**
  String get programs;

  /// No description provided for @whereDoYouWantToStudy.
  ///
  /// In en, this message translates to:
  /// **'Where do you want to study ?'**
  String get whereDoYouWantToStudy;

  /// No description provided for @selectDestination.
  ///
  /// In en, this message translates to:
  /// **'Select Destination'**
  String get selectDestination;

  /// No description provided for @academics.
  ///
  /// In en, this message translates to:
  /// **'Academics'**
  String get academics;

  /// No description provided for @fieldOfStudy.
  ///
  /// In en, this message translates to:
  /// **'Field of study'**
  String get fieldOfStudy;

  /// No description provided for @degreeType.
  ///
  /// In en, this message translates to:
  /// **'degree type'**
  String get degreeType;

  /// No description provided for @requirements.
  ///
  /// In en, this message translates to:
  /// **'Requirements'**
  String get requirements;

  /// No description provided for @languageOfInstructions.
  ///
  /// In en, this message translates to:
  /// **'LANGUAGE OF INSTRUCTIONS'**
  String get languageOfInstructions;

  /// No description provided for @languageDetails.
  ///
  /// In en, this message translates to:
  /// **'Language details'**
  String get languageDetails;

  /// No description provided for @moi.
  ///
  /// In en, this message translates to:
  /// **'MOI'**
  String get moi;

  /// No description provided for @previousStudyCertificate.
  ///
  /// In en, this message translates to:
  /// **'previous study certificate'**
  String get previousStudyCertificate;

  /// No description provided for @englishCertificate.
  ///
  /// In en, this message translates to:
  /// **'English Certificate'**
  String get englishCertificate;

  /// No description provided for @certificatesLikeIelts.
  ///
  /// In en, this message translates to:
  /// **'certificates like IELTS..etc'**
  String get certificatesLikeIelts;

  /// No description provided for @showPrograms.
  ///
  /// In en, this message translates to:
  /// **'Show Programs'**
  String get showPrograms;

  /// No description provided for @pleaseFillMissingFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill missing fields'**
  String get pleaseFillMissingFields;

  /// No description provided for @universityDetails.
  ///
  /// In en, this message translates to:
  /// **'University Details'**
  String get universityDetails;

  /// No description provided for @removedFromBookmarks.
  ///
  /// In en, this message translates to:
  /// **'removed from bookmarks'**
  String get removedFromBookmarks;

  /// No description provided for @addedToSavedPrograms.
  ///
  /// In en, this message translates to:
  /// **'added to saved programs'**
  String get addedToSavedPrograms;

  /// No description provided for @tuition.
  ///
  /// In en, this message translates to:
  /// **'TUITION'**
  String get tuition;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'NOT AVAILABLE'**
  String get notAvailable;

  /// No description provided for @countryLanguage.
  ///
  /// In en, this message translates to:
  /// **'Country Language'**
  String get countryLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'DURATION'**
  String get duration;

  /// No description provided for @admissionRequirements.
  ///
  /// In en, this message translates to:
  /// **'Admission Requirements'**
  String get admissionRequirements;

  /// No description provided for @officialWebsite.
  ///
  /// In en, this message translates to:
  /// **'Official Website'**
  String get officialWebsite;

  /// No description provided for @viewPortal.
  ///
  /// In en, this message translates to:
  /// **'View Portal'**
  String get viewPortal;

  /// No description provided for @startYourSearchNow.
  ///
  /// In en, this message translates to:
  /// **'Start Your Search Now'**
  String get startYourSearchNow;

  /// No description provided for @searchWithUniversityNameOrProgramName.
  ///
  /// In en, this message translates to:
  /// **'Search with university name or program name'**
  String get searchWithUniversityNameOrProgramName;

  /// No description provided for @bookmarks.
  ///
  /// In en, this message translates to:
  /// **'Bookmarks'**
  String get bookmarks;

  /// No description provided for @noFavorites.
  ///
  /// In en, this message translates to:
  /// **'You don\'t like anything '**
  String get noFavorites;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @selectAvatar.
  ///
  /// In en, this message translates to:
  /// **'Select Avatar'**
  String get selectAvatar;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferences;

  /// No description provided for @supportAndAccount.
  ///
  /// In en, this message translates to:
  /// **'SUPPORT & ACCOUNT'**
  String get supportAndAccount;

  /// No description provided for @helpAndSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpAndSupport;

  /// No description provided for @cairoEgypt.
  ///
  /// In en, this message translates to:
  /// **'Cairo, Egypt'**
  String get cairoEgypt;

  /// No description provided for @searchResults.
  ///
  /// In en, this message translates to:
  /// **'Search Results'**
  String get searchResults;

  /// No description provided for @listIsEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your list is empty'**
  String get listIsEmpty;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @moiAccepted.
  ///
  /// In en, this message translates to:
  /// **'MOI accepted'**
  String get moiAccepted;

  /// No description provided for @aboutUniversity.
  ///
  /// In en, this message translates to:
  /// **'About University'**
  String get aboutUniversity;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City:'**
  String get city;

  /// No description provided for @notAvailableCheckWebsite.
  ///
  /// In en, this message translates to:
  /// **'Not available check website'**
  String get notAvailableCheckWebsite;

  /// No description provided for @deadline.
  ///
  /// In en, this message translates to:
  /// **'Deadline:'**
  String get deadline;

  /// No description provided for @intake.
  ///
  /// In en, this message translates to:
  /// **'Intake:'**
  String get intake;

  /// No description provided for @university.
  ///
  /// In en, this message translates to:
  /// **'University:'**
  String get university;

  /// No description provided for @publicUniversity.
  ///
  /// In en, this message translates to:
  /// **'Public University'**
  String get publicUniversity;

  /// No description provided for @privateUniversity.
  ///
  /// In en, this message translates to:
  /// **'Private University'**
  String get privateUniversity;

  /// No description provided for @languageLevel.
  ///
  /// In en, this message translates to:
  /// **'Language Level'**
  String get languageLevel;

  /// No description provided for @requiresBlockAccount.
  ///
  /// In en, this message translates to:
  /// **'Requires block account'**
  String get requiresBlockAccount;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @requiresApsCertificate.
  ///
  /// In en, this message translates to:
  /// **'Requires APS certificate'**
  String get requiresApsCertificate;

  /// No description provided for @moiPolicy.
  ///
  /// In en, this message translates to:
  /// **'MOI policy'**
  String get moiPolicy;

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'Most Popular'**
  String get mostPopular;

  /// No description provided for @tuitionFees.
  ///
  /// In en, this message translates to:
  /// **'TUITION FEES'**
  String get tuitionFees;

  /// No description provided for @almostFree.
  ///
  /// In en, this message translates to:
  /// **'Almost free'**
  String get almostFree;

  /// No description provided for @studentWorkHours.
  ///
  /// In en, this message translates to:
  /// **'STUDENT WORK HOURS'**
  String get studentWorkHours;

  /// No description provided for @studentWorkHoursValue.
  ///
  /// In en, this message translates to:
  /// **'20 H/W'**
  String get studentWorkHoursValue;

  /// No description provided for @countryOverview.
  ///
  /// In en, this message translates to:
  /// **'Country Overview'**
  String get countryOverview;

  /// No description provided for @basicRequirements.
  ///
  /// In en, this message translates to:
  /// **'Basic requirements'**
  String get basicRequirements;

  /// No description provided for @stepsToStudy.
  ///
  /// In en, this message translates to:
  /// **'Steps to Study'**
  String get stepsToStudy;

  /// No description provided for @stepN.
  ///
  /// In en, this message translates to:
  /// **'Step {n}'**
  String stepN(Object n);

  /// No description provided for @linksWillHelpYou.
  ///
  /// In en, this message translates to:
  /// **'Links will help you'**
  String get linksWillHelpYou;

  /// No description provided for @embassy.
  ///
  /// In en, this message translates to:
  /// **'Embassy'**
  String get embassy;

  /// No description provided for @toMakeVisaAppointment.
  ///
  /// In en, this message translates to:
  /// **'To make a visa appointment'**
  String get toMakeVisaAppointment;

  /// No description provided for @vfs.
  ///
  /// In en, this message translates to:
  /// **'VFS'**
  String get vfs;

  /// No description provided for @toMakeLegalizationAppointment.
  ///
  /// In en, this message translates to:
  /// **'To make a legalization appointment'**
  String get toMakeLegalizationAppointment;

  /// No description provided for @embassyLocation.
  ///
  /// In en, this message translates to:
  /// **'Embassy Location'**
  String get embassyLocation;

  /// No description provided for @toAttendYourAppointment.
  ///
  /// In en, this message translates to:
  /// **'To attend your appointment'**
  String get toAttendYourAppointment;

  /// No description provided for @readyToStartJourney.
  ///
  /// In en, this message translates to:
  /// **'Ready to start your journey ?'**
  String get readyToStartJourney;

  /// No description provided for @findOpenProgramsAndApply.
  ///
  /// In en, this message translates to:
  /// **'find open programs and apply now'**
  String get findOpenProgramsAndApply;

  /// No description provided for @browsePrograms.
  ///
  /// In en, this message translates to:
  /// **'Browse Programs'**
  String get browsePrograms;

  /// No description provided for @exploreDestinations.
  ///
  /// In en, this message translates to:
  /// **'Explore Destinations'**
  String get exploreDestinations;

  /// No description provided for @verifyYourNumber.
  ///
  /// In en, this message translates to:
  /// **'Verify your number'**
  String get verifyYourNumber;

  /// No description provided for @getOtp.
  ///
  /// In en, this message translates to:
  /// **'Get Otp'**
  String get getOtp;

  /// No description provided for @enterNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter number'**
  String get enterNumber;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @recommendFeature.
  ///
  /// In en, this message translates to:
  /// **'Recommend feature'**
  String get recommendFeature;

  /// No description provided for @recommendFeatureMessage.
  ///
  /// In en, this message translates to:
  /// **'I want to recommend you a feature'**
  String get recommendFeatureMessage;

  /// No description provided for @noImageToPreview.
  ///
  /// In en, this message translates to:
  /// **'No image to preview'**
  String get noImageToPreview;

  /// No description provided for @notAvailableShort.
  ///
  /// In en, this message translates to:
  /// **'Not available'**
  String get notAvailableShort;

  /// No description provided for @germany.
  ///
  /// In en, this message translates to:
  /// **'Germany'**
  String get germany;

  /// No description provided for @austria.
  ///
  /// In en, this message translates to:
  /// **'Austria'**
  String get austria;

  /// No description provided for @otherEuropeanCountries.
  ///
  /// In en, this message translates to:
  /// **'Other European Countries'**
  String get otherEuropeanCountries;

  /// No description provided for @apsCertificateForEgyptians.
  ///
  /// In en, this message translates to:
  /// **'might require APS certificate for Egyptians'**
  String get apsCertificateForEgyptians;

  /// No description provided for @computerScience.
  ///
  /// In en, this message translates to:
  /// **'Computer Science'**
  String get computerScience;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @englishRequirementsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'English requirements not available'**
  String get englishRequirementsNotAvailable;

  /// No description provided for @germanLevelNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'German level not available'**
  String get germanLevelNotAvailable;

  /// No description provided for @semesters.
  ///
  /// In en, this message translates to:
  /// **'semesters'**
  String get semesters;

  /// No description provided for @cairo.
  ///
  /// In en, this message translates to:
  /// **'Cairo'**
  String get cairo;

  /// No description provided for @germanyDescription.
  ///
  /// In en, this message translates to:
  /// **'Germany offers world-class education with little or no tuition fees at public universities. Known for its strong engineering, research excellence, and robust economy, it is one of the top destinations for international students. Graduates also benefit from excellent post-study work opportunities.'**
  String get germanyDescription;

  /// No description provided for @germanyReq1.
  ///
  /// In en, this message translates to:
  /// **'APS Certificate (mandatory for Egyptian students)'**
  String get germanyReq1;

  /// No description provided for @germanyReq2.
  ///
  /// In en, this message translates to:
  /// **'Bachelor program: High school certificate + transcripts (translated & legalized)'**
  String get germanyReq2;

  /// No description provided for @germanyReq3.
  ///
  /// In en, this message translates to:
  /// **'Master program: Bachelor certificate + transcripts (translated & legalized)'**
  String get germanyReq3;

  /// No description provided for @germanyReq4.
  ///
  /// In en, this message translates to:
  /// **'Language certificate (IELTS / TOEFL / TestDaF) depending on program'**
  String get germanyReq4;

  /// No description provided for @germanyReq5.
  ///
  /// In en, this message translates to:
  /// **'Blocked account with approx. 11,208 EUR per year'**
  String get germanyReq5;

  /// No description provided for @germanyStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Choose your program and university'**
  String get germanyStep1Title;

  /// No description provided for @germanyStep1Desc.
  ///
  /// In en, this message translates to:
  /// **'Search for suitable programs and check admission requirements. Apply either through Uni-Assist or directly via the university portal.'**
  String get germanyStep1Desc;

  /// No description provided for @germanyStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Apply and receive admission'**
  String get germanyStep2Title;

  /// No description provided for @germanyStep2Desc.
  ///
  /// In en, this message translates to:
  /// **'Prepare translated and legalized documents. Submit before deadlines and wait for acceptance letter.'**
  String get germanyStep2Desc;

  /// No description provided for @germanyStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Open blocked account & apply for visa'**
  String get germanyStep3Title;

  /// No description provided for @germanyStep3Desc.
  ///
  /// In en, this message translates to:
  /// **'After receiving admission and APS certificate, open a blocked account and book an appointment at the German Embassy in Cairo.'**
  String get germanyStep3Desc;

  /// No description provided for @austriaDescription.
  ///
  /// In en, this message translates to:
  /// **'Austria offers high-quality education in the heart of Europe with affordable tuition fees at public universities. Many programs are taught in German, and students benefit from a safe environment, strong academic reputation, and central European lifestyle.'**
  String get austriaDescription;

  /// No description provided for @austriaReq1.
  ///
  /// In en, this message translates to:
  /// **'Bachelor program: High school certificate + transcripts (translated & legalized)'**
  String get austriaReq1;

  /// No description provided for @austriaReq2.
  ///
  /// In en, this message translates to:
  /// **'Master program: Bachelor certificate + transcripts (translated & legalized)'**
  String get austriaReq2;

  /// No description provided for @austriaReq3.
  ///
  /// In en, this message translates to:
  /// **'German language certificate (usually B2 level) or English certificate depending on program'**
  String get austriaReq3;

  /// No description provided for @austriaReq4.
  ///
  /// In en, this message translates to:
  /// **'Proof of sufficient financial means (approx. 8,000–12,000 EUR per year depending on age)'**
  String get austriaReq4;

  /// No description provided for @austriaReq5.
  ///
  /// In en, this message translates to:
  /// **'Residence Permit – Student application'**
  String get austriaReq5;

  /// No description provided for @austriaStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Choose your program and university'**
  String get austriaStep1Title;

  /// No description provided for @austriaStep1Desc.
  ///
  /// In en, this message translates to:
  /// **'Search for suitable programs and check specific language and admission requirements on the university website.'**
  String get austriaStep1Desc;

  /// No description provided for @austriaStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Submit application'**
  String get austriaStep2Title;

  /// No description provided for @austriaStep2Desc.
  ///
  /// In en, this message translates to:
  /// **'Prepare translated and legalized documents and apply directly through the university portal.'**
  String get austriaStep2Desc;

  /// No description provided for @austriaStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Apply for Residence Permit – Student'**
  String get austriaStep3Title;

  /// No description provided for @austriaStep3Desc.
  ///
  /// In en, this message translates to:
  /// **'After receiving admission, book an appointment at the Austrian Embassy in Cairo and apply for the residence permit.'**
  String get austriaStep3Desc;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @aboutUsContent.
  ///
  /// In en, this message translates to:
  /// **'Egy Assist helps you discover Master\'s programs across Europe. We provide filters by country, field of study, language, and requirements so you can find the right program and apply with confidence.\n\nOur goal is to make European higher education accessible and clear for students worldwide.'**
  String get aboutUsContent;

  /// No description provided for @privacyPolicyContent.
  ///
  /// In en, this message translates to:
  /// **'We respect your privacy. This app stores your account data and preferences to provide a personalized experience. We do not sell your data to third parties.\n\nData we may collect or store: account information (name, email, phone), saved programs, and app preferences. You can delete your account at any time from Settings.\n\nFor questions about data use, contact us through the app.'**
  String get privacyPolicyContent;

  /// No description provided for @termsAndConditionsContent.
  ///
  /// In en, this message translates to:
  /// **'By using Egy Assist you agree to use the app for personal, non-commercial purposes. Program information is provided for guidance; always verify details on official university websites before applying.\n\nWe are not responsible for admission decisions, visa outcomes, or changes to program requirements. You are responsible for the accuracy of your applications and compliance with local laws.'**
  String get termsAndConditionsContent;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountWarningTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get deleteAccountWarningTitle;

  /// No description provided for @deleteAccountWarningMessage.
  ///
  /// In en, this message translates to:
  /// **'This will permanently delete your account and all your data (profile, saved programs). You will not be able to recover it. This action cannot be undone.'**
  String get deleteAccountWarningMessage;

  /// No description provided for @deleteAccountConfirm.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deleteAccountConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @deleteAccountSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account deleted successfully'**
  String get deleteAccountSuccess;

  /// No description provided for @deleteAccountRequireRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'For security, please sign out and sign in again, then try deleting your account.'**
  String get deleteAccountRequireRecentLogin;

  /// No description provided for @guestCreateAccountToAccess.
  ///
  /// In en, this message translates to:
  /// **'You must create an account to access this section.'**
  String get guestCreateAccountToAccess;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
