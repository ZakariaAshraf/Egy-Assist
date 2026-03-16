import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../data/model/program_model.dart';

part 'programs_state.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  ProgramsCubit() : super(ProgramsInitial());
  final FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  /// Fetch programs based on country, study field, degree type, MOI flag and language.
  /// `language` is applied in-memory so we can support special rules,
  /// e.g. for Germany include programs where language is empty.
  Future<void> getPrograms({
    required String country,
    bool? onlyMoi,
    required String studyField,
    required String degreeType,
    String language = '',
  }) async {
    emit(ProgramsLoading());
    try {
      Query query = _firestoreInstance.collection('programs');

      if (country.isNotEmpty) {
        query = query.where('country', isEqualTo: country);
      }
      if (studyField.isNotEmpty) {
        query = query.where('study_field', isEqualTo: studyField);
      }
      if (degreeType.isNotEmpty) {
        query = query.where('degree_type', isEqualTo: degreeType);
      }

      // MOI (Medium of Instruction) is meaningful for **English-taught**
      // programs only. If the user selects German (or any non-English language),
      // we ignore the MOI switch so that German programs are not filtered
      // incorrectly by `moi_accepted`.
      final trimmedLanguage = language.trim().toLowerCase();
      final shouldFilterByMoi =
          onlyMoi == true && (trimmedLanguage.isEmpty || trimmedLanguage == 'english');

      if (shouldFilterByMoi) {
        query = query.where('moi_accepted', isEqualTo: true);
      }

      final snapshot = await query.get();

      var programs = snapshot.docs
          .map((doc) => ProgramModel.fromFirestore(doc))
          .toList();

      // Apply language filtering in-memory.
      // Programs with empty/missing language are always kept,
      // so that incomplete data (\"\" language) still shows in results.
      if (trimmedLanguage.isNotEmpty) {
        final target = trimmedLanguage;
        programs = programs.where((p) {
          final lang = (p.language ?? '').trim().toLowerCase();
          if (lang.isEmpty) {
            // Keep programs where language is not set in the data.
            return true;
          }
          return lang == target;
        }).toList();
      }

      if (programs.isEmpty) {
        emit(ProgramsLoadEmpty(programs));
      } else {
        emit(ProgramsLoaded(programs));
      }
    } catch (e) {
      emit(ProgramsError(errorMsg: e.toString()));
    }
  }
}
