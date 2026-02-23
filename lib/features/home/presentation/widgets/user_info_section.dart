import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/cache/cache_helper.dart';
import 'package:study_path/core/widgets/custom_toast_widget.dart';
import 'package:study_path/core/widgets/guest_restricted_overlay.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../core/generated/assets/assets_helper.dart';
import '../../../settings/presentation/Cubit/user_cubit.dart';

class UserInfoSection extends StatefulWidget {
  const UserInfoSection({super.key});

  @override
  State<UserInfoSection> createState() => _UserInfoSectionState();
}

class _UserInfoSectionState extends State<UserInfoSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isGuest = CacheHelper.getBool(key: CacheKeys.isGuestMode) == true;
    if (isGuest) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Theme.of(context).colorScheme.outline.withOpacity(0.3)),
              ),
              child: GuestRestrictedContent(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                messageStyle: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ),
        ),
      );
    }
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoaded) {
          String imagePath = getCharacterAssetPath(state.user.charUrl);
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              children: [
                ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Color(0xffe8d4d4),
                        radius: 30,
                        child: ClipOval(
                          child: Image.asset(
                            imagePath,
                            fit: BoxFit.cover,
                            width: 60,
                            height: 60,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          // height: 40,
                          // width: 64.w(context),
                          // padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            border: BoxBorder.all(color: Colors.white),
                            shape: BoxShape.circle,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                                size: 12,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(state.user.name, style: theme.titleLarge),
                  title: Text(
                    l10n.welcomeBack,
                    style: theme.titleMedium!.copyWith(color: Colors.grey),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.notifications_none_rounded,color: Colors.grey,),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => NotificationScreen(),
                      //   ),
                      // );
                      CustomToastWidget.show(context: context, title: l10n.willBeAvailableSoon, iconPath: "assets/icons/icon.png");
                    },
                  ),
                ),
              ],
            ),
          );
        } else if (state is UserError) {
          return Center(child: Text(state.message));
        } else {
          return Container();
        }
      },
    );
  }
}
