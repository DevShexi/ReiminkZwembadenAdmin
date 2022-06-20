import 'dart:io';

class SensorIconWithUrl {
  const SensorIconWithUrl({
    required this.icon,
    required this.downloadUrl,
  });
  final File icon;
  final String downloadUrl;
}
