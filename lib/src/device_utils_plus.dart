import 'dart:io' show Platform;
import 'package:flutter/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Provides utilities for device, platform, and connectivity information.
class DeviceUtilsPlus {
  /// Returns true if the current platform is Android.
  static bool get isAndroid => !kIsWeb && Platform.isAndroid;

  /// Returns true if the current platform is iOS.
  static bool get isIOS => !kIsWeb && Platform.isIOS;

  /// Returns true if running on the Web.
  static bool get isWeb => kIsWeb;

  /// Returns true if running on Windows, macOS, or Linux.
  static bool get isDesktop =>
      !kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS);

  /// Returns true if running on a mobile device (Android or iOS).
  static bool get isMobile => isAndroid || isIOS;

  /// Fetches basic device information such as model, brand, OS version.
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    final plugin = DeviceInfoPlugin();
    if (kIsWeb) {
      final info = await plugin.webBrowserInfo;
      return {
        'platform': 'Web',
        'browserName': info.browserName.name,
        'userAgent': info.userAgent ?? '',
        'vendor': info.vendor ?? '',
      };
    } else if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      return {
        'platform': 'Android',
        'brand': info.brand,
        'model': info.model,
        'device': info.device,
        'version': info.version.release,
      };
    } else if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      return {
        'platform': 'iOS',
        'model': info.utsname.machine,
        'systemName': info.systemName,
        'systemVersion': info.systemVersion,
      };
    } else {
      final info = await plugin.deviceInfo;
      return {'platform': 'Unknown', 'info': info.toString()};
    }
  }

  /// Checks internet connectivity status.
  /// Returns `true` if connected to Wi-Fi or mobile data.
  static Future<bool> hasInternetConnection() async {
    final results = await Connectivity().checkConnectivity();
    return results.contains(ConnectivityResult.mobile) || 
           results.contains(ConnectivityResult.wifi);
  }

  /// Returns the current screen width.
  static double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;

  /// Returns the current screen height.
  static double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;

  /// Returns true if the screen is in portrait mode.
  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait;

  /// Returns true if the screen is in landscape mode.
  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;
}
