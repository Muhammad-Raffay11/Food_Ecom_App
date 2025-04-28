// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_is_empty, must_be_immutable, prefer_typing_uninitialized_variables, file_names, prefer_const_literals_to_create_immutables

import 'package:ecom_app/Controller/UserController/homecontroller.dart';
import 'package:ecom_app/View/User/AddToCart/AddtoCart.dart';
import 'package:ecom_app/View/User/Dishes/NewDish.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewSpecificDish extends StatefulWidget {
  var dishData;

  ViewSpecificDish({super.key, required this.dishData});

  @override
  State<ViewSpecificDish> createState() => _ViewSpecificDishState();
}

class _ViewSpecificDishState extends State<ViewSpecificDish> {
  var homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getDish();
    });
  }

  getDish() async {
    homeController.setData();
    await homeController.getDishByIdCategory(widget.dishData['catkey']);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFF5F5F5), // Light gray background
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Get.back(),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.dishData['name'],
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          centerTitle: true,
          actions: [Padding(
            padding: const EdgeInsets.all(11.0),
            child: GestureDetector(
              onTap: (){
                Get.to(AddToCart());
              },
              child: Icon(
                Icons.shopping_cart,
                size: 28,
                color: Colors.black,),
            ),
          )],
        ),
        body: GetBuilder<HomeController>(builder: (controller) {
          return homeController.dishLoading
              ? Center(child: CircularProgressIndicator())
              : homeController.SelectDish.isEmpty
                  ? Center(
                      child: Text(
                        'No Item Available In this Category',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        itemCount: homeController.SelectDish.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 0.7,
                        ),
                        itemBuilder: (context, index) {
                          var dish = homeController.SelectDish[index];
                          return GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Container(
                                    height: 480,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                                    ),
                                    child: ViewDishPage(dishData: dish),
                                  );
                                },
                              );
                            },
                            child: Card(
                              color: Color.fromARGB(255, 240, 218, 212),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 6,
                              shadowColor: Colors.grey.withOpacity(0.6),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                      child: Image.network(
                                        dish['DishImage'],
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          dish['DishName'].length > 16
                                              ? dish['DishName'].toString().substring(0, 16) + "..."
                                              : dish['DishName'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 4),
                                        Text(
                                          'Rs: ${dish['DishPrice']}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        SizedBox(height: 6),
                                        // **Floating Add to Cart Button**
                                        FloatingActionButton(
                                          heroTag: "btn_$index",
                                          onPressed: () {
                                            // Add to cart action here
                                          },
                                          backgroundColor: Colors.redAccent,
                                          mini: true,
                                          child: Icon(Icons.shopping_cart, color: Colors.white),
                                          elevation: 6,
                                          highlightElevation: 12,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
        }),
      ),
    );
  }
}
