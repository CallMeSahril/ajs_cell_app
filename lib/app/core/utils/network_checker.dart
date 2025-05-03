import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  /// Cek apakah device punya koneksi internet (wifi/data)
  static Future<bool> isConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  /// Cek apakah koneksi internet lambat berdasarkan ping ke google.com
  static Future<bool> isConnectionSlow(
      {Duration timeout = const Duration(seconds: 2)}) async {
    try {
      final stopwatch = Stopwatch()..start();
      final result =
          await InternetAddress.lookup('google.com').timeout(timeout);
      stopwatch.stop();
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        final responseTime = stopwatch.elapsedMilliseconds;
        return responseTime > 2000; // jika lebih dari 2 detik, dianggap lambat
      }
    } catch (e) {
      return true; // anggap lambat jika error
    }
    return false;
  }
}
