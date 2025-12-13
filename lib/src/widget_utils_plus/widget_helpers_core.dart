import 'package:flutter/material.dart';

/// A utility class providing common widget helpers:
/// Snackbars, toasts, loaders, dialogs, etc.
///
/// All methods validate the [BuildContext] before use to prevent errors.
class WidgetUtilsPlus {
  // Track active toast overlay entries to prevent memory leaks
  static final Set<OverlayEntry> _activeToastEntries = {};

  /// Validates that the context is still mounted and has required widgets.
  static bool _isValidContext(BuildContext? context) {
    if (context == null) return false;
    try {
      // Check if context is still mounted
      if (!context.mounted) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  // --------------------------------------------------
  // 🔔 SNACKBARS
  // --------------------------------------------------

  /// Shows a custom snackbar with the specified message and styling.
  ///
  /// Validates the context before showing. If no [ScaffoldMessenger] is found,
  /// the snackbar will not be shown.
  ///
  /// Example:
  /// ```dart
  /// WidgetUtilsPlus.showSnackbar(
  ///   context,
  ///   message: 'Operation completed',
  ///   backgroundColor: Colors.green,
  /// );
  /// ```
  static void showSnackbar(
    BuildContext? context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    if (!_isValidContext(context)) return;

    final messenger = ScaffoldMessenger.maybeOf(context!);
    if (messenger == null) return;

    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: textColor),
        ),
        backgroundColor: backgroundColor,
        duration: duration,
        action: action,
      ),
    );
  }

  /// Shows a success snackbar with green background.
  ///
  /// Example:
  /// ```dart
  /// WidgetUtilsPlus.showSuccessSnackbar(context, 'Success!');
  /// ```
  static void showSuccessSnackbar(BuildContext? context, String message) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.green.shade600,
    );
  }

  /// Shows an error snackbar with red background.
  ///
  /// Example:
  /// ```dart
  /// WidgetUtilsPlus.showErrorSnackbar(context, 'Error occurred!');
  /// ```
  static void showErrorSnackbar(BuildContext? context, String message) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.red.shade700,
    );
  }

  /// Shows an info snackbar with blue background.
  ///
  /// Example:
  /// ```dart
  /// WidgetUtilsPlus.showInfoSnackbar(context, 'Information');
  /// ```
  static void showInfoSnackbar(BuildContext? context, String message) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.blue.shade600,
    );
  }

  // --------------------------------------------------
  // 🍞 TOAST (Overlay-style)
  // --------------------------------------------------

  /// Shows a toast message as an overlay.
  ///
  /// Properly manages overlay entries to prevent memory leaks.
  /// Automatically removes the toast after [duration].
  ///
  /// Example:
  /// ```dart
  /// WidgetUtilsPlus.showToast(
  ///   context,
  ///   message: 'Toast message',
  ///   duration: Duration(seconds: 3),
  /// );
  /// ```
  static void showToast(
    BuildContext? context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    double bottomOffset = 80,
  }) {
    if (!_isValidContext(context)) return;

    final overlay = Overlay.maybeOf(context!);
    if (overlay == null) return;

    // Clean up any existing toast entries
    _cleanupToastEntries(overlay);

    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: bottomOffset,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: AnimatedOpacity(
            opacity: 1.0,
            duration: const Duration(milliseconds: 300),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: 14),
              ),
            ),
          ),
        ),
      ),
    );

    _activeToastEntries.add(overlayEntry);
    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (_activeToastEntries.contains(overlayEntry)) {
        overlayEntry.remove();
        _activeToastEntries.remove(overlayEntry);
      }
    });
  }

  /// Cleans up all active toast overlay entries.
  ///
  /// This should be called when the app is disposed or when you want
  /// to manually clear all toasts.
  static void _cleanupToastEntries(OverlayState overlay) {
    for (final entry in _activeToastEntries.toList()) {
      try {
        entry.remove();
      } catch (e) {
        // Entry may have already been removed
      }
    }
    _activeToastEntries.clear();
  }

  /// Manually dismisses all active toast messages.
  ///
  /// Useful for cleaning up toasts when navigating away or on app pause.
  static void dismissAllToasts(BuildContext? context) {
    if (!_isValidContext(context)) return;
    final overlayState = Overlay.maybeOf(context!);
    if (overlayState != null) {
      _cleanupToastEntries(overlayState);
    }
  }

  // --------------------------------------------------
  // ⏳ GLOBAL LOADER
  // --------------------------------------------------

  static OverlayEntry? _loaderEntry;

  /// Shows a global loading indicator overlay.
  ///
  /// Only one loader can be shown at a time. If a loader is already showing,
  /// this method will return without creating a new one.
  ///
  /// Example:
  /// ```dart
  /// WidgetUtilsPlus.showLoader(context, message: 'Loading...');
  /// ```
  static void showLoader(BuildContext? context, {String? message}) {
    if (!_isValidContext(context)) return;
    if (_loaderEntry != null) return;

    final overlay = Overlay.maybeOf(context!);
    if (overlay == null) return;

    _loaderEntry = OverlayEntry(
      builder: (_) => Stack(
        children: [
          ModalBarrier(
            color: Colors.black38,
            dismissible: false,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                if (message != null) ...[
                  const SizedBox(height: 12),
                  Text(
                    message,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ]
              ],
            ),
          ),
        ],
      ),
    );

    overlay.insert(_loaderEntry!);
  }

  /// Hides the global loading indicator.
  ///
  /// Safe to call even if no loader is currently showing.
  ///
  /// Example:
  /// ```dart
  /// WidgetUtilsPlus.hideLoader(context);
  /// ```
  static void hideLoader(BuildContext? context) {
    if (_loaderEntry != null) {
      try {
        _loaderEntry!.remove();
      } catch (e) {
        // Entry may have already been removed
      }
      _loaderEntry = null;
    }
  }

  // --------------------------------------------------
  // 💬 DIALOG HELPERS
  // --------------------------------------------------

  /// Shows a confirmation dialog with Yes/No buttons.
  ///
  /// Returns `true` if confirmed, `false` if cancelled, or `null` if dismissed.
  ///
  /// Example:
  /// ```dart
  /// final confirmed = await WidgetUtilsPlus.showConfirmDialog(
  ///   context,
  ///   title: 'Confirm',
  ///   message: 'Are you sure?',
  /// );
  /// if (confirmed == true) {
  ///   // User confirmed
  /// }
  /// ```
  static Future<bool?> showConfirmDialog(
    BuildContext? context, {
    required String title,
    required String message,
    String confirmText = 'Yes',
    String cancelText = 'Cancel',
  }) {
    if (!_isValidContext(context)) return Future.value(null);

    return showDialog<bool>(
      context: context!,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
  }

  // --------------------------------------------------
  // 📤 GLOBAL BOTTOM SHEET
  // --------------------------------------------------

  /// Shows a customizable bottom sheet.
  ///
  /// [maxHeightFraction] controls the maximum height as a fraction of screen height
  /// (e.g., 0.8 for 80% of screen).
  ///
  /// Example:
  /// ```dart
  /// await WidgetUtilsPlus.showBottomSheetPlus(
  ///   context,
  ///   child: YourWidget(),
  ///   maxHeightFraction: 0.8,
  /// );
  /// ```
  static Future<T?> showBottomSheetPlus<T>(
    BuildContext? context, {
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    double? maxHeightFraction, // e.g., 0.8 for 80% of screen
    Color backgroundColor = Colors.white,
    double borderRadius = 16.0,
  }) {
    if (!_isValidContext(context)) return Future.value(null);

    final maxHeight = MediaQuery.of(context!).size.height * (maxHeightFraction ?? 0.8);

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(borderRadius),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, -3),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(borderRadius),
          ),
          child: child,
        ),
      ),
    );
  }

  /// Quickly show a text-only bottom sheet with a message.
  ///
  /// Example:
  /// ```dart
  /// await WidgetUtilsPlus.showMessageSheet(
  ///   context,
  ///   title: 'Title',
  ///   message: 'Message content',
  /// );
  /// ```
  static Future<void> showMessageSheet(
    BuildContext? context, {
    required String title,
    required String message,
    String buttonText = "Close",
  }) {
    if (!_isValidContext(context)) return Future.value();

    return showBottomSheetPlus(
      context,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(
              message,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.of(context!).pop(),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
