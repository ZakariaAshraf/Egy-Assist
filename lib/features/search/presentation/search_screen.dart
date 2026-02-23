import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:study_path/features/filter/presentation/screens/filter_screen.dart';
import 'package:study_path/features/home/data/model/program_model.dart';
import '../../../l10n/app_localizations.dart';

import '../../../core/widgets/default_message_card.dart';
import '../../../core/widgets/university_item.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final BehaviorSubject<String> _searchQuerySubject = BehaviorSubject<String>();
  final BehaviorSubject<String> _categorySubject =
      BehaviorSubject<String>.seeded('All');

  Stream<List<ProgramModel>> fetchAllProperties() {
    return _searchQuerySubject.stream.switchMap((query) {
      if (query.trim().isEmpty && _categorySubject.value == 'All') {
        return Stream.value(<ProgramModel>[]);
      }
      return _firestore.collection('programs').snapshots().map((snapshot) {
        return snapshot.docs.map((doc) {
          return ProgramModel.fromJson({
            ...doc.data(),
            'id': doc.id,
          });
        }).toList();
      });
    });
  }

  List<ProgramModel> _filterProperties({
    required List<ProgramModel> properties,
    required String query,
    required String category,
  }) {
    List<ProgramModel> filtered = properties;
    if (query.trim().isEmpty && (category == 'All' || category.isEmpty)) {
      return [];
    }
    if (category.isNotEmpty && category != 'All') {
      filtered = filtered
          .where(
            (property) =>
                property.programName.toLowerCase() == category.toLowerCase(),
          )
          .toList();
    }
    if (query.isNotEmpty) {
      final lowerQuery = query.toLowerCase();
      filtered = filtered.where((property) {
        final universityMatch = property.universityName.toLowerCase().contains(lowerQuery);
        final programMatch = property.programName.toLowerCase().contains(lowerQuery);

        return universityMatch || programMatch;
      }).toList();
    }
    return filtered;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchQuerySubject.close();
    _categorySubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Search"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FilterScreen(),));
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.redAccent.withOpacity(0.1),
                  ),
                  child: Image.asset(
                    "assets/icons/ic_filter.png",
                    height: 18,
                    width: 18,
                    color: Colors.red,
                  ),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSearchTextField(
                style: Theme.of(context).textTheme.bodyLarge,
                decoration: BoxDecoration(
                  border: BoxBorder.all(color: Colors.grey),
                  borderRadius:BorderRadius.circular(12),
                ),
                controller: _searchController,
                onChanged: _searchQuerySubject.add,
              ),
            ),
            Expanded(
              child: StreamBuilder<List<ProgramModel>>(
                stream: Rx.combineLatest3(
                  fetchAllProperties(),
                  _searchQuerySubject.stream.startWith(''),
                  _categorySubject.stream,
                  (
                    List<ProgramModel> properties,
                    String query,
                    String category,
                  ) {
                    return _filterProperties(
                      properties: properties,
                      query: query,
                      category: category,
                    );
                  },
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Colors.grey,));
                  }
                  if (_searchController.text.isEmpty && (_categorySubject.value == 'All')) {
                    return DefaultMessageCard(
                      sign: "🔍",
                      title: l10n.startYourSearchNow,
                      subTitle: l10n.searchWithUniversityNameOrProgramName,
                    );
                  }
                  if (snapshot.hasError) {
                    return DefaultMessageCard(
                      sign: "!",
                      title: "${l10n.error}",
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return DefaultMessageCard(
                      sign: "!",
                      title: l10n.noResults,
                    );
                  }
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    itemBuilder: (context, index) {
                      return UniversityItem(program: snapshot.data![index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
