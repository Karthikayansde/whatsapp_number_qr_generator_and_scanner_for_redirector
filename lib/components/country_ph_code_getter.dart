import 'package:country_currency_pickers/country.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/Services/shared_pref.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/constants.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/globals.dart';
import '../commons/app_colors.dart';
import '../commons/app_sizes.dart';
import '../commons/app_strings.dart';

class CountryPhCodeGetter extends StatefulWidget {
  const CountryPhCodeGetter({super.key});

  @override
  State<CountryPhCodeGetter> createState() => _CountryPhCodeGetterState();
}

class _CountryPhCodeGetterState extends State<CountryPhCodeGetter> {
  final controller = Get.put(CountryPhCodeGetterController());

  @override
  Widget build(BuildContext context) {
    // controller.phNoTextController.text = Globals.phoneNo;
    return SizedBox(
      height: 62,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              _openCountryPickerDialog(context);
            },
            highlightColor: Colors.transparent,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Wrap(children: [
              Container(
                height: 62,
                decoration: const BoxDecoration(color: MyColor.blackInside, borderRadius: BorderRadius.all(Radius.circular(MyWidgetSize.radiusCommon))),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 70),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 7, right: 7),
                    child: Obx(() => Text("+${controller.countryISO.value.phoneCode ?? ''}", style: const TextStyle(color: MyColor.white, fontSize: 30))),
                  )),
                ),
              ),
            ]),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
              child: TextField(
            textAlignVertical: TextAlignVertical.center,
            inputFormatters: [
                LengthLimitingTextInputFormatter(15),
                FilteringTextInputFormatter.allow(
                    RegExp("[0-9]"))
            ],
            style: const TextStyle(
              color: MyColor.white,
              fontSize: 30,
            ),
            controller: controller.phNoTextController,
            decoration: InputDecoration(
              hoverColor: Colors.transparent,
              filled: true,
              fillColor: MyColor.blackInside,
              hintText: MyString.phoneNo,
              hintStyle: const TextStyle(color: MyColor.white, fontSize: 30),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(MyWidgetSize.radiusCommon),
              ),
            ),
                keyboardType: TextInputType.phone,
                onChanged: (value) {
              controller.phoneNo.value = value;
                  Globals.phoneNo = value;
                },
          )),
        ],
      ),
    );
  }

  void _openCountryPickerDialog(BuildContext context) => showDialog(
        context: context,
        builder: (context) => CountryPickerDialog(
          titlePadding: const EdgeInsets.all(0),
          title: const Text(
            MyString.countryCodePicker,
            style: TextStyle(
              color: MyColor.white,
              fontSize: 30,
            ),
          ),
          searchInputDecoration: const InputDecoration(hintText: MyString.searchCountry),
          isSearchable: true,
          onValuePicked: (Country country) {
            controller.countryISO.value = country;
          },
          itemBuilder: _buildDialogItem,
        ),
      );

  // drop down data format
  Widget _buildDialogItem(Country country) => Row(
        children: <Widget>[const SizedBox(width: 8.0), Expanded(flex: 1, child: Text("+${country.phoneCode}")), Expanded(flex: 3, child: Text(country.name ?? ''))],
      );
}

class CountryPhCodeGetterController extends GetxController {
  final countryISO = Country().obs;
  var phoneNo = ''.obs;
  TextEditingController phNoTextController = TextEditingController();

  @override
  void onInit() {
    getCountryCode();
    // phNoTextController = TextEditingController();
    super.onInit();
  }

  Future<void> getCountryCode() async {
    String? code = await SharedPrefManager.instance.getStringAsync(Constants.countryISOKey);
    if(code == null){
      SharedPrefIO.putPhISONo(Constants.defaultCountryISO);
    }
    code = await SharedPrefManager.instance.getStringAsync(Constants.countryISOKey);
    countryISO.value = CountryPickerUtils.getCountryByPhoneCode(Constants.defaultCountryISO);
    countryISO.value = CountryPickerUtils.getCountryByPhoneCode(code!);
    // print('asd:${countryISO.value.phoneCode}'); // 91
    // print('asd:${countryISO.value.isoCode}'); // IN
    // print('asd:${countryISO.value.currencyCode}'); // INR
    // print('asd:${countryISO.value.name}'); // India
    // print('asd:${countryISO.value.currencyName}'); // Indian rupee
    // print('asd:${countryISO.value.iso3Code}'); // IND
  }
}
