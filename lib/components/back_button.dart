import 'package:flutter/material.dart';

import '../commons/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final void Function() onPressed;

  const CustomBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Align(alignment: Alignment.topRight,child: InkWell(
        hoverColor: MyColor.transparent,
        splashColor: MyColor.transparent,
        highlightColor: MyColor.transparent,
        onTap: onPressed,child: const Icon(Icons.arrow_back,color: MyColor.white,)));
  }
}
