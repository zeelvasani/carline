import 'package:base_code/res/color_schema.dart';
import 'package:base_code/res/text_style.dart';
import 'package:flutter/material.dart';

class CommonContainer extends StatelessWidget {
  final String title;
  final String value;
  final String imagePath;

  const CommonContainer({
    super.key,
    required this.title,
    required this.value,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColor.textFieldFillColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                color: AppColor.textFieldFillColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                imagePath,
                height: 20,
                width: 20,
                color: AppColor.greyscale100,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle().normal10w500.textColor(AppColor.greyScaleColor)

            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle().normal14w700.textColor(AppColor.greyscale100)
            ),
          ],
        ),
      ),
    );
  }
}
