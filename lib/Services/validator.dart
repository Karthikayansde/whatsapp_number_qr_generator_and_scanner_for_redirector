import 'package:phone_numbers_parser/phone_numbers_parser.dart';

class Validator{

  static bool isPhValid(String countryCode, String phNo){
    PhoneNumber val = PhoneNumber.parse('+$countryCode$phNo');
    return val.isValid();
  }

  static int validatePhNo(country, phNo){

    if(phNo == ''){
      return 1;
    }
    else if(country.phoneCode == '' || country.phoneCode == null){
      return 3;
    }
    else if(Validator.isPhValid(country.phoneCode, phNo) == false){
      return 2;
    }
    else{
      return 0;
    }
    // return 0 = valid
    // 1 = empty
    // 2 = invalid
    // 3 = country code not existing
  }

  static int validatePhNoDownload(country, phNo){

    if(phNo == ''){
      return 1;
    }
    else if(country.phoneCode == '' || country.phoneCode == null){
      return 3;
    }
    else{
      return 0;
    }
    // return 0 = valid
    // 1 = empty
    // 3 = country code not existing
  }
}