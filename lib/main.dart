import 'package:dnagkung/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(fontFamily: 'DoHyeon'),
      home: const Root(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}

class Root extends StatelessWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: Duration(seconds: 3), child: _splashLoading(snapshot));
        });
  }

  StatelessWidget _splashLoading(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      // print('error occur while loading.');
      Get.snackbar("error", "error occur while loading");
    } else if (snapshot.hasData) {
      return HomePage();
    } else {
      return SplashScreen();
    }
    return HomePage();
  }
}
