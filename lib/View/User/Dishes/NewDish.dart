// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_typing_uninitialized_variables, unused_import, file_names, await_only_futures, prefer_const_constructors_in_immutables

import 'package:ecom_app/Controller/UserController/AddToCartController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewDishPage extends StatefulWidget {
  final Map<String, dynamic> dishData;

  ViewDishPage({super.key, required this.dishData});

  @override
  State<ViewDishPage> createState() => _ViewDishPageState();
}

class _ViewDishPageState extends State<ViewDishPage> {
  var controller = Get.find<AddToCartController>();
  bool status = false; // Track if item is in cart

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkDish();
    });
  }

  checkDish() async {
    var res = await controller.checkCart(widget.dishData);
    setState(() {
      status = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Dish Details")),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Dish Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  widget.dishData['DishImage'],
                  height: 125,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 15),

              // Dish Name
              Text(
                widget.dishData['DishName'],
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),

              // Price
              Text(
                "\Rs: ${widget.dishData['DishPrice']}",
                style: TextStyle(fontSize: 20, color: Colors.green,fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 9),

              // Description (Placeholder for now)
              Text(
                "A delicious dish made with fresh ingredients and amazing flavors. Perfect for any meal!",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              SizedBox(height: 20),

              // Add/Remove from Cart Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: status ? Colors.red : Colors.black,
                  ),
                  onPressed: () {
                    controller.userAddToCart(widget.dishData);
                    setState(() {
                      status = !status;
                    });

                    // Show Snackbar
                    Get.snackbar(
                      status ? 'Added' : 'Removed',
                      status ? 'Item added to cart' : 'Item removed from cart',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.black87,
                      colorText: Colors.white,
                      duration: Duration(seconds: 2),
                    );
                  },
                  child: Text(
                    status ? "Remove from Cart" : "Add to Cart",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
