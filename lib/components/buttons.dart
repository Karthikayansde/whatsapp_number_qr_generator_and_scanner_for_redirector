import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_colors.dart';
import 'package:whatsapp_number_qr_generator_and_scanner_for_redirector/commons/app_sizes.dart';

class OutlinedBtn extends StatelessWidget {
  final void Function() onPressed;
  final IconData? icon;
  final String? iconPath;
  final String label;
  final bool isSvgIcon;

  const OutlinedBtn({
    required this.onPressed,
    this.icon,
    required this.label,
    super.key,
    required this.isSvgIcon,
    this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    int screenWidth = MediaQuery.of(context).size.width.toInt();
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(MyWidgetSize.radiusCommon),
              color: MyColor.blackBG,
              shape: BoxShape.rectangle,
              border: Border.all(
                color: MyColor.greenBTN,
                width: 0.5,
              )),
          height: 50,
          width: 350,
          // color: Colors.black26,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            isSvgIcon
            ? SvgPicture.asset(
                iconPath!,
                colorFilter: const ColorFilter.mode(MyColor.greenBTN, BlendMode.srcIn),
                height: 24,
                width: 24,
                fit: BoxFit.cover,

                /// semanticsLabel: 'My SVG Image',
              )
            : Icon(
                icon,
                color: MyColor.greenBTN,
                size: 28,
              ),
            const SizedBox(width: 5,),
            Text(
                label,
                style: TextStyle(color: MyColor.greenBTN, fontSize: screenWidth <= 280? MyFontSizes.buttonTextSmall:screenWidth <= 480 ? MyFontSizes.buttonTextPhone : MyFontSizes.buttonText),
              ),
          ]),
        ),
      ),
    );
  }
}

class ActionBtn extends StatelessWidget {
  final void Function() onPressed;
  final String label;

  const ActionBtn({super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(MyWidgetSize.elevation),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(backgroundColor: MyColor.greenBTN, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(MyWidgetSize.radiusCommon)), fixedSize: const Size(350, 60)),
        child: Text(
          label,
          style: const TextStyle(color: MyColor.white, fontSize: MyFontSizes.buttonText),
        ),
      ),
    );
  }
}
