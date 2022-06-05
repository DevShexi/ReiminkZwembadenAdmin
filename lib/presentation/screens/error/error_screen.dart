import 'package:flutter/material.dart';
import 'package:reimink_zwembaden_admin/common/resources/resources.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    required this.error,
    required this.onRefresh,
    Key? key,
  }) : super(key: key);

  final String error;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(error, textAlign: TextAlign.center),
              const SizedBox(height: 10),
              TextButton.icon(
                onPressed: onRefresh,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text(Strings.labelRetry),
              )
            ],
          ),
        ),
      ),
    );
  }
}
