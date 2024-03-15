import 'package:shared_preferences/shared_preferences.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/constants.dart';

class SharedPrefManager {
  static final SharedPrefManager _prefManager = SharedPrefManager._internal();
  static const String token = "_Token";
  SharedPrefManager._internal();
  static SharedPrefManager get instance => _prefManager;

  //---------------------------------------
  Future<String?> getStringAsync(String type) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(type);
  }

  Future<bool> setStringAsync(String type, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(type, value);
  }
  //---------------------------------------
}

// related functions
class SharedPrefIO{
  static void putPhISONo(String isoNo){
    SharedPrefManager.instance.setStringAsync(Constants.countryISOKey, isoNo);
  }
}