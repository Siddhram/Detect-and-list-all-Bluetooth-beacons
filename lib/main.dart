import 'package:bluethoothpro/blecontroler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth Scanner',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          primary: Colors.black,
          secondary: Colors.white,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text("Bluetooth Scanner",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        backgroundColor: Colors.black,
      ),
      body: GetBuilder<BleController>(
        init: BleController(),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (controller.scanResults.isNotEmpty) {
                      return ListView.builder(
                        itemCount: controller.scanResults.length,
                        itemBuilder: (context, index) {
                          final data = controller.scanResults[index];
                          return Card(
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.black,
                            child: ListTile(
                              leading: Icon(
                                Icons.bluetooth,
                                color: Colors.blue,
                                size: 30,
                              ),
                              title: Text(
                                data.device.name.isNotEmpty
                                    ? data.device.name
                                    : "Unknown Device",
                                style: const TextStyle(color: Colors.white),
                              ),
                              subtitle: Text(
                                "ID: ${data.device.id.id}",
                                style: const TextStyle(color: Colors.grey),
                              ),
                              trailing: Text(
                                "${data.rssi} dBm",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Center(
                          child: Text("No devices found",
                              style: TextStyle(color: Colors.black)));
                    }
                  }),
                ),
                ElevatedButton(
                  onPressed: () =>{setState(() {
                     controller.scanDevice();
                  })},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                  ),
                  child: const Text("Scan for Devices",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
