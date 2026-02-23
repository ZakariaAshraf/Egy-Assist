import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/cache/cache_helper.dart';
import 'package:study_path/core/widgets/guest_restricted_overlay.dart';
import 'package:study_path/features/settings/presentation/screens/setting_screen.dart';
import 'package:study_path/l10n/app_localizations.dart';
import '../Cubit/user_cubit.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    final isGuest = CacheHelper.getBool(key: CacheKeys.isGuestMode) == true;
    if (isGuest) {
      final l10n = AppLocalizations.of(context)!;
      return GuestRestrictedScreen(title: l10n.profile);
    }
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            return SettingScreen(
              name: state.user.name,
              phone: state.user.phone,
              photoUrl: state.user.charUrl,
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          } else {
            return Container();
          }
        },
      ),
    );
  }
}