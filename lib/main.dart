import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => GetMaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.notoSansTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        // home:
      );
}
