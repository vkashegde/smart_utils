import 'package:flutter/material.dart';
import 'package:smart_utils_plus/smart_utils.dart';

void main() {
  runApp(const SmartUtilsExample());
}

class SmartUtilsExample extends StatelessWidget {
  const SmartUtilsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Utils Example',
      home: Scaffold(
        appBar: AppBar(title: const Text('Smart Utils Example')),
        body: Center(
          child: Builder(
            builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () =>
                      WidgetUtilsPlus.showSuccessSnackbar(context, "Operation Successful!"),
                  child: const Text("Show Snackbar"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => WidgetUtilsPlus.showLoader(context, message: "Loading..."),
                  child: const Text("Show Loader"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => WidgetUtilsPlus.hideLoader(context),
                  child: const Text("Hide Loader"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
