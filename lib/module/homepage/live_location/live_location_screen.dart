import 'package:base_code/package/config_packages.dart';
import 'package:base_code/package/screen_packages.dart';
import 'package:base_code/res/images.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'live_location_controller.dart';

class LiveLocationScreen extends StatefulWidget {
  const LiveLocationScreen({super.key});

  @override
  LiveLocationScreenState createState() => LiveLocationScreenState();
}

class LiveLocationScreenState extends State<LiveLocationScreen> {
  final liveLocationController =
      Get.put<LiveLocationController>(LiveLocationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title:  Center(child: Text('Choose your location',style: const TextStyle().normal18w700.textColor(AppColor.greyscale100),)),

      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 24.0, left: 24.0),
        child: Obx(

          ()=> Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 56,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    border: Border.all(color: AppColor.textFieldFillColor),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.textFieldFillColor),
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: AppColor.greyScale,
                      size: 24,
                    ),
                    const Gap(12),
                    Text(
                      liveLocationController.currentPlaceName.value,
                      style: const TextStyle()
                          .normal16w700
                          .textColor(AppColor.greyscale1Color),
                    ),
                  ],
                ),
              ),
              const Gap(16),
              SizedBox(
                
                height: 180,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),

                  child: GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: liveLocationController.currentPosition,
                    onMapCreated: (GoogleMapController controller) {
                      liveLocationController.controller.complete(controller);
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              GestureDetector(
                onTap: () async {
                  Position currentPosition = await Geolocator.getCurrentPosition(
                    desiredAccuracy: LocationAccuracy.high,
                  );

                  liveLocationController.updatePosition(currentPosition);
                  liveLocationController.getLocationDetails(
                      currentPosition.latitude, currentPosition.longitude);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColor.primaryBlueColor),
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.white,
                  ),
                  child: Row(
                    children: [
                      Image.asset(AppImage.location, height: 48, width: 48),
                      const Gap(12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Use my current location",
                              style: const TextStyle().normal16w700.textColor(AppColor.greyscale100)),
                          Text(
                            liveLocationController.currentPlaceName.value,
                            style: const TextStyle()
                                .normal14w500
                                .textColor(AppColor.greyScaleColor),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios_sharp,size: 12,color: AppColor.greyscale400,),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              CommonAppButton(
                color: AppColor.blueColor1,
                text: 'Continue',
                style: const TextStyle().normal16w700.textColor(AppColor.white),
                buttonType: liveLocationController.isLoading.value==true?ButtonType.progress:ButtonType.enable,

                onTap: (){
                  liveLocationController.isLoading.value=true;
                  Get.toNamed(Routes.bottomNavigationBar);
                },
              ),

              const Gap(16),
              CommonAppButton(
               text: 'Skip',
                style: const TextStyle().normal16w700.textColor(AppColor.blueColor1),
                buttonType: ButtonType.enable,
                color:AppColor.white,
                border: Border.all(color: AppColor.blueColor1),
                onTap: (){

                },
              ),

              const Gap(16)
            ],
          ),
        ),
      ),
    );
  }
}
//
