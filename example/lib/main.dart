import 'package:flutter/material.dart';
import 'package:smart_utils_plus/smart_utils_plus.dart';

void main() {
  // Configure logger
  LoggerPlus.minLevel = LogLevel.debug;
  LoggerPlus.info('Smart Utils Plus Example App Started');

  runApp(const SmartUtilsExample());
}

class SmartUtilsExample extends StatelessWidget {
  const SmartUtilsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Utils Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? deviceInfo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDeviceInfo();
  }

  Future<void> _loadDeviceInfo() async {
    setState(() => isLoading = true);
    try {
      final info = await DeviceUtilsPlus.getDeviceInfo();
      setState(() {
        deviceInfo = 'Platform: ${info['platform']}\n'
            '${info.entries.where((e) => e.key != 'platform').map((e) => '${e.key}: ${e.value}').join('\n')}';
      });
      LoggerPlus.success('Device info loaded successfully');
    } catch (e) {
      LoggerPlus.error('Failed to load device info: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Utils Plus Example'),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Widget Utils Section
            _buildSection(
              title: 'Widget Utils',
              children: [
                _buildButton(
                  'Success Snackbar',
                  () => WidgetUtilsPlus.showSuccessSnackbar(
                    context,
                    'Operation successful!',
                  ),
                ),
                _buildButton(
                  'Error Snackbar',
                  () => WidgetUtilsPlus.showErrorSnackbar(
                    context,
                    'Something went wrong!',
                  ),
                ),
                _buildButton(
                  'Info Snackbar',
                  () => WidgetUtilsPlus.showInfoSnackbar(
                    context,
                    'Here is some information',
                  ),
                ),
                _buildButton(
                  'Show Toast',
                  () => WidgetUtilsPlus.showToast(
                    context,
                    message: 'This is a toast message!',
                  ),
                ),
                _buildButton(
                  'Show Loader',
                  () {
                    final ctx = context;
                    WidgetUtilsPlus.showLoader(ctx, message: 'Loading...');
                    Future.delayed(const Duration(seconds: 2), () {
                      if (mounted) {
                        WidgetUtilsPlus.hideLoader(ctx);
                      }
                    });
                  },
                ),
                _buildButton(
                  'Confirm Dialog',
                  () async {
                    final ctx = context;
                    final confirmed = await WidgetUtilsPlus.showConfirmDialog(
                      ctx,
                      title: 'Confirm Action',
                      message: 'Are you sure you want to proceed?',
                    );
                    if (confirmed == true && mounted) {
                      WidgetUtilsPlus.showSuccessSnackbar(
                        ctx,
                        'You confirmed!',
                      );
                    }
                  },
                ),
                _buildButton(
                  'Bottom Sheet',
                  () => WidgetUtilsPlus.showBottomSheetPlus(
                    context,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Bottom Sheet',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text('This is a customizable bottom sheet.'),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: const Text('Close'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // String Utils Section
            _buildSection(
              title: 'String Utils',
              children: [
                _buildDemoCard(
                  'Capitalize',
                  StringUtilsPlus.capitalize('hello world'),
                ),
                _buildDemoCard(
                  'Slugify',
                  StringUtilsPlus.slugify('Hello World! This is a test.'),
                ),
                _buildDemoCard(
                  'Truncate',
                  StringUtilsPlus.truncate('This is a very long string', 15),
                ),
                _buildDemoCard(
                  'Email Validation',
                  StringUtilsPlus.isEmail('test@example.com').toString(),
                ),
                _buildDemoCard(
                  'URL Validation',
                  StringUtilsPlus.isUrl('https://flutter.dev').toString(),
                ),
                _buildButton(
                  'Test Null Safety',
                  () {
                    // Test null safety improvements
                    final result1 = StringUtilsPlus.capitalize(null);
                    final result2 = StringUtilsPlus.slugify(null);
                    final result3 = StringUtilsPlus.isEmail(null);
                    WidgetUtilsPlus.showInfoSnackbar(
                      context,
                      'Null safety works! Results: "$result1", "$result2", $result3',
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Date Utils Section
            _buildSection(
              title: 'Date Utils',
              children: [
                _buildDemoCard(
                  'Time Ago',
                  DateUtilsPlus.timeAgo(
                    DateTime.now().subtract(const Duration(hours: 3)),
                  ),
                ),
                _buildDemoCard(
                  'Smart DateTime',
                  DateUtilsPlus.smartDateTime(DateTime.now()),
                ),
                _buildDemoCard(
                  'Format',
                  DateUtilsPlus.format(
                    DateTime.now(),
                    pattern: 'yyyy-MM-dd HH:mm:ss',
                  ),
                ),
                _buildDemoCard(
                  'Is Today',
                  DateUtilsPlus.isToday(DateTime.now()).toString(),
                ),
                _buildDemoCard(
                  'Diff Summary',
                  DateUtilsPlus.diffSummary(
                    DateTime.now().subtract(const Duration(days: 2, hours: 5, minutes: 10)),
                    DateTime.now(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Device Utils Section
            _buildSection(
              title: 'Device Utils',
              children: [
                if (isLoading)
                  const Center(child: CircularProgressIndicator())
                else if (deviceInfo != null)
                  _buildInfoCard(deviceInfo!),
                _buildButton(
                  'Check Connectivity',
                  () async {
                    final ctx = context;
                    final hasConnection = await DeviceUtilsPlus.hasInternetConnection();
                    if (mounted) {
                      WidgetUtilsPlus.showInfoSnackbar(
                        ctx,
                        hasConnection ? 'Internet connection available' : 'No internet connection',
                      );
                    }
                  },
                ),
                _buildDemoCard(
                  'Screen Width',
                  '${DeviceUtilsPlus.screenWidth(context).toStringAsFixed(0)}px',
                ),
                _buildDemoCard(
                  'Screen Height',
                  '${DeviceUtilsPlus.screenHeight(context).toStringAsFixed(0)}px',
                ),
                _buildDemoCard(
                  'Is Mobile',
                  DeviceUtilsPlus.isMobile.toString(),
                ),
                _buildDemoCard(
                  'Is Web',
                  DeviceUtilsPlus.isWeb.toString(),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Logger Section
            _buildSection(
              title: 'Logger Plus',
              children: [
                _buildButton(
                  'Log Info',
                  () {
                    LoggerPlus.info('This is an info message');
                    WidgetUtilsPlus.showInfoSnackbar(
                      context,
                      'Check console for log output',
                    );
                  },
                ),
                _buildButton(
                  'Log Success',
                  () {
                    LoggerPlus.success('Operation completed successfully!');
                    WidgetUtilsPlus.showSuccessSnackbar(
                      context,
                      'Check console for log output',
                    );
                  },
                ),
                _buildButton(
                  'Log Warning',
                  () {
                    LoggerPlus.warning('This is a warning message');
                    WidgetUtilsPlus.showInfoSnackbar(
                      context,
                      'Check console for log output',
                    );
                  },
                ),
                _buildButton(
                  'Log Error',
                  () {
                    LoggerPlus.error('An error occurred');
                    WidgetUtilsPlus.showErrorSnackbar(
                      context,
                      'Check console for log output',
                    );
                  },
                ),
                _buildButton(
                  'Log Debug',
                  () {
                    LoggerPlus.debug('Debug information');
                    WidgetUtilsPlus.showInfoSnackbar(
                      context,
                      'Check console for log output',
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Context Size Helper Section
            _buildSection(
              title: 'Context Size Helper',
              children: [
                _buildDemoCard(
                  '50% Parent Width',
                  '${context.parentWidth(0.5).toStringAsFixed(0)}px',
                ),
                _buildDemoCard(
                  '30% Parent Height',
                  '${context.parentHeight(0.3).toStringAsFixed(0)}px',
                ),
                _buildDemoCard(
                  'Remaining Width (after 100px)',
                  '${context.remainingParentWidth(usedWidth: 100).toStringAsFixed(0)}px',
                ),
                _buildDemoCard(
                  'Aspect Ratio',
                  context.parentAspectRatio()?.toStringAsFixed(2) ?? 'N/A',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }

  Widget _buildDemoCard(String label, String value) {
    return Card(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.blue[700],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String info) {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Text(
          info,
          style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
        ),
      ),
    );
  }
}
