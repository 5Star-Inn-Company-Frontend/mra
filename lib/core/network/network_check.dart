import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> hasNetworkConnection() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult != ConnectivityResult.none;
}
