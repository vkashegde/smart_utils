library;

/// Central export for all widget-related utilities in Smart Utils.
///
/// Import this single file to access:
/// - Snackbars, Toasts, Loaders, Dialogs, Bottom Sheets
/// - Context-aware layout helpers (size, position, constraints)
///
/// Example:
/// ```dart
/// import 'package:smart_utils_plus/widget_utils_plus.dart';
/// ```
///
/// Then:
/// ```dart
/// WidgetUtilsPlus.showSuccessSnackbar(context, "Done!");
/// context.parentWidth(0.5);
/// ```

export 'context_size_helper.dart';
export 'widget_helpers_core.dart';
