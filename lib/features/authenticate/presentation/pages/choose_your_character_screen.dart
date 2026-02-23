import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/cache/cache_helper.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/core/widgets/character_item.dart';
import 'package:study_path/core/widgets/custom_button.dart';
import 'package:study_path/l10n/app_localizations.dart';
import 'package:study_path/main.dart';

import '../manager/auth_cubit.dart';

class ChooseYourCharacterScreen extends StatefulWidget {
  final String email;
  final String password;
  final String name;
  final String phoneNumber;
  const ChooseYourCharacterScreen({super.key, required this.email, required this.password, required this.name, required this.phoneNumber});

  @override
  State<ChooseYourCharacterScreen> createState() =>
      _ChooseYourCharacterScreenState();
}

int selectedIndex = -1;
final List<CharacterModel> characters = [
  CharacterModel(
    id: "male_student",
    imagePath: "assets/icons/mstudent.png",
    imageName: "Male Student",

  ),
  CharacterModel(
    id: "female_student",
    imagePath: "assets/icons/fstudent.png",
    imageName: "Female Student",
  ),
  CharacterModel(
    id:  'male_grad',
    imagePath: "assets/icons/mgrad.png",
    imageName: "Male Graduate",
  ),
  CharacterModel(
    id:   'female_grad',
    imagePath: "assets/icons/fgrad.png",
    imageName: "Female Graduate",
  ),
];

class _ChooseYourCharacterScreenState extends State<ChooseYourCharacterScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    bool isButtonEnabled = selectedIndex != -1;
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            CacheHelper.set(key: CacheKeys.isGuestMode, value: false);
            Navigator.pushNamedAndRemoveUntil(
              context,
              "/main_screen",
              (route) => false,
            );
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(l10n!.registerFailed)));
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Choose Your Character",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28.0.sp(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h(context)),
                  Text(
                    '''Select the profile that best describes you to personalize your journey to Europe.''',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0.sp(context),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 20.h(context)),
                  SizedBox(
                    height: 500.h(context),
                    child: GridView.builder(
                      itemCount: characters.length,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return CharacterItem(
                          character: characters[index],
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                        );
                      },
                    ),
                  ),
                  CustomButton(
                    title: l10n.continuee,
                    color: isButtonEnabled
                        ? Colors.black
                        : Colors.grey.shade400,
                    onTap: isButtonEnabled
                        ? () {
                      context.read<AuthCubit>().register(
                          characterPath:characters[selectedIndex].id,
                          email: widget.email,
                          password: widget.password,
                          phone: widget.phoneNumber,
                          name: widget.name,);
                          }
                        : () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  l10n.pleaseSelectCharacter,
                                ),
                              ),
                            );
                          },
                    width: 370.h(context),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
