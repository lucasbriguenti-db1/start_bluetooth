import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:start_bluetooth/run_commands.dart' as runcommands;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool bluetoothEnabled = false;
  bool loading = false;

  @override
  void initState() {
    verifyBluetooth();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CupertinoButton.filled(
              child: loading ? const CircularProgressIndicator.adaptive() : const Text('Start'),
              onPressed: () async {
                setLoading();
                while (!bluetoothEnabled) {
                  await runcommands.turnOnBluetooth();
                  await Future.delayed(const Duration(seconds: 2));
                  verifyBluetooth();
                }
                setLoading();
              },
            ),
            Text(
              loading ? 'Ativando...' : (bluetoothEnabled ? 'Bluetooth ativado' : 'Bluetooth desativado'),
              style: TextStyle(
                color: loading ? Colors.blue : (bluetoothEnabled ? Colors.green : Colors.red),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> verifyBluetooth() async {
    final isEnabled = await runcommands.isBluetoothEnabled();
    if (isEnabled != bluetoothEnabled) {
      setState(() {
        bluetoothEnabled = isEnabled;
      });
    }
  }

  setLoading() {
    setState(() {
      loading = !loading;
    });
  }
}
