import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_path/core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/custom_toast_widget.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../home/presentation/screens/home_screen.dart';
import 'otp_authentication.dart';

class PhoneNumberValidation extends StatelessWidget {
  final String number;

  PhoneNumberValidation({super.key, required this.number});

  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final TextEditingController phoneController = TextEditingController(
      text: number,
    );

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(l10n.verifyYourNumber),
        actions: [TextButton(onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(),
              ));
        }, child: Text(l10n.skip))],
      ),
      body: Column(
        children: [
          CustomTextField(
            controller: phoneController,
            hintText: l10n.phoneNumber,
          ),
          SizedBox(height: 30),
          CustomButton(
            title: l10n.getOtp,
            onTap: () async {
              String number = phoneController.text.trim();
              if (number.isEmpty) {
                CustomToastWidget.show(
                  context: context,
                  title: l10n.enterNumber,
                  iconPath: "assets/icons/icon.png",
                );
              } else {
                try {
                  await auth.verifyPhoneNumber(
                    verificationCompleted: (phoneAuthCredential) {},
                    verificationFailed: (error) {},
                    codeSent: (otp, token) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtpAuthentication(otp: otp),
                        ),
                      );
                    },
                    codeAutoRetrievalTimeout: (otp) {},
                    phoneNumber: number,
                  );
                } on Exception catch (e) {
                  print(e.toString());
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
