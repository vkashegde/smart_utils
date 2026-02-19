import 'package:flutter/widgets.dart';

/// A utility class for breakpoint-based responsive design.
///
/// Provides methods to detect screen sizes (mobile, tablet, desktop) and
/// select responsive values based on breakpoints. Uses screen width rather
/// than platform detection for true responsive design.
///
/// Default breakpoints:
/// - Mobile: < 600px
/// - Tablet: 600px - 1023px
/// - Desktop: >= 1024px
///
/// Example:
/// ```dart
/// if (ResponsiveUtilsPlus.isMobile(context)) {
///   // Mobile-specific code
/// }
///
/// final padding = ResponsiveUtilsPlus.responsiveValue(
///   context,
///   mobile: 16.0,
///   tablet: 24.0,
///   desktop: 32.0,
/// );
/// ```
class ResponsiveUtilsPlus {
  /// Default breakpoint for mobile devices (in pixels).
  ///
  /// Screens with width < [mobileBreakpoint] are considered mobile.
  static const double mobileBreakpoint = 600.0;

  /// Default breakpoint for tablet devices (in pixels).
  ///
  /// Screens with width >= [mobileBreakpoint] and < [tabletBreakpoint]
  /// are considered tablets.
  static const double tabletBreakpoint = 1024.0;

  /// Returns true if the screen width is less than [mobileBreakpoint].
  ///
  /// Returns `false` if [context] is null or not mounted.
  ///
  /// Example:
  /// ```dart
  /// if (ResponsiveUtilsPlus.isMobile(context)) {
  ///   return MobileLayout();
  /// }
  /// ```
  static bool isMobile(BuildContext? context) {
    if (context == null) return false;
    try {
      if (!context.mounted) return false;
      final width = MediaQuery.of(context).size.width;
      return width < mobileBreakpoint;
    } catch (e) {
      return false;
    }
  }

  /// Returns true if the screen width is between [mobileBreakpoint] and [tabletBreakpoint].
  ///
  /// Returns `false` if [context] is null or not mounted.
  ///
  /// Example:
  /// ```dart
  /// if (ResponsiveUtilsPlus.isTablet(context)) {
  ///   return TabletLayout();
  /// }
  /// ```
  static bool isTablet(BuildContext? context) {
    if (context == null) return false;
    try {
      if (!context.mounted) return false;
      final width = MediaQuery.of(context).size.width;
      return width >= mobileBreakpoint && width < tabletBreakpoint;
    } catch (e) {
      return false;
    }
  }

  /// Returns true if the screen width is greater than or equal to [tabletBreakpoint].
  ///
  /// Returns `false` if [context] is null or not mounted.
  ///
  /// Example:
  /// ```dart
  /// if (ResponsiveUtilsPlus.isDesktop(context)) {
  ///   return DesktopLayout();
  /// }
  /// ```
  static bool isDesktop(BuildContext? context) {
    if (context == null) return false;
    try {
      if (!context.mounted) return false;
      final width = MediaQuery.of(context).size.width;
      return width >= tabletBreakpoint;
    } catch (e) {
      return false;
    }
  }

  /// Returns a responsive value based on screen size.
  ///
  /// Uses a fallback chain: desktop → tablet → mobile.
  /// If [tablet] is null, falls back to [mobile].
  /// If [desktop] is null, falls back to [tablet] or [mobile].
  ///
  /// Example:
  /// ```dart
  /// final fontSize = ResponsiveUtilsPlus.responsiveValue(
  ///   context,
  ///   mobile: 14.0,
  ///   tablet: 18.0,
  ///   desktop: 24.0,
  /// );
  ///
  /// final widget = ResponsiveUtilsPlus.responsiveValue(
  ///   context,
  ///   mobile: MobileWidget(),
  ///   tablet: TabletWidget(),
  ///   desktop: DesktopWidget(),
  /// );
  /// ```
  static T responsiveValue<T>(
    BuildContext? context, {
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (context == null) return mobile;
    try {
      if (!context.mounted) return mobile;
      final width = MediaQuery.of(context).size.width;

      if (width >= tabletBreakpoint) {
        return desktop ?? tablet ?? mobile;
      } else if (width >= mobileBreakpoint) {
        return tablet ?? mobile;
      } else {
        return mobile;
      }
    } catch (e) {
      return mobile;
    }
  }

  /// Returns responsive padding as [EdgeInsets].
  ///
  /// Uses [mobile] as base value. If [tablet] is not provided,
  /// defaults to 1.5x [mobile]. If [desktop] is not provided,
  /// defaults to 2x [mobile].
  ///
  /// Example:
  /// ```dart
  /// Container(
  ///   padding: ResponsiveUtilsPlus.responsivePadding(
  ///     context,
  ///     mobile: 16.0,
  ///     tablet: 24.0,
  ///     desktop: 32.0,
  ///   ),
  /// )
  /// ```
  static EdgeInsets responsivePadding(
    BuildContext? context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    final value = responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2.0,
    );
    return EdgeInsets.all(value);
  }

  /// Returns responsive font size.
  ///
  /// Uses [mobile] as base value. If [tablet] is not provided,
  /// defaults to 1.2x [mobile]. If [desktop] is not provided,
  /// defaults to 1.5x [mobile].
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Hello',
  ///   style: TextStyle(
  ///     fontSize: ResponsiveUtilsPlus.responsiveFontSize(
  ///       context,
  ///       mobile: 14.0,
  ///       tablet: 18.0,
  ///       desktop: 24.0,
  ///     ),
  ///   ),
  /// )
  /// ```
  static double responsiveFontSize(
    BuildContext? context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.2,
      desktop: desktop ?? mobile * 1.5,
    );
  }

  /// Returns responsive column count for grid layouts.
  ///
  /// Defaults to 1 column on mobile, 2 on tablet, and 3 on desktop
  /// if not specified.
  ///
  /// Example:
  /// ```dart
  /// GridView.builder(
  ///   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  ///     crossAxisCount: ResponsiveUtilsPlus.responsiveColumns(
  ///       context,
  ///       mobile: 1,
  ///       tablet: 2,
  ///       desktop: 3,
  ///     ),
  ///   ),
  /// )
  /// ```
  static int responsiveColumns(
    BuildContext? context, {
    int mobile = 1,
    int? tablet,
    int? desktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? 2,
      desktop: desktop ?? 3,
    );
  }

  /// Returns responsive spacing value.
  ///
  /// Uses [mobile] as base value. If [tablet] is not provided,
  /// defaults to 1.5x [mobile]. If [desktop] is not provided,
  /// defaults to 2x [mobile].
  ///
  /// Example:
  /// ```dart
  /// SizedBox(
  ///   height: ResponsiveUtilsPlus.responsiveSpacing(
  ///     context,
  ///     mobile: 8.0,
  ///     tablet: 12.0,
  ///     desktop: 16.0,
  ///   ),
  /// )
  /// ```
  static double responsiveSpacing(
    BuildContext? context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return responsiveValue(
      context,
      mobile: mobile,
      tablet: tablet ?? mobile * 1.5,
      desktop: desktop ?? mobile * 2.0,
    );
  }

  /// Returns responsive max width constraint.
  ///
  /// Returns `null` if all values are null or context is invalid.
  /// Useful for constraining content width on larger screens.
  ///
  /// Example:
  /// ```dart
  /// Container(
  ///   constraints: BoxConstraints(
  ///     maxWidth: ResponsiveUtilsPlus.responsiveMaxWidth(
  ///       context,
  ///       mobile: double.infinity,
  ///       tablet: 800.0,
  ///       desktop: 1200.0,
  ///     ) ?? double.infinity,
  ///   ),
  /// )
  /// ```
  static double? responsiveMaxWidth(
    BuildContext? context, {
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    if (context == null) return mobile;
    try {
      if (!context.mounted) return mobile;
      final width = MediaQuery.of(context).size.width;

      if (width >= tabletBreakpoint) {
        return desktop ?? tablet ?? mobile;
      } else if (width >= mobileBreakpoint) {
        return tablet ?? mobile;
      } else {
        return mobile;
      }
    } catch (e) {
      return mobile;
    }
  }
}

/// Extension methods on [BuildContext] for responsive utilities.
///
/// Provides convenient access to responsive methods directly on context.
///
/// Example:
/// ```dart
/// if (context.isMobile) {
///   // Mobile-specific code
/// }
///
/// final padding = context.responsivePadding(mobile: 16.0);
/// final fontSize = context.responsiveFontSize(mobile: 14.0);
/// ```
extension ResponsiveContextExtension on BuildContext {
  /// Returns true if the screen is mobile size.
  ///
  /// Shorthand for [ResponsiveUtilsPlus.isMobile].
  bool get isMobile => ResponsiveUtilsPlus.isMobile(this);

  /// Returns true if the screen is tablet size.
  ///
  /// Shorthand for [ResponsiveUtilsPlus.isTablet].
  bool get isTablet => ResponsiveUtilsPlus.isTablet(this);

  /// Returns true if the screen is desktop size.
  ///
  /// Shorthand for [ResponsiveUtilsPlus.isDesktop].
  bool get isDesktop => ResponsiveUtilsPlus.isDesktop(this);

  /// Returns a responsive value based on screen size.
  ///
  /// Shorthand for [ResponsiveUtilsPlus.responsiveValue].
  ///
  /// Example:
  /// ```dart
  /// final value = context.responsiveValue(
  ///   mobile: 'Mobile',
  ///   tablet: 'Tablet',
  ///   desktop: 'Desktop',
  /// );
  /// ```
  T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    return ResponsiveUtilsPlus.responsiveValue(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Returns responsive padding as [EdgeInsets].
  ///
  /// Shorthand for [ResponsiveUtilsPlus.responsivePadding].
  ///
  /// Example:
  /// ```dart
  /// Container(
  ///   padding: context.responsivePadding(mobile: 16.0),
  /// )
  /// ```
  EdgeInsets responsivePadding({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveUtilsPlus.responsivePadding(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Returns responsive font size.
  ///
  /// Shorthand for [ResponsiveUtilsPlus.responsiveFontSize].
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Hello',
  ///   style: TextStyle(
  ///     fontSize: context.responsiveFontSize(mobile: 14.0),
  ///   ),
  /// )
  /// ```
  double responsiveFontSize({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveUtilsPlus.responsiveFontSize(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Returns responsive column count for grid layouts.
  ///
  /// Shorthand for [ResponsiveUtilsPlus.responsiveColumns].
  ///
  /// Example:
  /// ```dart
  /// final columns = context.responsiveColumns(mobile: 1);
  /// ```
  int responsiveColumns({
    int mobile = 1,
    int? tablet,
    int? desktop,
  }) {
    return ResponsiveUtilsPlus.responsiveColumns(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Returns responsive spacing value.
  ///
  /// Shorthand for [ResponsiveUtilsPlus.responsiveSpacing].
  ///
  /// Example:
  /// ```dart
  /// SizedBox(height: context.responsiveSpacing(mobile: 8.0))
  /// ```
  double responsiveSpacing({
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveUtilsPlus.responsiveSpacing(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }

  /// Returns responsive max width constraint.
  ///
  /// Shorthand for [ResponsiveUtilsPlus.responsiveMaxWidth].
  ///
  /// Example:
  /// ```dart
  /// final maxWidth = context.responsiveMaxWidth(
  ///   mobile: double.infinity,
  ///   tablet: 800.0,
  ///   desktop: 1200.0,
  /// );
  /// ```
  double? responsiveMaxWidth({
    double? mobile,
    double? tablet,
    double? desktop,
  }) {
    return ResponsiveUtilsPlus.responsiveMaxWidth(
      this,
      mobile: mobile,
      tablet: tablet,
      desktop: desktop,
    );
  }
}
