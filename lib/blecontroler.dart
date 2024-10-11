import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBlue ble = FlutterBlue.instance;
  var _scanResults = <ScanResult>[].obs;

  Future<void> scanDevice() async {
    var scanPermissionStatus = await Permission.bluetoothScan.request();
    var connectPermissionStatus = await Permission.bluetoothConnect.request();

    if (scanPermissionStatus.isGranted && connectPermissionStatus.isGranted) {
      _scanResults.clear(); 
      ble.startScan(timeout: Duration(seconds: 10));

      ble.scanResults.listen((results) {
        _scanResults.assignAll(results); 
      });

      await Future.delayed(Duration(seconds: 10));
      ble.stopScan();
    } else {
      print("Bluetooth permissions not granted");
    }
  }
  List<ScanResult> get scanResults => _scanResults;
}
