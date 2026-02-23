import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_path/core/widgets/university_item.dart';
import '../../../../l10n/app_localizations.dart';

import '../../../../core/widgets/default_message_card.dart';
import '../../../home/presentation/cubit/programs_cubit.dart';

class SearchResultsScreen extends StatelessWidget {
  const SearchResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n!.searchResults),
      ),
      body: BlocBuilder<ProgramsCubit, ProgramsState>(
          builder: (context, state) {
            if (state is ProgramsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ProgramsLoaded) {
              return ListView.builder(
                itemCount: state.programs.length,
                itemBuilder: (context, index) {
                  final program = state.programs[index];
                  return UniversityItem(program: program);
                },
              );
            }else if (state is ProgramsLoadEmpty) {
              return DefaultMessageCard(
                sign: '0_0',
                title: l10n.listIsEmpty,
              );
            }else if (state is ProgramsError) {
              return DefaultMessageCard(
                sign: ':(',
                title: l10n.listIsEmpty,
              );
            }
            return Container();
          },
      ),
    );
  }
}
