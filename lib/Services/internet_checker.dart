import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class InternetConnection extends GetxController {
  var connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    checkInternet();
    super.onInit();
  }

  Future<void> checkInternet() async {
    connectionStatus.value = await (Connectivity().checkConnectivity());
  }

  bool isInternetConnected() {
    checkInternet();
    if (connectionStatus.value == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  }
}