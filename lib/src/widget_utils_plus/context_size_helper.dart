import 'package:flutter/widgets.dart';

/// Extension methods on [BuildContext] for layout and size calculations.
///
/// Provides convenient methods to get parent constraints, widget sizes,
/// and calculate layout dimensions.
///
/// Example:
/// ```dart
/// final width = context.parentWidth(0.5); // 50% of parent width
/// final height = context.parentHeight(0.3); // 30% of parent height
/// ```
extension ContextSizeHelper on BuildContext {
  /// Gets the width relative to parent constraints (or screen if unbounded).
  ///
  /// Returns [fraction] of the parent's max width, or screen width if
  /// parent constraints are unbounded.
  ///
  /// Example:
  /// ```dart
  /// final halfWidth = context.parentWidth(0.5); // 50% of parent
  /// ```
  double parentWidth(double fraction) {
    final box = findRenderObject() as RenderBox?;
    if (box?.constraints.hasBoundedWidth ?? false) {
      return box!.constraints.maxWidth * fraction;
    }
    return MediaQuery.of(this).size.width * fraction;
  }

  /// Gets the height relative to parent constraints (or screen if unbounded).
  ///
  /// Returns [fraction] of the parent's max height, or screen height if
  /// parent constraints are unbounded.
  ///
  /// Example:
  /// ```dart
  /// final quarterHeight = context.parentHeight(0.25); // 25% of parent
  /// ```
  double parentHeight(double fraction) {
    final box = findRenderObject() as RenderBox?;
    if (box?.constraints.hasBoundedHeight ?? false) {
      return box!.constraints.maxHeight * fraction;
    }
    return MediaQuery.of(this).size.height * fraction;
  }

  /// Gets remaining width inside parent after using some width.
  ///
  /// Useful for calculating available space after placing other widgets.
  ///
  /// Example:
  /// ```dart
  /// final remaining = context.remainingParentWidth(usedWidth: 100);
  /// ```
  double remainingParentWidth({required double usedWidth}) {
    final box = findRenderObject() as RenderBox?;
    final maxWidth =
        box?.constraints.maxWidth ?? MediaQuery.of(this).size.width;
    return maxWidth - usedWidth;
  }

  /// Gets remaining height inside parent after using some height.
  ///
  /// Useful for calculating available space after placing other widgets.
  ///
  /// Example:
  /// ```dart
  /// final remaining = context.remainingParentHeight(usedHeight: 200);
  /// ```
  double remainingParentHeight({required double usedHeight}) {
    final box = findRenderObject() as RenderBox?;
    final maxHeight =
        box?.constraints.maxHeight ?? MediaQuery.of(this).size.height;
    return maxHeight - usedHeight;
  }

  // -----------------------------------------------------------------
  // ADVANCED HELPERS
  // -----------------------------------------------------------------

  /// Gets both max width and height of parent constraints.
  ///
  /// Returns `null` if the render object is not available.
  ///
  /// Example:
  /// ```dart
  /// final constraints = context.getParentConstraints();
  /// if (constraints != null) {
  ///   print('Max width: ${constraints.maxWidth}');
  /// }
  /// ```
  BoxConstraints? getParentConstraints() {
    final box = findRenderObject() as RenderBox?;
    return box?.constraints;
  }

  /// Gets aspect ratio based on parent constraints.
  ///
  /// Returns `null` if constraints are not available or height is zero.
  ///
  /// Example:
  /// ```dart
  /// final ratio = context.parentAspectRatio();
  /// ```
  double? parentAspectRatio() {
    final constraints = getParentConstraints();
    if (constraints == null || constraints.maxHeight == 0) return null;
    return constraints.maxWidth / constraints.maxHeight;
  }

  /// Gets widget position (offset) in global coordinates.
  ///
  /// Returns `null` if the widget hasn't been rendered yet.
  ///
  /// Example:
  /// ```dart
  /// final position = context.getGlobalPosition();
  /// if (position != null) {
  ///   print('X: ${position.dx}, Y: ${position.dy}');
  /// }
  /// ```
  Offset? getGlobalPosition() {
    final box = findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero);
  }

  /// Gets widget size (actual rendered size, not just constraints).
  ///
  /// Returns `null` if the widget hasn't been rendered yet.
  ///
  /// Example:
  /// ```dart
  /// final size = context.getWidgetSize();
  /// if (size != null) {
  ///   print('Width: ${size.width}, Height: ${size.height}');
  /// }
  /// ```
  Size? getWidgetSize() {
    final box = findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.size;
  }

  /// Gets the offset relative to parent (instead of global coordinates).
  ///
  /// Returns `null` if the widget or parent hasn't been rendered yet.
  ///
  /// Example:
  /// ```dart
  /// final position = context.getPositionInParent();
  /// ```
  Offset? getPositionInParent() {
    final box = findRenderObject() as RenderBox?;
    final parent = box?.parent;
    if (box == null || parent is! RenderBox) return null;
    final parentOffset = parent.localToGlobal(Offset.zero);
    final childOffset = box.localToGlobal(Offset.zero);
    return childOffset - parentOffset;
  }
}
