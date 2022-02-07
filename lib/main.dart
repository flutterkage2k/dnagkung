import 'package:beamer/beamer.dart';
import 'package:dnagkung/router/locations.dart';
import 'package:dnagkung/screens/start_screen.dart';
import 'package:dnagkung/screens/splash_screen.dart';
import 'package:dnagkung/states/user_provider.dart';
import 'package:dnagkung/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final _routeDelegate = BeamerDelegate(guards: [
  BeamGuard(
      pathBlueprints: ['/'],
      check: (context, location) {
        //context.read<어떤context를 가져오느냐>()
        return context.watch<UserProvider>().userState;
      },
      showPage: BeamPage(child: StartScreen()))
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
        future: Future.delayed(Duration(milliseconds: 300), () => 100),
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
    return ChangeNotifierProvider<UserProvider>(
      // 데이터 종류를 설정해야한다. <T>
      create: (BuildContext context) {
        return UserProvider();
      },
      child: MaterialApp.router(
          theme: ThemeData(
            primarySwatch: Colors.red,
            fontFamily: 'DoHyeon',
            hintColor: Colors.grey[350],
            textTheme: TextTheme(
              button: TextStyle(color: Colors.white),
              subtitle1: TextStyle(color: Colors.black87, fontSize: 15),
              subtitle2: TextStyle(color: Colors.grey, fontSize: 13),
              bodyText1: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.normal),
              bodyText2: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w100),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Colors.red,
                primary: Colors.white,
                minimumSize: Size(48, 48),
              ),
            ),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
                elevation: 2,
                centerTitle: false,
                titleTextStyle: TextStyle(
                  color: Colors.black87,
                  fontFamily: 'DoHyeon',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                actionsIconTheme: IconThemeData(color: Colors.black87)),
          ),
          routeInformationParser: BeamerParser(),
          routerDelegate: _routeDelegate),
    );
  }
}
