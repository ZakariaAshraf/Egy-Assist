import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/features/authenticate/presentation/manager/auth_cubit.dart';
import 'package:study_path/features/authenticate/presentation/pages/sign_in.dart';
import '../../../../core/generated/assets/assets_helper.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/character_item.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../Cubit/user_cubit.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  bool _showCharacterList = false;
  String? _displayCharPath;
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
      id: 'male_grad',
      imagePath: "assets/icons/mgrad.png",
      imageName: "Male Graduate",
    ),
    CharacterModel(
      id: 'female_grad',
      imagePath: "assets/icons/fgrad.png",
      imageName: "Female Graduate",
    ),
  ];

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getCurrentUserData();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void _showDeleteAccountDialog(BuildContext context, AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteAccountWarningTitle,style: TextStyle(color: Colors.red),),
        content: SingleChildScrollView(
          child: Text(l10n.deleteAccountWarningMessage),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<UserCubit>().deleteAccount();
            },
            style: FilledButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: Text(l10n.deleteAccountConfirm),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n!.editProfile)),
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserSuccess) {
            Navigator.pop(context);
          } else if (state is UserAccountDeleted) {
            context.read<AuthCubit>().signOut();
            if (context.mounted) {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const SignIn()),
                (route) => false,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.deleteAccountSuccess)),
              );
            }
          } else if (state is UserError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is UserError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  TextButton(
                    onPressed: () =>
                        context.read<UserCubit>().getCurrentUserData(),
                    child: Text(l10n.tryAgain),
                  ),
                ],
              ),
            );
          }
          final user = context.read<UserCubit>().user;

          if (user != null) {
            if (fullNameController.text.isEmpty) {
              fullNameController.text = user.name;
            }
            if (phoneController.text.isEmpty) {
              phoneController.text = user.phone;
            }
            if (_displayCharPath == null) {
              _displayCharPath = getCharacterAssetPath(user.charUrl);
            }
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                /// --- Image Section ---
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        backgroundColor: const Color(0xffe8d4d4),
                        radius: 60,
                        child: ClipOval(
                          child: Image.asset(
                            _displayCharPath ?? "assets/icons/logo.png",
                            fit: BoxFit.cover,
                            width: 120,
                            height: 120,
                            errorBuilder: (c, e, s) =>
                                const Icon(Icons.person, size: 60),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _showCharacterList = !_showCharacterList;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.blackSecondary,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),
                AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.infinity),
                  secondChild: Column(
                    children: [
                      Text(
                        l10n.selectAvatar,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        height: 200.h(context),
                        child: ListView.builder(
                          itemCount: characters.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CharacterItem(
                              showCharName: false,
                              height: 90,
                              width: 90,
                              character: characters[index],
                              isSelected: selectedIndex == index,
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  _displayCharPath =
                                      characters[index].imagePath;
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  crossFadeState: _showCharacterList
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: const Duration(milliseconds: 300),
                ),

                const SizedBox(height: 24),
                TextFormField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: l10n.fullName,
                    prefixIcon: const Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    labelText: l10n.phoneNumber,
                    prefixIcon: const Icon(Icons.phone),
                  ),
                ),

                const SizedBox(height: 24),

                /// --- Save Button ---
                CustomButton(
                  color: AppColors.blackSecondary,
                  title: l10n.saveChanges,
                  onTap: () {
                    String charToSend;
                    if (selectedIndex != -1) {
                      charToSend = characters[selectedIndex].id;
                    } else {
                      charToSend = user?.charUrl ?? "";
                    }
                    context.read<UserCubit>().updateProfile(
                      fullName: fullNameController.text,
                      phoneNumber: phoneController.text,
                      charPath: charToSend,
                    );
                  },
                ),
                const SizedBox(height: 24),

                CustomButton(
                  color: Colors.redAccent,
                  title: l10n.deleteAccount,
                  onTap: () => _showDeleteAccountDialog(context, l10n),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
