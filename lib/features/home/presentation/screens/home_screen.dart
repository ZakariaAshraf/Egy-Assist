import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:study_path/features/home/presentation/widgets/saved_program_section.dart';
import 'package:study_path/features/home/presentation/widgets/user_info_section.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../../data/model/program_model.dart';
import '../widgets/explore_destination_section.dart';
import '../widgets/search_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      body: ListView(
        children: [
          UserInfoSection(),
          SizedBox(height: 10),
          SearchSection(),
          SizedBox(height: 10),
          // CustomButton(title: "title", onTap: () {
          //   uploadDataToFirebase();
          // },),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: BoxBorder.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                leading: IconButton(
                  icon: Icon(Icons.school_outlined),
                  onPressed: () {},
                  color: Colors.purple,
                ),
                subtitle: Text(
                  l10n.directScholarshipApplications,
                  style: theme.bodySmall!.copyWith(
                    fontSize: 15,
                  ),
                ),
                title: Text(
                  l10n.comingSoon,
                  style: theme.titleMedium!.copyWith(
                    color: Colors.purple,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(child: SavedProgramSection()),
          SizedBox(height: 10),
          SizedBox(child: ExploreDestinationSection()),
          SizedBox(height: 20),

        ],
      ),
    );
  }
  Future<void> uploadDataToFirebase() async {
    try {
      print("🚀 Starting Upload...");

      // 1. قراءة الملف من الـ Assets
      final String response = await rootBundle.loadString('assets/data.json');
      final List<dynamic> data = json.decode(response);

      // 2. الرفع لـ Firestore
      final CollectionReference programsCollection =
      FirebaseFirestore.instance.collection('programs');

      int count = 0;
      WriteBatch batch = FirebaseFirestore.instance.batch();

      for (var item in data) {
        // تحويل الـ JSON لـ Model
        ProgramModel program = ProgramModel.fromJson(item);

        // تجهيز الداتا للرفع
        DocumentReference docRef = programsCollection.doc(); // Auto-ID
        batch.set(docRef, program.toJson());

        count++;

        // Firebase Batch limit is 500 operations
        // لو الداتا كبيرة بنقسمها
        if (count % 400 == 0) {
          await batch.commit();
          batch = FirebaseFirestore.instance.batch();
          print("💾 Committed batch of 400...");
        }
      }

      // رفع الباقي
      await batch.commit();

      print("✅ Success! Uploaded $count programs.");

    } catch (e) {
      print("❌ Error uploading data: $e");
    }
  }
}
