import 'package:beamer/beamer.dart';
import 'package:dnagkung/screens/home_screen.dart';
import 'package:flutter/widgets.dart';

class HomeLocation extends BeamLocation {
  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [BeamPage(child: HomeScreen(), key: ValueKey('home'))];
  }

  @override
  // TODO: implement pathBlueprints
  List get pathBlueprints => ['/'];
}
