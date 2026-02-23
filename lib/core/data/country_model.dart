import '../../l10n/app_localizations.dart';

enum VisaProcessType {
  embassy,
  vfs,
  mixed,
}

class CountryModel {
  final String countryName;
  final String embassyLocation;
  final List<StepModel>? countryStudySteps;
  final String? countryFlagPath;
  final String? imagePath;

  final VisaProcessType visaProcessType;
  final String? vfsLocation;
  final String? studyTuitionFeesState;
  final String? language;
  final String? studentWorkingHours;
  final String? embassyLocationLink;
  final String? embassyAppointmentLink;
  final String? vfsAppointmentLink;
  final String description;
  final List<String>? requirements;
  final int programsLength;

  CountryModel({
    this.embassyLocationLink,
    this.embassyAppointmentLink,
    this.vfsAppointmentLink,
    this.studyTuitionFeesState,
    this.language,
    this.studentWorkingHours,
    required this.description,
    this.requirements,
    this.countryFlagPath,
    this.imagePath,
    required this.visaProcessType,
    this.vfsLocation,
    required this.countryName,
    required this.embassyLocation,
    this.countryStudySteps,
    required this.programsLength,
  });
}

List<CountryModel> getCountries(AppLocalizations l10n) {
  return [
    CountryModel(
      countryName: l10n.germany,
      embassyLocation: l10n.cairo,
      vfsAppointmentLink: "https://www.vfsglobal.com/",
      language: "DE / EN",
      programsLength: 20,
      countryFlagPath: "assets/images/ge-fg.png",
      imagePath: "assets/images/ge-des.png",
      embassyLocationLink: "https://kairo.diplo.de/eg-en",
      embassyAppointmentLink: "https://service2.diplo.de/rktermin/extern/",
      visaProcessType: VisaProcessType.embassy,
      description: l10n.germanyDescription,
      requirements: [
        l10n.germanyReq1,
        l10n.germanyReq2,
        l10n.germanyReq3,
        l10n.germanyReq4,
        l10n.germanyReq5,
      ],
      countryStudySteps: [
        StepModel(
          title: l10n.germanyStep1Title,
          description: l10n.germanyStep1Desc,
        ),
        StepModel(
          title: l10n.germanyStep2Title,
          description: l10n.germanyStep2Desc,
        ),
        StepModel(
          title: l10n.germanyStep3Title,
          description: l10n.germanyStep3Desc,
        ),
      ],
    ),
    CountryModel(
      visaProcessType: VisaProcessType.embassy,
      countryName: l10n.austria,
      vfsAppointmentLink: "https://www.vfsglobal.com/",
      embassyLocation: l10n.cairo,
      language: "DE / EN",
      programsLength: 20,
      countryFlagPath: "assets/images/aus-fg.png",
      imagePath: "assets/images/aus-des.jpg",
      embassyLocationLink: "https://www.bmeia.gv.at/en/austrian-embassy-cairo/",
      embassyAppointmentLink: "https://appointment.bmeia.gv.at/",
      description: l10n.austriaDescription,
      requirements: [
        l10n.austriaReq1,
        l10n.austriaReq2,
        l10n.austriaReq3,
        l10n.austriaReq4,
        l10n.austriaReq5,
      ],
      countryStudySteps: [
        StepModel(
          title: l10n.austriaStep1Title,
          description: l10n.austriaStep1Desc,
        ),
        StepModel(
          title: l10n.austriaStep2Title,
          description: l10n.austriaStep2Desc,
        ),
        StepModel(
          title: l10n.austriaStep3Title,
          description: l10n.austriaStep3Desc,
        ),
      ],
    ),
  ];
}

class StepModel {
  final String title;
  final String description;

  StepModel({required this.title, required this.description});
}
