# Smart Utils Plus - Improvements & New Features

## 🔧 IMPROVEMENTS NEEDED

### 1. **Error Handling & Input Validation**

#### StringUtilsPlus
- ❌ `capitalize()` - Doesn't handle null input, multi-byte characters (emoji, accented chars)
- ❌ `slugify()` - No null check, could fail on special characters
- ❌ `truncate()` - No validation for negative maxLength
- ❌ `isEmail()` - Regex is too permissive, doesn't handle edge cases
- ❌ `isUrl()` - Regex is basic, doesn't validate actual URL structure

**Suggested Fixes:**
```dart
static String capitalize(String? input) {
  if (input == null || input.isEmpty) return input ?? '';
  // Handle multi-byte characters properly
  return input[0].toUpperCase() + input.substring(1);
}

static String truncate(String input, int maxLength, {String suffix = '...'}) {
  assert(maxLength >= 0, 'maxLength must be non-negative');
  if (input.length <= maxLength) return input;
  // Smart truncation at word boundaries
  if (maxLength <= suffix.length) return suffix;
  return input.substring(0, maxLength - suffix.length) + suffix;
}
```

#### DateUtilsPlus
- ❌ No null safety checks
- ❌ No timezone handling
- ❌ `diffSummary()` - Doesn't handle negative differences (future dates)
- ❌ Missing locale support for internationalization

**Suggested Fixes:**
```dart
static String diffSummary(DateTime start, DateTime end, {bool absolute = true}) {
  final diff = absolute ? end.difference(start).abs() : end.difference(start);
  // ... rest of implementation
}
```

#### WidgetUtilsPlus
- ❌ No context validation (could throw if context is invalid)
- ❌ Toast overlay entries not properly cleaned up (memory leak)
- ❌ Loader doesn't check if context is still mounted
- ❌ No error handling for missing ScaffoldMessenger

**Suggested Fixes:**
```dart
static void showSnackbar(BuildContext context, {...}) {
  if (!context.mounted) return;
  final messenger = ScaffoldMessenger.maybeOf(context);
  if (messenger == null) {
    LoggerPlus.warning('No ScaffoldMessenger found in context');
    return;
  }
  // ... rest of implementation
}
```

#### DeviceUtilsPlus
- ❌ `getDeviceInfo()` - No error handling for platform exceptions
- ❌ `hasInternetConnection()` - Only checks connectivity type, not actual internet access
- ❌ Screen utilities don't validate context

**Suggested Fixes:**
```dart
static Future<Map<String, dynamic>> getDeviceInfo() async {
  try {
    // ... existing code
  } catch (e) {
    LoggerPlus.error('Failed to get device info: $e');
    return {'platform': 'Unknown', 'error': e.toString()};
  }
}
```

### 2. **Code Quality Issues**

#### LoggerPlus
- ❌ No log levels (can't filter by severity)
- ❌ No file logging option
- ❌ No structured logging (JSON format)
- ❌ Timestamp format is verbose (ISO8601)

**Suggested Improvements:**
```dart
enum LogLevel { debug, info, success, warning, error }

class LoggerPlus {
  static LogLevel minLevel = LogLevel.debug;
  static String? logFilePath;
  
  static void _printLog(LogLevel level, String message, String color) {
    if (level.index < minLevel.index) return;
    // ... implementation with file logging support
  }
}
```

#### ContextSizeHelper
- ❌ No null safety documentation
- ❌ Could throw if RenderBox is not available
- ❌ Missing defensive checks

### 3. **Test Coverage Gaps**

- ❌ Missing edge case tests (null, empty, negative values)
- ❌ Missing negative test cases (invalid inputs)
- ❌ No integration tests
- ❌ No widget tests for WidgetUtilsPlus
- ❌ No platform-specific tests for DeviceUtilsPlus

**Missing Tests:**
- StringUtils: null inputs, empty strings, special characters, unicode
- DateUtils: timezone differences, leap years, edge dates
- WidgetUtils: context validation, error scenarios
- DeviceUtils: platform-specific behavior

### 4. **Documentation Issues**

- ❌ Missing dartdoc comments for parameters
- ❌ No code examples in documentation
- ❌ Missing `@throws` annotations
- ❌ No migration guide
- ❌ README import path is wrong (`smart_utils.dart` vs `smart_utils_plus.dart`)

### 5. **Performance Considerations**

- ❌ `slugify()` creates multiple regex replacements (could be optimized)
- ❌ Toast overlay entries accumulate (memory leak)
- ❌ Date formatting could cache formatters
- ❌ No lazy initialization for device info

---

## 🚀 NEW FEATURES TO INTRODUCE

### 1. **NumberUtilsPlus** ⭐ HIGH PRIORITY
Common number formatting and manipulation utilities.

```dart
class NumberUtilsPlus {
  // Format numbers
  static String formatCurrency(double amount, {String symbol = '\$', int decimals = 2});
  static String formatCompact(double number); // 1.2K, 1.5M
  static String formatPercentage(double value, {int decimals = 1});
  
  // Parsing
  static double? parseDouble(String? input);
  static int? parseInt(String? input);
  
  // Validation
  static bool isNumeric(String? input);
  static bool isInteger(String? input);
  
  // Math utilities
  static double clamp(double value, double min, double max);
  static double lerp(double a, double b, double t);
  static int randomInt(int min, int max);
  static double randomDouble(double min, double max);
  
  // Rounding
  static double roundTo(double value, int decimals);
  static double floorTo(double value, int decimals);
  static double ceilTo(double value, int decimals);
}
```

### 2. **ColorUtilsPlus** ⭐ HIGH PRIORITY
Color manipulation and conversion utilities.

```dart
class ColorUtilsPlus {
  // Conversion
  static Color? hexToColor(String hex);
  static String colorToHex(Color color, {bool includeAlpha = false});
  static Color rgbToColor(int r, int g, int b, {int a = 255});
  
  // Manipulation
  static Color lighten(Color color, double amount);
  static Color darken(Color color, double amount);
  static Color blend(Color color1, Color color2, double ratio);
  
  // Utilities
  static bool isDark(Color color);
  static Color getContrastColor(Color color);
  static Color getReadableTextColor(Color backgroundColor);
  
  // Material Design
  static List<Color> generateMaterialPalette(Color baseColor);
}
```

### 3. **ValidationUtilsPlus** ⭐ HIGH PRIORITY
Form validation helpers.

```dart
class ValidationUtilsPlus {
  // Common validators
  static String? validateEmail(String? value);
  static String? validatePhone(String? value, {String? countryCode});
  static String? validatePassword(String? value, {int minLength = 8});
  static String? validateUrl(String? value);
  static String? validateRequired(String? value, {String? fieldName});
  static String? validateMinLength(String? value, int minLength);
  static String? validateMaxLength(String? value, int maxLength);
  static String? validateRange(num? value, num min, num max);
  static String? validateCreditCard(String? value);
  static String? validateDate(DateTime? value, {DateTime? min, DateTime? max});
  
  // Combined validators
  static List<String?> validateAll(Map<String, String? Function()> validators);
}
```

### 4. **StorageUtilsPlus** ⭐ HIGH PRIORITY
SharedPreferences wrapper with type safety.

```dart
class StorageUtilsPlus {
  static Future<bool> setString(String key, String value);
  static Future<String?> getString(String key);
  static Future<bool> setInt(String key, int value);
  static Future<int?> getInt(String key);
  static Future<bool> setBool(String key, bool value);
  static Future<bool?> getBool(String key);
  static Future<bool> setDouble(String key, double value);
  static Future<double?> getDouble(String key);
  static Future<bool> setStringList(String key, List<String> value);
  static Future<List<String>?> getStringList(String key);
  static Future<bool> remove(String key);
  static Future<bool> clear();
  static Future<bool> containsKey(String key);
  
  // JSON helpers
  static Future<bool> setJson(String key, Map<String, dynamic> value);
  static Future<Map<String, dynamic>?> getJson(String key);
}
```

### 5. **DebounceUtilsPlus** ⭐ MEDIUM PRIORITY
Debounce and throttle utilities for performance.

```dart
class DebounceUtilsPlus {
  static Timer? _debounceTimer;
  
  static void debounce(Duration delay, VoidCallback callback);
  static void cancelDebounce();
}

class ThrottleUtilsPlus {
  static DateTime? _lastExecution;
  
  static void throttle(Duration delay, VoidCallback callback);
}
```

### 6. **FileUtilsPlus** ⭐ MEDIUM PRIORITY
File and path utilities.

```dart
class FileUtilsPlus {
  // Path utilities
  static String getFileName(String path);
  static String getFileExtension(String path);
  static String getDirectory(String path);
  static String joinPaths(String part1, String part2);
  
  // File operations
  static Future<bool> fileExists(String path);
  static Future<int> getFileSize(String path);
  static Future<String> readFileAsString(String path);
  static Future<Uint8List> readFileAsBytes(String path);
  static Future<void> writeFile(String path, String content);
  static Future<void> deleteFile(String path);
  
  // Formatting
  static String formatFileSize(int bytes);
  static String getMimeType(String path);
}
```

### 7. **NetworkUtilsPlus** ⭐ MEDIUM PRIORITY
Network and API helpers.

```dart
class NetworkUtilsPlus {
  // Connectivity
  static Stream<ConnectivityResult> connectivityStream();
  static Future<bool> hasActiveConnection();
  static Future<bool> canReachUrl(String url);
  
  // API helpers
  static Future<Map<String, dynamic>?> getJson(
    String url, {
    Map<String, String>? headers,
    Duration? timeout,
  });
  
  static Future<Map<String, dynamic>?> postJson(
    String url, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Duration? timeout,
  });
  
  // Retry logic
  static Future<T> retry<T>(
    Future<T> Function() operation, {
    int maxAttempts = 3,
    Duration delay = const Duration(seconds: 1),
  });
}
```

### 8. **Extension Methods** ⭐ MEDIUM PRIORITY
Convenient extensions for common types.

```dart
// String extensions
extension StringExtensions on String {
  bool get isEmail => StringUtilsPlus.isEmail(this);
  bool get isUrl => StringUtilsPlus.isUrl(this);
  String get capitalized => StringUtilsPlus.capitalize(this);
  String get slugified => StringUtilsPlus.slugify(this);
  String truncate(int maxLength) => StringUtilsPlus.truncate(this, maxLength);
}

// DateTime extensions
extension DateTimeExtensions on DateTime {
  String get timeAgo => DateUtilsPlus.timeAgo(this);
  String get smartDateTime => DateUtilsPlus.smartDateTime(this);
  bool get isToday => DateUtilsPlus.isToday(this);
  bool get isYesterday => DateUtilsPlus.isYesterday(this);
}

// BuildContext extensions (additional)
extension ContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  NavigatorState get navigator => Navigator.of(this);
  ScaffoldState? get scaffold => Scaffold.maybeOf(this);
}
```

### 9. **ImageUtilsPlus** ⭐ LOW PRIORITY
Image manipulation helpers.

```dart
class ImageUtilsPlus {
  static Future<Uint8List?> compressImage(
    Uint8List imageBytes, {
    int quality = 85,
    int? maxWidth,
    int? maxHeight,
  });
  
  static Future<Size> getImageSize(String imagePath);
  static Future<Uint8List?> resizeImage(
    Uint8List imageBytes, {
    required int width,
    required int height,
  });
  
  static String? getImageFormat(Uint8List imageBytes);
}
```

### 10. **PermissionUtilsPlus** ⭐ LOW PRIORITY
Permission handling helpers.

```dart
class PermissionUtilsPlus {
  static Future<bool> requestCameraPermission();
  static Future<bool> requestLocationPermission();
  static Future<bool> requestStoragePermission();
  static Future<bool> requestMicrophonePermission();
  static Future<Map<Permission, PermissionStatus>> requestMultiple(
    List<Permission> permissions,
  );
}
```

### 11. **ThemeUtilsPlus** ⭐ LOW PRIORITY
Theme and styling utilities.

```dart
class ThemeUtilsPlus {
  static bool isDarkMode(BuildContext context);
  static Color getAdaptiveColor(BuildContext context, {
    required Color light,
    required Color dark,
  });
  
  static TextStyle getAdaptiveTextStyle(BuildContext context, {
    required TextStyle light,
    required TextStyle dark,
  });
  
  static double getResponsiveFontSize(BuildContext context, {
    required double baseSize,
    double? scaleFactor,
  });
}
```

### 12. **AnimationUtilsPlus** ⭐ LOW PRIORITY
Animation helpers and curves.

```dart
class AnimationUtilsPlus {
  static AnimationController createController(
    TickerProvider vsync, {
    Duration duration = const Duration(milliseconds: 300),
  });
  
  static CurvedAnimation createCurvedAnimation(
    AnimationController controller, {
    Curve curve = Curves.easeInOut,
  });
  
  // Predefined animations
  static Animation<double> fadeIn(AnimationController controller);
  static Animation<double> slideUp(AnimationController controller);
  static Animation<double> scale(AnimationController controller);
}
```

---

## 📊 PRIORITY MATRIX

### High Priority (Implement First)
1. ✅ Fix error handling and null safety
2. ✅ Add NumberUtilsPlus
3. ✅ Add ColorUtilsPlus
4. ✅ Add ValidationUtilsPlus
5. ✅ Add StorageUtilsPlus
6. ✅ Fix memory leaks in WidgetUtilsPlus
7. ✅ Improve test coverage

### Medium Priority
1. ✅ Add DebounceUtilsPlus
2. ✅ Add FileUtilsPlus
3. ✅ Add NetworkUtilsPlus
4. ✅ Add Extension Methods
5. ✅ Improve documentation

### Low Priority
1. ✅ Add ImageUtilsPlus
2. ✅ Add PermissionUtilsPlus
3. ✅ Add ThemeUtilsPlus
4. ✅ Add AnimationUtilsPlus

---

## 🎯 QUICK WINS (Easy Improvements)

1. **Fix README import path** - Change `smart_utils.dart` to `smart_utils_plus.dart`
2. **Add null safety** - Add null checks to all utility methods
3. **Fix toast memory leak** - Properly track and remove overlay entries
4. **Add dartdoc comments** - Document all public APIs
5. **Add edge case tests** - Test null, empty, and invalid inputs
6. **Add extension methods** - Make API more Flutter-idiomatic
7. **Improve email/URL regex** - Use more robust validation patterns

---

## 📝 NOTES

- Consider adding a `SmartUtilsConfig` class for global configuration
- Add support for custom locales in DateUtilsPlus
- Consider making some utilities async-friendly
- Add support for custom themes in WidgetUtilsPlus
- Consider adding a `SmartUtilsInitializer` for setup


