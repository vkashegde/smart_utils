# Smart Utils Plus

A comprehensive Flutter utility package providing essential helper classes for date/time manipulation, string operations, device information, logging, and widget utilities.

## Features

- 📅 **DateUtilsPlus** - Human-readable date & time formatting
- 🔤 **StringUtilsPlus** - String manipulation and validation utilities
- 📱 **DeviceUtilsPlus** - Device, platform, and connectivity information
- 🎨 **WidgetUtilsPlus** - Common widget helpers (snackbars, loaders, dialogs, bottom sheets)
- 📝 **LoggerPlus** - Colorful console logger for Flutter & Dart
- 📏 **ContextSizeHelper** - Context extensions for layout helpers

## Getting Started

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  smart_utils_plus: ^0.0.1
```

Then run:
```bash
flutter pub get
```

## Usage

### DateUtilsPlus

```dart
import 'package:smart_utils_plus/smart_utils.dart';

// Human-readable time ago
DateUtilsPlus.timeAgo(DateTime.now().subtract(Duration(hours: 3)));
// Returns: "3 hours ago"

// Smart date time format
DateUtilsPlus.smartDateTime(DateTime.now());
// Returns: "Today 6:00 PM"

// Format date
DateUtilsPlus.format(DateTime.now(), pattern: 'yyyy-MM-dd');
// Returns: "2025-01-09"

// Check if today
DateUtilsPlus.isToday(someDate);

// Difference summary
DateUtilsPlus.diffSummary(startDate, endDate);
// Returns: "2d 5h 10m"
```

### StringUtilsPlus

```dart
import 'package:smart_utils_plus/smart_utils.dart';

// Capitalize first letter
StringUtilsPlus.capitalize('hello'); // "Hello"

// Create URL-friendly slug
StringUtilsPlus.slugify('Hello World!'); // "hello-world"

// Truncate string
StringUtilsPlus.truncate('Long text here', 7); // "Long te..."

// Validate email
StringUtilsPlus.isEmail('test@example.com'); // true

// Validate URL
StringUtilsPlus.isUrl('https://flutter.dev'); // true
```

### DeviceUtilsPlus

```dart
import 'package:smart_utils_plus/smart_utils.dart';

// Platform detection
DeviceUtilsPlus.isAndroid; // true/false
DeviceUtilsPlus.isIOS; // true/false
DeviceUtilsPlus.isWeb; // true/false
DeviceUtilsPlus.isDesktop; // true/false
DeviceUtilsPlus.isMobile; // true/false

// Get device info
final info = await DeviceUtilsPlus.getDeviceInfo();
// Returns: {'platform': 'Android', 'brand': 'Samsung', ...}

// Check connectivity
final hasConnection = await DeviceUtilsPlus.hasInternetConnection();

// Screen dimensions
final width = DeviceUtilsPlus.screenWidth(context);
final height = DeviceUtilsPlus.screenHeight(context);

// Orientation
DeviceUtilsPlus.isPortrait(context);
DeviceUtilsPlus.isLandscape(context);
```

### WidgetUtilsPlus

```dart
import 'package:smart_utils_plus/smart_utils.dart';

// Snackbars
WidgetUtilsPlus.showSuccessSnackbar(context, "Operation successful!");
WidgetUtilsPlus.showErrorSnackbar(context, "Something went wrong!");
WidgetUtilsPlus.showInfoSnackbar(context, "Info message");

// Custom snackbar
WidgetUtilsPlus.showSnackbar(
  context,
  message: "Custom message",
  backgroundColor: Colors.blue,
  duration: Duration(seconds: 3),
);

// Toast
WidgetUtilsPlus.showToast(context, message: "Toast message");

// Loader
WidgetUtilsPlus.showLoader(context, message: "Loading...");
WidgetUtilsPlus.hideLoader(context);

// Confirm dialog
final confirmed = await WidgetUtilsPlus.showConfirmDialog(
  context,
  title: "Confirm",
  message: "Are you sure?",
);

// Bottom sheet
await WidgetUtilsPlus.showBottomSheetPlus(
  context,
  child: YourWidget(),
  maxHeightFraction: 0.8,
);

// Message sheet
await WidgetUtilsPlus.showMessageSheet(
  context,
  title: "Title",
  message: "Message content",
);
```

### ContextSizeHelper

```dart
import 'package:smart_utils_plus/smart_utils.dart';

// Get parent width/height as fraction
final width = context.parentWidth(0.5); // 50% of parent width
final height = context.parentHeight(0.3); // 30% of parent height

// Get remaining space
final remainingWidth = context.remainingParentWidth(usedWidth: 100);
final remainingHeight = context.remainingParentHeight(usedHeight: 200);

// Get constraints
final constraints = context.getParentConstraints();
final aspectRatio = context.parentAspectRatio();

// Get widget position and sizei have readme and everthink
final position = context.getGlobalPosition();
final size = context.getWidgetSize();
final parentPosition = context.getPositionInParent();
```

### LoggerPlus

```dart
import 'package:smart_utils_plus/smart_utils.dart';

// Log messages with colors
LoggerPlus.info('Information message');
LoggerPlus.success('Success message');
LoggerPlus.warning('Warning message');
LoggerPlus.error('Error message');
LoggerPlus.debug('Debug message');

// Configure logger
LoggerPlus.isEnabled = true; // Enable/disable logging
LoggerPlus.showTimestamp = true; // Show/hide timestamp
```

## Example

See the [example](example) directory for a complete working example.

```bash
cd example
flutter run
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Additional Information

For more information about the package, check out the source code and example app in this repository.