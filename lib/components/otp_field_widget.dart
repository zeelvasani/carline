import 'package:base_code/components/image_button.dart';
import 'package:base_code/modal/digits_map_object.dart';
import 'package:base_code/package/config_packages.dart';
import 'package:base_code/res/color_schema.dart';
import 'package:base_code/res/text_style.dart';

import '../res/images.dart';

class OtpFieldWidget extends StatefulWidget {
  final String? text, subText;
  final TextStyle? style;
  final ButtonType? buttonType;

  const OtpFieldWidget({super.key, this.text, this.style, required this.onButtonTap, this.subText, this.buttonType});

  final Function(String) onButtonTap;

  @override
  State<OtpFieldWidget> createState() => _OtpFieldWidgetState();
}

class _OtpFieldWidgetState extends State<OtpFieldWidget> {
  final int otpCount = 4;

  String tempPassCodeString = "";

  final List<DigitsMapObject> digitsList = [
    DigitsMapObject(digits: [1, 2, 3]),
    DigitsMapObject(digits: [4, 5, 6]),
    DigitsMapObject(digits: [7, 8, 9]),
    DigitsMapObject(digits: [0]),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.text?.toUpperCase() ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle().normal18w700.textColor(AppColor.blueColor1),
        ),
        Text(
          widget.subText?.toUpperCase() ?? "",
          textAlign: TextAlign.center,
          style: const TextStyle().normal16w400.textColor(AppColor.blueColor1),
        ),
        const Gap(30),
        SizedBox(
          height: 42,
          child: Center(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: ListView.separated(
                itemCount: otpCount,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                separatorBuilder: (context, index) => const Gap(10),
                itemBuilder: (context, index) {
                  return Container(
                    height: 42,
                    width: 42,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.blueColor1),
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.transparent,
                    ),
                    child: tempPassCodeString.length >= index + 1
                        ? Center(
                            child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColor.blueColor1,
                              ),
                              height: 15,
                              width: 15,
                            ),
                          )
                        : Container(),
                  );
                },
              ),
            ),
          ),
        ),
        const Gap(20),
        for (int i = 0; i < digitsList.length; i++) ...{
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int j = 0; j < digitsList[i].digits!.length; j++) ...{
                  i == 3
                      ? Container(
                          height: 40,
                          width: 40,
                          margin: const EdgeInsets.all(2.5),
                        )
                      : Container(),
                  InkWell(
                    onTap: () async {
                      HapticFeedback.heavyImpact();
                      if (tempPassCodeString.length < otpCount) {
                        tempPassCodeString = tempPassCodeString + digitsList[i].digits![j].toString();
                      }
                      setState(() {});
                    },
                    child: Container(
                      height: 40,
                      width: 40,
                      margin: const EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          digitsList[i].digits![j].toString(),
                          style: const TextStyle(height: 1).normal42w600.textColor(
                                AppColor.blueColor1,
                              ),
                        ),
                      ),
                    ),
                  ),
                  i == 3
                      ? InkWell(
                          onTap: () {
                            HapticFeedback.heavyImpact();

                            if (tempPassCodeString.isNotEmpty) {
                              tempPassCodeString = tempPassCodeString.substring(0, tempPassCodeString.length - 1);
                            }
                            setState(() {});
                          },
                          child: Container(
                            height: 40,
                            width: 40,
                            margin: const EdgeInsets.all(2.5),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Image.asset(
                                AppImage.clearIcon,
                                height: 30,
                                width: 30,
                                color: AppColor.blueColor1,
                              ),
                            ),
                          ),
                        )
                      : Container()
                }
              ],
            ),
          ),
        },
        const Gap(30),
        AppImageButton(
          buttonType: widget.buttonType ?? ButtonType.disable,
          text: 'NEXT',
          onTap: () {
            widget.onButtonTap(tempPassCodeString);
          },
        ),
      ],
    );
  }
}
