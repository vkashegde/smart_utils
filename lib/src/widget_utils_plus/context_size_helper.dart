import 'package:flutter/widgets.dart';

extension ContextSizeHelper on BuildContext {
  /// 📏 Get the width relative to parent constraints (or screen if unbounded)
  double parentWidth(double fraction) {
    final box = findRenderObject() as RenderBox?;
    if (box?.constraints.hasBoundedWidth ?? false) {
      return box!.constraints.maxWidth * fraction;
    }
    return MediaQuery.of(this).size.width * fraction;
  }

  /// 📏 Get the height relative to parent constraints (or screen if unbounded)
  double parentHeight(double fraction) {
    final box = findRenderObject() as RenderBox?;
    if (box?.constraints.hasBoundedHeight ?? false) {
      return box!.constraints.maxHeight * fraction;
    }
    return MediaQuery.of(this).size.height * fraction;
  }

  /// 📐 Get remaining width inside parent after using some width
  double remainingParentWidth({required double usedWidth}) {
    final box = findRenderObject() as RenderBox?;
    final maxWidth = box?.constraints.maxWidth ?? MediaQuery.of(this).size.width;
    return maxWidth - usedWidth;
  }

  /// 📐 Get remaining height inside parent after using some height
  double remainingParentHeight({required double usedHeight}) {
    final box = findRenderObject() as RenderBox?;
    final maxHeight = box?.constraints.maxHeight ?? MediaQuery.of(this).size.height;
    return maxHeight - usedHeight;
  }

  // -----------------------------------------------------------------
  // 🧠 ADVANCED HELPERS
  // -----------------------------------------------------------------

  /// 🔲 Get both max width & height of parent constraints
  BoxConstraints? getParentConstraints() {
    final box = findRenderObject() as RenderBox?;
    return box?.constraints;
  }

  /// ⚖️ Get aspect ratio based on parent constraints
  double? parentAspectRatio() {
    final constraints = getParentConstraints();
    if (constraints == null || constraints.maxHeight == 0) return null;
    return constraints.maxWidth / constraints.maxHeight;
  }

  /// 📍 Get widget position (offset) in global coordinates
  Offset? getGlobalPosition() {
    final box = findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero);
  }

  /// 📦 Get widget size (actual rendered size, not just constraints)
  Size? getWidgetSize() {
    final box = findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.size;
  }

  /// 🧭 Get the offset relative to parent (instead of global)
  Offset? getPositionInParent() {
    final box = findRenderObject() as RenderBox?;
    final parent = box?.parent;
    if (box == null || parent is! RenderBox) return null;
    final parentOffset = parent.localToGlobal(Offset.zero);
    final childOffset = box.localToGlobal(Offset.zero);
    return childOffset - parentOffset;
  }
}
