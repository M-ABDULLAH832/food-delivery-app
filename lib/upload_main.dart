import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'data/upload_foods.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const UploadApp());
}

class UploadApp extends StatefulWidget {
  const UploadApp({super.key});

  @override
  State<UploadApp> createState() => _UploadAppState();
}

class _UploadAppState extends State<UploadApp> {
  String message = 'Uploading foods...';

  @override
  void initState() {
    super.initState();
    upload();
  }

  Future<void> upload() async {
    try {
      await uploadFoods();

      if (!mounted) return;

      setState(() {
        message = 'All 24 foods uploaded successfully!';
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        message = 'Upload failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}