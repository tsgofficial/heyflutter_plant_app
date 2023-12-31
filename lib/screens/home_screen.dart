import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:heyflutter_challenge/components/plant_tile.dart';
import 'package:heyflutter_challenge/getx_controllers/home_controller.dart';
import 'package:heyflutter_challenge/repository/const.dart';
import 'package:heyflutter_challenge/screens/detail_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(15 + 50 + 15 + 30 + 20 + 30),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios),
                  ),
                  Text(
                    'Search Products',
                    style: getFont(16, color: Colors.black54),
                  ),
                  const CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundImage: AssetImage('assets/girl_image.jpg'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      cursorColor: Colors.black54,
                      cursorHeight: 15,
                      onChanged: textFieldOnChanged,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: Image.asset(
                          'assets/search.png',
                          scale: 30,
                          color: Colors.black54,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.white, width: 0),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  InkWell(
                    onTap: sortList,
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Image.asset(
                          'assets/equalizer.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Obx(
                  () => StaggeredGrid.extent(
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30,
                    maxCrossAxisExtent: 300,
                    children: [
                      Text(
                        'Found ${_homeController.searchedPlants.length} Results',
                        style: getFontBold(32),
                      ),
                      ...List.generate(
                        _homeController.searchedPlants.length,
                        (index) => InkWell(
                          onTap: () => Get.to(
                            () => DetailScreen(
                              plant: _homeController.searchedPlants[index],
                              isFromHome: true,
                            ),
                          ),
                          child: PlantTile(
                            plant: _homeController.searchedPlants[index],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void textFieldOnChanged(String value) {
    _homeController.searchedPlants.value = _homeController.plants
        .where((element) =>
            (element.name.toLowerCase().contains(value.toLowerCase()) ||
                element.image
                    .join('')
                    .toLowerCase()
                    .contains(value.toLowerCase()) ||
                element.price.toLowerCase().contains(value.toLowerCase()) ||
                element.type.toLowerCase().contains(value.toLowerCase())))
        .toList();
  }

  void sortList() {
    if (_homeController.isListSortedFromAZ == null) {
      _homeController.searchedPlants
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      _homeController.isListSortedFromAZ = true;
    } else if (_homeController.isListSortedFromAZ == true) {
      _homeController.searchedPlants
          .sort((a, b) => b.name.toLowerCase().compareTo(a.name.toLowerCase()));
      _homeController.isListSortedFromAZ = false;
    } else {
      _homeController.searchedPlants
          .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
      _homeController.isListSortedFromAZ = true;
    }
  }
}
