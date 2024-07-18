import 'package:base_code/package/screen_packages.dart';
import 'package:base_code/package/config_packages.dart';

import '../res/images.dart';
enum ButtonType { enable, disable, progress }

class AppImageButton extends StatelessWidget {
  final double? width;
  final double? height;
  final String? text;
  final double? textSize;
  final TextStyle? style;
  final Color? textColor;
  final ButtonType? buttonType;
  final Function()? onTap;
  const AppImageButton({
    super.key,
    this.width = 200,
    this.height = 80,
    required this.text,
    this.textSize = 20,
    this.style,
    this.textColor = Colors.white,
    required this.onTap,
    this.buttonType,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: buttonType == ButtonType.enable ? onTap : () {},
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: width,
            height: height,
            child: Image.asset(
              buttonType == ButtonType.enable ? AppImage.buttonBG : AppImage.lightButtonBG,
              fit: BoxFit.fill,
            ),
          ),
          buttonType == ButtonType.progress
              ? const Positioned.fill(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: AppColor.primaryColor,
                        ),
                      ),
                    ),
                  ),
                )
              : Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Text(
                    text ?? "",
                    textAlign: TextAlign.center,
                    style: style ??
                        const TextStyle().normal20w200.textColor(
                              buttonType == ButtonType.enable ? AppColor.blueColor : AppColor.blueColor.withOpacity(0.4),
                            ),
                  ),
              ),
        ],
      ),
    );
  }
}
