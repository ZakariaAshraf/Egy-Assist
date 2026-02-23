import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/cache/cache_helper.dart';
import 'package:study_path/core/widgets/guest_restricted_overlay.dart';
import 'package:study_path/core/widgets/university_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/widgets/default_message_card.dart';
import '../cubit/favourite_cubit.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({super.key});

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isGuest = CacheHelper.getBool(key: CacheKeys.isGuestMode) == true;
    if (isGuest) {
      return GuestRestrictedScreen(title: l10n.bookmarks);
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.bookmarks), centerTitle: true),
      body: BlocBuilder<FavouriteCubit, FavouriteState>(
        builder: (context, state) {
          // if (state is FavouriteInitial) {
          //   return DefaultMessageCard(
          //     sign: '0_0',
          //     title: l10n.noFavorites,
          //     subTitle: l10n.favorite,
          //   );
          // } else
            if (state is FavouriteLoading) {
            return const Center(child: CircularProgressIndicator(color: Colors.black54,));
          } else if (state is FavouriteSuccess) {
              if (state.programmes.isEmpty) {
                return DefaultMessageCard(
                  sign: '📪',
                  title: l10n.noFavorites,
                  // subTitle: l10n.favorite,
                );
              }else {
                return GridView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return UniversityCard(program:state.programmes[index]);
                  },
                  itemCount: state.programmes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,

                    childAspectRatio: 0.75,
                  ),
                );
              }
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () => context.read<FavouriteCubit>().loadFavorites(),
                child: Text(l10n.reloadPage),
              ),
            );
          }
        },
      ),
    );
  }
}
