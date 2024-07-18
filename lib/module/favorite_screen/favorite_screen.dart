import 'package:base_code/module/favorite_screen/favorite_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteController = Get.put<FavoriteController>(FavoriteController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Cars'),
      ),
      body: Obx(
            () => ListView.builder(
          itemCount: favoriteController.favoriteCars.length,
          itemBuilder: (context, index) {
            final car = favoriteController.favoriteCars[index];
            return ListTile(
              title: Text(car['name']),
              leading: Image.network(car['image']),
            );
          },
        ),
      ),
    );
  }
}
