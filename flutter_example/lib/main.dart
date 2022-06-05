import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLogs.initLogs(
      logLevelsEnabled: [
        LogLevel.INFO,
        LogLevel.WARNING,
        LogLevel.ERROR,
        LogLevel.SEVERE
      ],
      timeStampFormat: TimeStampFormat.TIME_FORMAT_READABLE,
      directoryStructure: DirectoryStructure.FOR_DATE,
      logTypesEnabled: ["device", "network", "errors"],
      logFileExtension: LogFileExtension.LOG,
      logsWriteDirectoryName: "mqttLofs",
      logsExportDirectoryName: "mqttLogs/Exported",
      debugFileOperations: true,
      enabled: true,
      logSystemCrashes: true,
      isDebuggable: true);

  await FlutterLogs.setMetaInfo(
    appId: "mqtt_example",
    appName: "Flutter MQTT Demo",
    appVersion: "1.0",
    language: "en-US",
    deviceId: "00001",
    environmentId: "1",
    environmentName: "dev",
    organizationId: "1",
    userId: "883023-2832-2323",
    userName: "tester",
    userEmail: "tester@gmail.com",
    deviceSerial: "YJBKKSNKDNK676",
    deviceBrand: "Samsung",
    deviceName: "Note 10+",
    deviceManufacturer: "Samsung",
    deviceModel: " SM-N9750",
    deviceSdkInt: "30",
    latitude: "0.0",
    longitude: "0.0",
    labels: "",
  );

  await FlutterLogs.initMQTT(
      topic: "mqtt",
      brokerUrl: "192.168.18.8", //Add URL without schema
      port: "8883",
      certificate: "assets/ca.crt",
      writeLogsToLocalStorage: false);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MQTT Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'MQTT Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
                'App sends messages to MQTT broker simulating Requests logs'),
            ElevatedButton(
              child: const Text('Simulate a GET log'),
              onPressed: () {
                var logRequest = LogRequest(
                    baseUrl: 'https://localhost',
                    path: '/user',
                    requestMethod: 'GET',
                    paramsOrBodyRequest: '&id=123');
                FlutterLogs.logThis(
                    tag: 'Log MQTT Example',
                    subTag: 'Request',
                    logMessage: jsonEncode(logRequest),
                    level: LogLevel.INFO);
              },
            ),
            ElevatedButton(
              child: const Text('Simulate a PUT log'),
              onPressed: () {
                var logRequest = LogRequest(
                    baseUrl: 'https://localhost',
                    path: '/user',
                    requestMethod: 'PUT',
                    paramsOrBodyRequest:
                        '{"name": "tester", "sector":"manager"}');
                FlutterLogs.logThis(
                    tag: 'Log MQTT Example',
                    subTag: 'Request',
                    logMessage: jsonEncode(logRequest),
                    level: LogLevel.INFO);
              },
            ),
            ElevatedButton(
              child: const Text('Simulate a DELETE log'),
              onPressed: () {
                var logRequest = LogRequest(
                    baseUrl: 'https://localhost',
                    path: '/user',
                    requestMethod: 'DELETE',
                    paramsOrBodyRequest: '{"id": "123"}');
                FlutterLogs.logThis(
                    tag: 'Log MQTT Example',
                    subTag: 'Request',
                    logMessage: jsonEncode(logRequest),
                    level: LogLevel.INFO);
              },
            ),
          ],
        ),
      ),
    );
  }
}

///Log Request template
class LogRequest {
  final String baseUrl;
  final String path;
  final String requestMethod;
  final String paramsOrBodyRequest;

  LogRequest(
      {required this.baseUrl,
      required this.path,
      required this.requestMethod,
      required this.paramsOrBodyRequest});

  Map<String, dynamic> toJson() => {
        'baseUrl': baseUrl,
        'path': path,
        'requestMethod': requestMethod,
        'paramsOrBodyRequest': paramsOrBodyRequest
      };
}
