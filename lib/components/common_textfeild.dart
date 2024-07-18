import 'package:base_code/package/config_packages.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatelessWidget {
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? hintStyle;
  final double radius;
  final double blurRadius;
  final double? height;
  final double? width;
  final Color shadowColor;
  final TextEditingController? controller;
  final TextDirection? textDirection;
  final String? hintText;
  final void Function()? onTap;
  final Offset offset;
  final EdgeInsetsGeometry? contentPadding;

  const CommonTextField({
    super.key,
    this.radius = 0.0,
    this.blurRadius = 0.0,
    this.offset = const Offset(0, 0),
    this.hintStyle,
    this.height,
    this.width,
    this.controller,
    this.textDirection,
    this.hintText,
    this.shadowColor = Colors.black, // Color of the shadow
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: Stack(
        children: [
          // Inner shadow layer
          CustomPaint(
            size: Size(width ?? 0, height ?? 0),
            painter: InnerShadowPainter(
              radius: radius,
              blurRadius: blurRadius,
              color: shadowColor,
              offset: offset,
            ),
          ),
          // TextField layer
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: Colors.white,
              // Background color of the TextField
            ),
            child: TextFormField(
              controller: controller,
              onTap: onTap,
              textDirection: textDirection,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius),
                  borderSide: BorderSide.none,
                ),
                isDense: true,
                filled: true,
                fillColor: Colors.transparent, // Keeping it transparent to show the inner shadow
                hintText: hintText,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                contentPadding: contentPadding,
                hintStyle: hintStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class InnerShadowPainter extends CustomPainter {
  final double radius;
  final double blurRadius;
  final Offset offset;
  final Color color;

  InnerShadowPainter({
    required this.radius,
    required this.blurRadius,
    required this.offset,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) {
      return;
    }

    final Rect rect = Offset.zero & size;
    final RRect outer = RRect.fromRectAndRadius(rect, Radius.circular(radius));
    final RRect inner = RRect.fromRectAndRadius(
      rect.deflate(blurRadius),
      Radius.circular((radius - blurRadius).clamp(1.0, radius)),
    );

    final Paint paint = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurRadius);

    canvas.saveLayer(rect, Paint());
    canvas.drawRRect(outer, paint);
    canvas.restore();

    final Paint clearPaint = Paint()
      ..blendMode = BlendMode.clear;

    canvas.drawRRect(inner, clearPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
