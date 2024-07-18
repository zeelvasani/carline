import 'package:flutter/material.dart';
import 'package:base_code/res/color_schema.dart';
import 'package:base_code/res/text_style.dart';

import '../package/config_packages.dart';
import '../utils/enum.dart';

class CommonAppButton extends StatelessWidget {
  final Function()? onTap;
  final ButtonType buttonType;

  final String? text;
  final Widget? icon;
  final Color? color;
  final Color? imageColor;
  final Color? textColor;
  final TextStyle? style;
  final double? borderRadius;
  final double? width;
  final bool? isShowIcon;
  final double? height;
  final List<BoxShadow>? boxShadow;
  final BoxBorder? border;
  final Widget? prefixIcon;
  final String? imagePath;

  const CommonAppButton({
    super.key,
    this.onTap,
    this.buttonType = ButtonType.disable,
    this.text,
    this.color,
    this.icon,
    this.isShowIcon,
    this.height,
    this.textColor,
    this.style,
    this.borderRadius,
    this.width,
    this.boxShadow,
    this.border,
    this.prefixIcon,
    this.imagePath,
    this.imageColor
  });

  @override
  Widget build(BuildContext context) {
    Color background = const Color(0xffF6F1ED);
    switch (buttonType) {
      case ButtonType.enable:
        {
          background = color ?? AppColor.primaryColor;
        }
        break;
      case ButtonType.disable:
        {
          background = AppColor.primaryColor.withOpacity(.5);
        }
        break;
      case ButtonType.progress:
        break;
    }
    return Material(
      color: background,
      borderRadius: BorderRadius.circular(borderRadius ?? 14),
      child: InkWell(
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
        onTap: (buttonType == ButtonType.enable)
            ? (onTap ?? () {})
            : () {
        },
        child: Container(
          height: height ?? 56,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            border: border,
            borderRadius: BorderRadius.circular(borderRadius ?? 16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imagePath != null)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Image.asset(
                    imagePath!,
                    height: 24,
                    color:imageColor ,
                  ),
                ),
              if (isShowIcon ?? false)
                Row(
                  children: [
                    icon ?? Container(),
                    const SizedBox(width: 10),
                  ],
                ),


              if (buttonType != ButtonType.progress)
                Expanded(
                  child: Text(
                    text ?? "",
                    style: style ??
                        const TextStyle()
                            .normal16w400
                            .textColor(textColor ?? AppColor.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              if (buttonType == ButtonType.progress)
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
