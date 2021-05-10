// Packages:
import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Helpers:

// Utilities:

class DeviceHelper {
  // ***********************************************************************************
  // *                * * *  D I S P L A Y  D I M E N T I O N S  * * *                 *
  // ***********************************************************************************

  // Returns the total amount of pixels in the vertical axis of the device:
  static double totalVerticalHeight({BuildContext context}) {
    return MediaQuery.of(context).size.height;
  }

  // Returns the amount of pixels already used by the Status Bar in the vertical axis of the device:
  static double statusBarTopPadding({BuildContext context}) {
    return MediaQuery.of(context).padding.top;
  }

  // Returns the amount of available pixels in the vertical axis of the device:
  static double availableHeight({BuildContext context, double appBarHeight = 0}) {
    return MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - appBarHeight;
  }

  // ***********************************************************************************
  // *                   * * *  D I S P L A Y  D E N S I T Y  * * *                    *
  // ***********************************************************************************

  // Returns how much text output in the app should be scaled. Users can change this in their mobile phone / device settings.
  static double curScaleFactor(BuildContext context) {
    return MediaQuery.of(context).textScaleFactor;
  }

  // ***********************************************************************************
  // *                  * * *  D I S P L A Y  P O S I T I O N  * * *                   *
  // ***********************************************************************************

  // Returns if either the device is in Landscape position or not (the usual way).
  static bool isSimpleLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  // Returns if either the device is in Landscape position or not.
  static bool isLandscape(NativeDeviceOrientation orientation) {
    return (orientation == NativeDeviceOrientation.landscapeRight || orientation == NativeDeviceOrientation.landscapeLeft);
  }

  // Returns if the device is in LandscapeLeft position or not.
  static bool isLandscapeLeft(NativeDeviceOrientation orientation) {
    return (orientation == NativeDeviceOrientation.landscapeLeft);
  }

  // Returns if the device is in LandscapeRight position or not.
  static bool isLandscapeRight(NativeDeviceOrientation orientation) {
    return (orientation == NativeDeviceOrientation.landscapeRight);
  }

  // Returns if either the device is in Portrait position or not (the usual way).
  static bool isSimplePortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  // Returns if either the device is in Portrait position or not.
  static bool isPortrait(NativeDeviceOrientation orientation) {
    return (orientation == NativeDeviceOrientation.portraitDown || orientation == NativeDeviceOrientation.portraitUp);
  }

  // Returns if the device is in PortraitUp position or not.
  static bool isPortraitUp(NativeDeviceOrientation orientation) {
    return (orientation == NativeDeviceOrientation.portraitUp);
  }

  // Returns if the device is in PortraitDown position or not.
  static bool isPortraitDown(NativeDeviceOrientation orientation) {
    return (orientation == NativeDeviceOrientation.portraitDown);
  }
}
