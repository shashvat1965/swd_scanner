import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swd_scanner/views/scan_times_view.dart';
import '../repo/models/scan_classes.dart';
import '../util.dart';
import '../view_models/scanning_screen_view_model.dart';

class ScanningView extends StatefulWidget {
  final int showId;

  const ScanningView({Key? key, required this.showId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ScanningViewState();
  }
}

class _ScanningViewState extends State<ScanningView> {
  int strength = 1;
  bool isLoading = false;
  QRViewController? controller;
  bool flashOn = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize().initializeSizes(context);
    return Scaffold(
      body: Stack(
        children: [
          qrCodeScanner(),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenSize.screenHeight * 0.725,
                left: (ScreenSize.screenWidth - 40) * 0.5),
            child: InkResponse(
              onTap: () async {
                try {
                  await controller?.toggleFlash();
                  setState(() {
                    flashOn = !flashOn;
                  });
                } catch (e) {
                  var snackBar = const SnackBar(
                    duration: Duration(seconds: 2),
                    content: SizedBox(
                        height: 25,
                        child: Center(child: Text("Flash not supported"))),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: FutureBuilder(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Icon(
                          flashOn ? Icons.flash_on : Icons.flash_off,
                          color: flashOn ? Colors.yellow : Colors.white,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 140),
            child: Container(
              height: 50,
              width: ScreenSize.screenWidth,
              alignment: Alignment.center,
              child: Text(
                isLoading
                    ? "Loading.."
                    : "Select the number of people entering",
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: ScreenSize.screenHeight * 0.85, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    strength++;
                    setState(() {});
                  },
                  child: const Text(
                    "+",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                ),
                Text(
                  strength.toString(),
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (strength > 1) {
                      strength--;
                      setState(() {});
                    } else {
                      var snackBar = const SnackBar(
                        duration: Duration(seconds: 2),
                        content: SizedBox(
                            height: 25,
                            child: Center(child: Text("Cannot go below 1"))),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  child: const Text(
                    "-",
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget qrCodeScanner() {
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
      overlay: QrScannerOverlayShape(
        borderColor: Colors.blue,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: 300,
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      controller.pauseCamera();
      controller.resumeCamera();
    });
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      setState(() {
        isLoading = true;
      });
      String qrCode = scanData.code!;
      qrCode = qrCode.replaceAll('\'', "\"");
      Map<dynamic, dynamic> qrcodeJson = json.decode(qrCode);
      final prefs = await SharedPreferences.getInstance();
      String? jwt = prefs.getString('JWT');
      ScanResponseOnNoError scanResponse;
      try {
        scanResponse = await ScanViewModel()
            .getScan(jwt!, qrcodeJson["qr_code"], 1, strength.toString());
        print(scanResponse.display_message);
        if (scanResponse.scan_code == 0) {
          if (!mounted) return;
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: const Text("Scanned Successfully"),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await controller.resumeCamera();
                        },
                        child: const Text("ok"))
                  ],
                );
              });
        }
      } catch (e) {
        print(e.toString());
        if (e.runtimeType == DioError) {
          var res = (e as DioError).response;
          if (res == null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text("No Net"),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await controller.resumeCamera();
                          },
                          child: const Text("ok")),
                    ],
                  );
                });
          }
          if (e.response?.statusCode == 404 && res != null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content:
                        Text(e.response!.data['display_message'].toString()),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await controller.resumeCamera();
                          },
                          child: const Text("ok")),
                    ],
                  );
                });
          }
          if (e.response?.statusCode == 412 && res != null) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: const Text("Not enough tickets"),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            controller.resumeCamera();
                          },
                          child: const Text("Ok")),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ScanTimes(
                                        timeList: e.response?.data['debug']
                                            ['used_ticket_times'])));
                          },
                          child: const Text("Check Scan Times"))
                    ],
                  );
                });
          } else {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                        "${e.response!.statusCode.toString()} : ${e.response!.statusMessage.toString()}"),
                    actions: [
                      ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pop();
                            await controller.resumeCamera();
                          },
                          child: const Text("ok")),
                    ],
                  );
                });
          }
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(e.toString()),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          await controller.resumeCamera();
                        },
                        child: const Text("ok")),
                  ],
                );
              });
        }
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
