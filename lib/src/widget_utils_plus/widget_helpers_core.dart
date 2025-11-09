import 'package:flutter/material.dart';

/// A utility class providing common widget helpers:
/// Snackbars, toasts, loaders, dialogs, etc.
class WidgetUtilsPlus {
  // --------------------------------------------------
  // 🔔 SNACKBARS
  // --------------------------------------------------

  static void showSnackbar(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
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

  static void showSuccessSnackbar(BuildContext context, String message) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.green.shade600,
    );
  }

  static void showErrorSnackbar(BuildContext context, String message) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.red.shade700,
    );
  }

  static void showInfoSnackbar(BuildContext context, String message) {
    showSnackbar(
      context,
      message: message,
      backgroundColor: Colors.blue.shade600,
    );
  }

  // --------------------------------------------------
  // 🍞 TOAST (Overlay-style)
  // --------------------------------------------------

  static void showToast(
    BuildContext context, {
    required String message,
    Color backgroundColor = Colors.black87,
    Color textColor = Colors.white,
    Duration duration = const Duration(seconds: 2),
    double bottomOffset = 80,
  }) {
    final overlay = Overlay.of(context);

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

    overlay.insert(overlayEntry);

    Future.delayed(duration, () => overlayEntry.remove());
  }

  // --------------------------------------------------
  // ⏳ GLOBAL LOADER
  // --------------------------------------------------

  static OverlayEntry? _loaderEntry;

  static void showLoader(BuildContext context, {String? message}) {
    if (_loaderEntry != null) return;

    final overlay = Overlay.of(context);

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

  static void hideLoader(BuildContext context) {
    _loaderEntry?.remove();
    _loaderEntry = null;
  }

  // --------------------------------------------------
  // 💬 DIALOG HELPERS
  // --------------------------------------------------

  static Future<bool?> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String confirmText = 'Yes',
    String cancelText = 'Cancel',
  }) {
    return showDialog<bool>(
      context: context,
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

  static Future<T?> showBottomSheetPlus<T>(
    BuildContext context, {
    required Widget child,
    bool isDismissible = true,
    bool enableDrag = true,
    double? maxHeightFraction, // e.g., 0.8 for 80% of screen
    Color backgroundColor = Colors.white,
    double borderRadius = 16.0,
  }) {
    final maxHeight = MediaQuery.of(context).size.height * (maxHeightFraction ?? 0.8);

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

  /// Quickly show a text-only bottom sheet with a message
  static Future<void> showMessageSheet(
    BuildContext context, {
    required String title,
    required String message,
    String buttonText = "Close",
  }) {
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
              onPressed: () => Navigator.of(context).pop(),
              child: Text(buttonText),
            ),
          ],
        ),
      ),
    );
  }
}
