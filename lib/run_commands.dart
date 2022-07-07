import 'dart:io';

Future<void> turnOnBluetooth() async {
  await Process.run('blueutil', ['-p', '1']);
}

Future<bool> isBluetoothEnabled() async {
  final processResult = await Process.run('blueutil', ['-p']);
  final result = int.parse(processResult.stdout.toString().trim());
  return result == 1;
}
