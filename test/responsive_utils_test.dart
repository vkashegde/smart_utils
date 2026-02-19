import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smart_utils_plus/smart_utils_plus.dart';

void main() {
  group('ResponsiveUtilsPlus - Breakpoint Detection', () {
    testWidgets('isMobile returns true for screens < 600px', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(599, 800)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isTrue);
                expect(ResponsiveUtilsPlus.isTablet(context), isFalse);
                expect(ResponsiveUtilsPlus.isDesktop(context), isFalse);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('isTablet returns true for screens 600-1023px', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isFalse);
                expect(ResponsiveUtilsPlus.isTablet(context), isTrue);
                expect(ResponsiveUtilsPlus.isDesktop(context), isFalse);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('isDesktop returns true for screens >= 1024px', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isFalse);
                expect(ResponsiveUtilsPlus.isTablet(context), isFalse);
                expect(ResponsiveUtilsPlus.isDesktop(context), isTrue);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles exact breakpoint values correctly', (tester) async {
      // Test at mobile breakpoint (600px)
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600, 800)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isFalse);
                expect(ResponsiveUtilsPlus.isTablet(context), isTrue);
                expect(ResponsiveUtilsPlus.isDesktop(context), isFalse);
                return const SizedBox();
              },
            ),
          ),
        ),
      );

      // Test at tablet breakpoint (1024px)
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1024, 800)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isFalse);
                expect(ResponsiveUtilsPlus.isTablet(context), isFalse);
                expect(ResponsiveUtilsPlus.isDesktop(context), isTrue);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    test('returns false for null context', () {
      expect(ResponsiveUtilsPlus.isMobile(null), isFalse);
      expect(ResponsiveUtilsPlus.isTablet(null), isFalse);
      expect(ResponsiveUtilsPlus.isDesktop(null), isFalse);
    });

    testWidgets('handles very small screens correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(0, 0)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isTrue);
                expect(ResponsiveUtilsPlus.isTablet(context), isFalse);
                expect(ResponsiveUtilsPlus.isDesktop(context), isFalse);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles very small screens (1px) correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1, 1)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isTrue);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles very large screens correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(2000, 1500)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isFalse);
                expect(ResponsiveUtilsPlus.isTablet(context), isFalse);
                expect(ResponsiveUtilsPlus.isDesktop(context), isTrue);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles extremely large screens correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(5000, 3000)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isDesktop(context), isTrue);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles boundary value just below mobile breakpoint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(599.9, 800)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isTrue);
                expect(ResponsiveUtilsPlus.isTablet(context), isFalse);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles boundary value just above mobile breakpoint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(600.1, 800)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isMobile(context), isFalse);
                expect(ResponsiveUtilsPlus.isTablet(context), isTrue);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles boundary value just below tablet breakpoint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1023.9, 800)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isTablet(context), isTrue);
                expect(ResponsiveUtilsPlus.isDesktop(context), isFalse);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles boundary value just above tablet breakpoint', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1024.1, 800)),
            child: Builder(
              builder: (context) {
                expect(ResponsiveUtilsPlus.isTablet(context), isFalse);
                expect(ResponsiveUtilsPlus.isDesktop(context), isTrue);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });

  group('ResponsiveUtilsPlus - responsiveValue', () {
    testWidgets('returns mobile value for mobile screens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: 'desktop',
                );
                expect(value, equals('mobile'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns tablet value for tablet screens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: 'desktop',
                );
                expect(value, equals('tablet'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns desktop value for desktop screens', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: 'desktop',
                );
                expect(value, equals('desktop'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('falls back to mobile when tablet is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 'mobile',
                  tablet: null,
                  desktop: 'desktop',
                );
                expect(value, equals('mobile'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('falls back to tablet when desktop is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: null,
                );
                expect(value, equals('tablet'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('falls back to mobile when both tablet and desktop are null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 'mobile',
                  tablet: null,
                  desktop: null,
                );
                expect(value, equals('mobile'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    test('returns mobile value for null context', () {
      final value = ResponsiveUtilsPlus.responsiveValue(
        null,
        mobile: 'mobile',
        tablet: 'tablet',
        desktop: 'desktop',
      );
      expect(value, equals('mobile'));
    });

    testWidgets('works with numeric values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 10,
                  tablet: 20,
                  desktop: 30,
                );
                expect(value, equals(10));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('works with boolean values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: false,
                  tablet: true,
                  desktop: true,
                );
                expect(value, equals(true));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('works with widget values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final mobileWidget = const Text('Mobile');
                final tabletWidget = const Text('Tablet');
                final desktopWidget = const Text('Desktop');
                
                final widget = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: mobileWidget,
                  tablet: tabletWidget,
                  desktop: desktopWidget,
                );
                expect(widget, equals(desktopWidget));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('works with list values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: [1, 2, 3],
                  tablet: [4, 5, 6],
                  desktop: [7, 8, 9],
                );
                expect(value, equals([1, 2, 3]));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('works with map values', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: {'key': 'mobile'},
                  tablet: {'key': 'tablet'},
                  desktop: {'key': 'desktop'},
                );
                expect(value['key'], equals('tablet'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct value for tablet screen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: 'desktop',
                );
                expect(value, equals('tablet'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct value for desktop screen', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1500, 1000)),
            child: Builder(
              builder: (context) {
                final value = ResponsiveUtilsPlus.responsiveValue(
                  context,
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: 'desktop',
                );
                expect(value, equals('desktop'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });

  group('ResponsiveUtilsPlus - responsivePadding', () {
    testWidgets('returns correct padding for mobile', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final padding = ResponsiveUtilsPlus.responsivePadding(
                  context,
                  mobile: 16.0,
                  tablet: 24.0,
                  desktop: 32.0,
                );
                expect(padding, equals(const EdgeInsets.all(16.0)));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses default multiplier when tablet is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final padding = ResponsiveUtilsPlus.responsivePadding(
                  context,
                  mobile: 16.0,
                );
                expect(padding, equals(const EdgeInsets.all(24.0))); // 16 * 1.5
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses default multiplier when desktop is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final padding = ResponsiveUtilsPlus.responsivePadding(
                  context,
                  mobile: 16.0,
                  tablet: 24.0,
                );
                expect(padding, equals(const EdgeInsets.all(32.0))); // 16 * 2.0
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct padding for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final padding = ResponsiveUtilsPlus.responsivePadding(
                  context,
                  mobile: 16.0,
                  tablet: 24.0,
                  desktop: 32.0,
                );
                expect(padding, equals(const EdgeInsets.all(24.0)));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct padding for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final padding = ResponsiveUtilsPlus.responsivePadding(
                  context,
                  mobile: 16.0,
                  tablet: 24.0,
                  desktop: 32.0,
                );
                expect(padding, equals(const EdgeInsets.all(32.0)));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles zero padding correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final padding = ResponsiveUtilsPlus.responsivePadding(
                  context,
                  mobile: 0.0,
                  tablet: 0.0,
                  desktop: 0.0,
                );
                expect(padding, equals(EdgeInsets.zero));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });

  group('ResponsiveUtilsPlus - responsiveFontSize', () {
    testWidgets('returns correct font size for mobile', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = ResponsiveUtilsPlus.responsiveFontSize(
                  context,
                  mobile: 14.0,
                  tablet: 18.0,
                  desktop: 24.0,
                );
                expect(fontSize, equals(14.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses default multiplier when tablet is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final fontSize = ResponsiveUtilsPlus.responsiveFontSize(
                  context,
                  mobile: 14.0,
                );
                expect(fontSize, equals(16.8)); // 14 * 1.2
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses default multiplier when desktop is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = ResponsiveUtilsPlus.responsiveFontSize(
                  context,
                  mobile: 14.0,
                  tablet: 18.0,
                );
                expect(fontSize, equals(21.0)); // 14 * 1.5
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct font size for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final fontSize = ResponsiveUtilsPlus.responsiveFontSize(
                  context,
                  mobile: 14.0,
                  tablet: 18.0,
                  desktop: 24.0,
                );
                expect(fontSize, equals(18.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct font size for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = ResponsiveUtilsPlus.responsiveFontSize(
                  context,
                  mobile: 14.0,
                  tablet: 18.0,
                  desktop: 24.0,
                );
                expect(fontSize, equals(24.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles very small font sizes correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = ResponsiveUtilsPlus.responsiveFontSize(
                  context,
                  mobile: 8.0,
                  tablet: 10.0,
                  desktop: 12.0,
                );
                expect(fontSize, equals(8.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles very large font sizes correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = ResponsiveUtilsPlus.responsiveFontSize(
                  context,
                  mobile: 32.0,
                  tablet: 48.0,
                  desktop: 64.0,
                );
                expect(fontSize, equals(64.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });

  group('ResponsiveUtilsPlus - responsiveColumns', () {
    testWidgets('returns correct column count for mobile', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final columns = ResponsiveUtilsPlus.responsiveColumns(
                  context,
                  mobile: 1,
                  tablet: 2,
                  desktop: 3,
                );
                expect(columns, equals(1));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses default when tablet is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final columns = ResponsiveUtilsPlus.responsiveColumns(
                  context,
                  mobile: 1,
                );
                expect(columns, equals(2)); // default tablet
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses default when desktop is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final columns = ResponsiveUtilsPlus.responsiveColumns(
                  context,
                  mobile: 1,
                  tablet: 2,
                );
                expect(columns, equals(3)); // default desktop
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct column count for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final columns = ResponsiveUtilsPlus.responsiveColumns(
                  context,
                  mobile: 1,
                  tablet: 2,
                  desktop: 3,
                );
                expect(columns, equals(2));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct column count for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final columns = ResponsiveUtilsPlus.responsiveColumns(
                  context,
                  mobile: 1,
                  tablet: 2,
                  desktop: 3,
                );
                expect(columns, equals(3));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles custom column counts correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final columns = ResponsiveUtilsPlus.responsiveColumns(
                  context,
                  mobile: 2,
                  tablet: 4,
                  desktop: 6,
                );
                expect(columns, equals(6));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });

  group('ResponsiveUtilsPlus - responsiveSpacing', () {
    testWidgets('returns correct spacing for mobile', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final spacing = ResponsiveUtilsPlus.responsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                );
                expect(spacing, equals(8.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses default multiplier when tablet is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final spacing = ResponsiveUtilsPlus.responsiveSpacing(
                  context,
                  mobile: 8.0,
                );
                expect(spacing, equals(12.0)); // 8 * 1.5
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct spacing for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final spacing = ResponsiveUtilsPlus.responsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                );
                expect(spacing, equals(12.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct spacing for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final spacing = ResponsiveUtilsPlus.responsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                );
                expect(spacing, equals(16.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('uses default multiplier when desktop is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final spacing = ResponsiveUtilsPlus.responsiveSpacing(
                  context,
                  mobile: 8.0,
                  tablet: 12.0,
                );
                expect(spacing, equals(16.0)); // 8 * 2.0
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });

  group('ResponsiveUtilsPlus - responsiveMaxWidth', () {
    testWidgets('returns correct max width for mobile', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final maxWidth = ResponsiveUtilsPlus.responsiveMaxWidth(
                  context,
                  mobile: 400.0,
                  tablet: 800.0,
                  desktop: 1200.0,
                );
                expect(maxWidth, equals(400.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns null when all values are null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final maxWidth = ResponsiveUtilsPlus.responsiveMaxWidth(
                  context,
                  mobile: null,
                  tablet: null,
                  desktop: null,
                );
                expect(maxWidth, isNull);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct max width for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final maxWidth = ResponsiveUtilsPlus.responsiveMaxWidth(
                  context,
                  mobile: 400.0,
                  tablet: 800.0,
                  desktop: 1200.0,
                );
                expect(maxWidth, equals(800.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('returns correct max width for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final maxWidth = ResponsiveUtilsPlus.responsiveMaxWidth(
                  context,
                  mobile: 400.0,
                  tablet: 800.0,
                  desktop: 1200.0,
                );
                expect(maxWidth, equals(1200.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('falls back correctly when tablet is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final maxWidth = ResponsiveUtilsPlus.responsiveMaxWidth(
                  context,
                  mobile: 400.0,
                  tablet: null,
                  desktop: 1200.0,
                );
                expect(maxWidth, equals(400.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('falls back correctly when desktop is null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final maxWidth = ResponsiveUtilsPlus.responsiveMaxWidth(
                  context,
                  mobile: 400.0,
                  tablet: 800.0,
                  desktop: null,
                );
                expect(maxWidth, equals(800.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('handles double.infinity correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final maxWidth = ResponsiveUtilsPlus.responsiveMaxWidth(
                  context,
                  mobile: double.infinity,
                  tablet: 800.0,
                  desktop: 1200.0,
                );
                expect(maxWidth, equals(double.infinity));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });

  group('ResponsiveContextExtension', () {
    testWidgets('extension getters work correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                expect(context.isMobile, isTrue);
                expect(context.isTablet, isFalse);
                expect(context.isDesktop, isFalse);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveValue works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final value = context.responsiveValue(
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: 'desktop',
                );
                expect(value, equals('mobile'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsivePadding works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final padding = context.responsivePadding(mobile: 16.0);
                expect(padding, equals(const EdgeInsets.all(16.0)));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveFontSize works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = context.responsiveFontSize(mobile: 14.0);
                expect(fontSize, equals(14.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveColumns works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final columns = context.responsiveColumns(mobile: 1);
                expect(columns, equals(1));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveSpacing works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final spacing = context.responsiveSpacing(mobile: 8.0);
                expect(spacing, equals(8.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveMaxWidth works', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(500, 800)),
            child: Builder(
              builder: (context) {
                final maxWidth = context.responsiveMaxWidth(
                  mobile: 400.0,
                  tablet: 800.0,
                  desktop: 1200.0,
                );
                expect(maxWidth, equals(400.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension getters work correctly for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                expect(context.isMobile, isFalse);
                expect(context.isTablet, isTrue);
                expect(context.isDesktop, isFalse);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension getters work correctly for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                expect(context.isMobile, isFalse);
                expect(context.isTablet, isFalse);
                expect(context.isDesktop, isTrue);
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveValue works for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final value = context.responsiveValue(
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: 'desktop',
                );
                expect(value, equals('tablet'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveValue works for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final value = context.responsiveValue(
                  mobile: 'mobile',
                  tablet: 'tablet',
                  desktop: 'desktop',
                );
                expect(value, equals('desktop'));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsivePadding works for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final padding = context.responsivePadding(
                  mobile: 16.0,
                  tablet: 24.0,
                  desktop: 32.0,
                );
                expect(padding, equals(const EdgeInsets.all(24.0)));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsivePadding works for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final padding = context.responsivePadding(
                  mobile: 16.0,
                  tablet: 24.0,
                  desktop: 32.0,
                );
                expect(padding, equals(const EdgeInsets.all(32.0)));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveFontSize works for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final fontSize = context.responsiveFontSize(
                  mobile: 14.0,
                  tablet: 18.0,
                  desktop: 24.0,
                );
                expect(fontSize, equals(18.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveFontSize works for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final fontSize = context.responsiveFontSize(
                  mobile: 14.0,
                  tablet: 18.0,
                  desktop: 24.0,
                );
                expect(fontSize, equals(24.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveColumns works for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final columns = context.responsiveColumns(
                  mobile: 1,
                  tablet: 2,
                  desktop: 3,
                );
                expect(columns, equals(2));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveColumns works for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final columns = context.responsiveColumns(
                  mobile: 1,
                  tablet: 2,
                  desktop: 3,
                );
                expect(columns, equals(3));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveSpacing works for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final spacing = context.responsiveSpacing(
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                );
                expect(spacing, equals(12.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveSpacing works for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final spacing = context.responsiveSpacing(
                  mobile: 8.0,
                  tablet: 12.0,
                  desktop: 16.0,
                );
                expect(spacing, equals(16.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveMaxWidth works for tablet', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(800, 1200)),
            child: Builder(
              builder: (context) {
                final maxWidth = context.responsiveMaxWidth(
                  mobile: 400.0,
                  tablet: 800.0,
                  desktop: 1200.0,
                );
                expect(maxWidth, equals(800.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });

    testWidgets('extension responsiveMaxWidth works for desktop', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MediaQuery(
            data: const MediaQueryData(size: Size(1200, 800)),
            child: Builder(
              builder: (context) {
                final maxWidth = context.responsiveMaxWidth(
                  mobile: 400.0,
                  tablet: 800.0,
                  desktop: 1200.0,
                );
                expect(maxWidth, equals(1200.0));
                return const SizedBox();
              },
            ),
          ),
        ),
      );
    });
  });
}
