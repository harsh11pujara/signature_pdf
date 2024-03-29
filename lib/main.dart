import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:signature_pdf/view_pdf_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(MobileAds.instance.initialize());
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? pickedPDF;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                ///Pick PDF from device
                pickPDF();
              },
              child: const Text("Select a PDF"),
            ),
          )
        ),
      ),
    );
  }

  Future<void> pickPDF() async {
    await FilePicker.platform.pickFiles(allowMultiple: false).then((pickedFile) {
      if (pickedFile != null) {
        debugPrint("files $pickedFile");
        if (pickedFile.files.isNotEmpty) {
          // File picked
          PlatformFile selectedFile = pickedFile.files[0];
          pickedPDF = File(selectedFile.path.toString());
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewPDFPage(pdf: pickedPDF!),
              ));
        } else {
          // No file Picked
        }
      }
    });
  }
}
