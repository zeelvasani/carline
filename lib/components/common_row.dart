import 'package:base_code/res/text_style.dart';
import 'package:flutter/material.dart';

import '../res/color_schema.dart';

class CommonRow extends StatelessWidget {
  final String leftText;
  final String rightText;
//
  const CommonRow({
    super.key,
    required this.leftText,
    required this.rightText,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: const TextStyle().normal14w500.textColor(AppColor.greyScaleColor)),
        Text(
          rightText,
          style: const TextStyle().normal14w700.textColor(AppColor.greyscale100)),
      ],
    );
  }
}
