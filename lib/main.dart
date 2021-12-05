import 'package:beamer/beamer.dart';
import 'package:dnagkung/router/locations.dart';
import 'package:dnagkung/screens/auth_screen.dart';
import 'package:dnagkung/screens/splash_screen.dart';
import 'package:dnagkung/utils/logger.dart';
import 'package:flutter/material.dart';

final _routeDelegate = BeamerDelegate(guards: [
  BeamGuard(
      pathBlueprints: ['/'],
      check: (context, location) {
        return false;
      },
      showPage: BeamPage(child: AuthScreen()))
], locationBuilder: BeamerLocationBuilder(beamLocations: [HomeLocation()]));

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  logger.d('My first log by logger!!');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.delayed(Duration(seconds: 3), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _splashLoadingWidget(snapshot));
        });
  }

  StatelessWidget _splashLoadingWidget(AsyncSnapshot<Object?> snapshot) {
    if (snapshot.hasError) {
      // print('error occur while loading.');
      return Text('Error occur');
    } else if (snapshot.hasData) {
      return TomatoApp();
    } else {
      return SplashScreen();
    }
  }
}

class TomatoApp extends StatelessWidget {
  const TomatoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: BeamerParser(), routerDelegate: _routeDelegate);
  }
}
