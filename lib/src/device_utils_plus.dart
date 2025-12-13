import 'dart:io' show Platform;
import 'package:flutter/widgets.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

/// Provides utilities for device, platform, and connectivity information.
///
/// All methods include proper error handling and context validation.
class DeviceUtilsPlus {
  /// Returns true if the current platform is Android.
  static bool get isAndroid {
    try {
      return !kIsWeb && Platform.isAndroid;
    } catch (e) {
      return false;
    }
  }

  /// Returns true if the current platform is iOS.
  static bool get isIOS {
    try {
      return !kIsWeb && Platform.isIOS;
    } catch (e) {
      return false;
    }
  }

  /// Returns true if running on the Web.
  static bool get isWeb => kIsWeb;

  /// Returns true if running on Windows, macOS, or Linux.
  static bool get isDesktop {
    try {
      return !kIsWeb &&
          (Platform.isWindows || Platform.isLinux || Platform.isMacOS);
    } catch (e) {
      return false;
    }
  }

  /// Returns true if running on a mobile device (Android or iOS).
  static bool get isMobile => isAndroid || isIOS;

  /// Fetches basic device information such as model, brand, OS version.
  ///
  /// Returns a map with device information. If an error occurs, returns
  /// a map with 'platform': 'Unknown' and 'error' key containing the error message.
  ///
  /// Example:
  /// ```dart
  /// final info = await DeviceUtilsPlus.getDeviceInfo();
  /// print(info['platform']); // 'Android', 'iOS', 'Web', etc.
  /// ```
  static Future<Map<String, dynamic>> getDeviceInfo() async {
    try {
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
    } catch (e) {
      return {
        'platform': 'Unknown',
        'error': e.toString(),
      };
    }
  }

  /// Checks internet connectivity status.
  ///
  /// Returns `true` if connected to Wi-Fi or mobile data.
  /// Returns `false` if there's an error or no connection.
  ///
  /// Note: This only checks connectivity type, not actual internet access.
  /// For actual internet access verification, consider using NetworkUtilsPlus.
  ///
  /// Example:
  /// ```dart
  /// final hasConnection = await DeviceUtilsPlus.hasInternetConnection();
  /// ```
  static Future<bool> hasInternetConnection() async {
    try {
      final results = await Connectivity().checkConnectivity();
      return results.contains(ConnectivityResult.mobile) ||
          results.contains(ConnectivityResult.wifi);
    } catch (e) {
      return false;
    }
  }

  /// Returns the current screen width.
  ///
  /// Throws if [context] is invalid or MediaQuery is not available.
  static double screenWidth(BuildContext? context) {
    if (context == null) {
      throw ArgumentError.notNull('context');
    }
    return MediaQuery.of(context).size.width;
  }

  /// Returns the current screen height.
  ///
  /// Throws if [context] is invalid or MediaQuery is not available.
  static double screenHeight(BuildContext? context) {
    if (context == null) {
      throw ArgumentError.notNull('context');
    }
    return MediaQuery.of(context).size.height;
  }

  /// Returns true if the screen is in portrait mode.
  ///
  /// Throws if [context] is invalid or MediaQuery is not available.
  static bool isPortrait(BuildContext? context) {
    if (context == null) {
      throw ArgumentError.notNull('context');
    }
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  /// Returns true if the screen is in landscape mode.
  ///
  /// Throws if [context] is invalid or MediaQuery is not available.
  static bool isLandscape(BuildContext? context) {
    if (context == null) {
      throw ArgumentError.notNull('context');
    }
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}
