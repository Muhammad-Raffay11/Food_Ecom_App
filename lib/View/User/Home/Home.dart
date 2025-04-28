// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, file_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecom_app/Controller/UserController/AddToCartController.dart';
import 'package:ecom_app/Controller/UserController/homecontroller.dart';
import 'package:ecom_app/View/User/AddToCart/AddtoCart.dart';
import 'package:ecom_app/View/User/Dishes/Dish.dart';
import 'package:ecom_app/View/User/Home/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({super.key});

  @override
  State<UserDashboard> createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard> {
  var imgList = [
    'https://img.freepik.com/premium-photo/urger-black-background-fried-chicken-png-burger-image-bacon-eggs-food_1122354-8813.jpg?w=740',
    "https://img.freepik.com/free-photo/slice-crispy-pizza-with-meat-cheese_140725-6974.jpg?t=st=1725048401~exp=1725052001~hmac=68eef4eb98a48aeda0fd5b5868333c603e4a2ac317100879e9fe4526345c6399&w=360",
    'https://img.freepik.com/premium-photo/cheesy-fries-topped-with-creamy-sauce-green-onions_83925-14485.jpg?w=740',
    'https://img.freepik.com/premium-photo/dish-brilliant-red-green-bell-peppers-with-colourful-stir-fried-noodles-topped-fresh-cilantro_1196051-1970.jpg?w=740',
  ];

  var homeController = Get.put(HomeController());
  var controller = Get.put(AddToCartController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getCategory();
    });
  }

  getCategory() async {
    await homeController.getCategoryList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF8F8F8), // Light background
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          title: Text(
            'User Dashboard',
            style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
        drawer: Drawer(child: UserDrawerData()),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // 🚀 Modernized Image Slider
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    viewportFraction: 0.9,
                  ),
                  items: imgList
                      .map((item) => ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Stack(
                              children: <Widget>[
                                Image.network(item, fit: BoxFit.cover, width: double.infinity),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Colors.black54, Colors.transparent],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),

              // 📌 Category Heading
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Menu:',
                      style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ],
                ),
              ),

              // 🛍️ Modernized Grid Layout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: homeController.CategoryList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 12.0,
                    childAspectRatio: 0.85, // Improved aspect ratio
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(ViewSpecificDish(dishData: homeController.CategoryList[index]));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(16),
                                    topRight: Radius.circular(16),
                                  ),
                                  child: Image.network(
                                    homeController.CategoryList[index]['CatImage'],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      homeController.CategoryList[index]['name'],
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.delivery_dining, size: 18, color: Colors.blueAccent),
                                        SizedBox(width: 4),
                                        Text(
                                          'Rs:50',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    Row(
                                      children: [
                                        Icon(Icons.access_time_outlined, size: 18, color: Colors.redAccent),
                                        SizedBox(width: 4),
                                        Text(
                                          '25-30 min',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
