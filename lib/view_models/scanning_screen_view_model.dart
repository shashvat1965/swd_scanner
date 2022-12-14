import 'package:dio/dio.dart';

import '../repo/models/scan_classes.dart';
import '../repo/retrofit/scan_call.dart';

class ScanViewModel {
  Future<ScanResponseOnNoError> getScan(
      String jwt, String qrCode, int showId, String quantity) async {
    final dio = Dio();
    final client = RestClient(dio);
    ScanResponseOnNoError? scanResponseOnNoError;
    ScanPostRequest scanPostRequest =
        ScanPostRequest(quantity: quantity, show_id: showId, qr_code: qrCode);
    scanResponseOnNoError = await client.scanQr("Bearer $jwt", scanPostRequest);
    if (scanResponseOnNoError.scan_code == 0) {
      scanResponseOnNoError.display_message = "Scanned Successfully";
    }
    return scanResponseOnNoError;
  }
}
