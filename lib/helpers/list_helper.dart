// Packages:
import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Helpers:

// Utilities:

class ListHelper {
  // Returns a random object from a given List:
  static dynamic randomFromList(List<dynamic> list) {
    return list[Random().nextInt(list.length)];
  }
}
