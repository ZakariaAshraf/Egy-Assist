import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/cache/cache_helper.dart';
import 'package:study_path/core/utils/screen_util.dart';
import 'package:study_path/core/widgets/guest_restricted_overlay.dart';
import 'package:study_path/core/widgets/university_card.dart';
import 'package:study_path/features/favorite/cubit/favourite_cubit.dart';
import 'package:study_path/features/favorite/views/favourite_screen.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../core/widgets/default_message_card.dart';

class SavedProgramSection extends StatelessWidget {
  const SavedProgramSection({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context)!;
    final isGuest = CacheHelper.getBool(key: CacheKeys.isGuestMode) == true;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(l10n.savedPrograms, style: theme.titleLarge),
              if (!isGuest)
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FavouriteScreen()));
                  },
                  child: Text(
                    l10n.seeAll,
                    style: theme.titleMedium!.copyWith(color: Colors.blue),
                  ),
                ),
            ],
          ),
        ),
        if (isGuest)
          GuestRestrictedBlurOverlay(
            minHeight: 220,
            child: Container(
              color: Theme.of(context).colorScheme.surfaceContainerHighest,
            ),
          )
        else
        BlocBuilder<FavouriteCubit, FavouriteState>(
          builder: (context, state) {
            // if (state is FavouriteInitial) {
            //   return DefaultMessageCard(
            //     sign: '📪',
            //     title: l10n.noSavedPrograms,
            //     subTitle: l10n.favorite,
            //   );
            // } else
              if (state is FavouriteLoading) {
              return const Center(child: CircularProgressIndicator(color: Colors.black54,));
            } else if (state is FavouriteSuccess) {
              if (state.programmes.isEmpty) {
                return DefaultMessageCard(
                  sign: '📪',
                  title: l10n.noSavedPrograms,
                );
              }else {
                return SizedBox(
                height: 300.h(context), width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.programmes.isEmpty ? 0 : 1,
                  itemBuilder: (context, index) => UniversityCard(program: state.programmes[index],),
                ),
              );
              }
            }else {
              return Center(
                child: ElevatedButton(
                  onPressed: () => context.read<FavouriteCubit>().loadFavorites(),
                  child: Text(l10n.reloadPage),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
