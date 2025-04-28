// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps, prefer_const_literals_to_create_immutables, await_only_futures

import 'package:ecom_app/Controller/UserController/AddToCartController.dart';
import 'package:ecom_app/View/User/Home/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddToCart extends StatefulWidget {
  const AddToCart({super.key});

  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  final AddToCartController controller = Get.put(AddToCartController());
  int totalPrice = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      calculateTotalPrice();
      setState(() {});
    });
  }

  /// Function to calculate total price
  void calculateTotalPrice() {
    totalPrice = 0;
    for (var item in controller.userCart) {
      var dishPrice = int.tryParse(item["DishPrice"].toString()) ?? 0;
      var quantity = item["quantity"] ?? 1;
      totalPrice += (dishPrice * quantity).toInt();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: UserDrawerData(),
        ),
        appBar: AppBar(
          title: Text("Your Cart", style: TextStyle(fontWeight: FontWeight.bold)),
          centerTitle: true,
        ),
        body: GetBuilder<AddToCartController>(builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.userCart.length,
                  itemBuilder: (context, index) {
                    var dishPrice = int.tryParse(controller.userCart[index]["DishPrice"]?.toString() ?? "0") ?? 0;
                    var quantity = (controller.userCart[index]["quantity"] as num?)?.toInt() ?? 1;
                    var price = dishPrice * quantity;

                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                controller.userCart[index]["DishImage"],
                                height: 80,
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.userCart[index]["DishName"],
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5),
                                  Text("Price: \Rs:${dishPrice}",
                                      style: TextStyle(color: Colors.grey[700])),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove_circle, color: Colors.redAccent),
                                        onPressed: () async {
                                          await controller.updateCart(index, "dec");
                                          calculateTotalPrice();
                                          setState(() {});
                                        },
                                      ),
                                      Text(
                                        quantity.toString(),
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add_circle, color: Colors.greenAccent),
                                        onPressed: () async {
                                          await controller.updateCart(index, "inc");
                                          calculateTotalPrice();
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  "\Rs:${price}",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                                ),
                                SizedBox(height: 5),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () {
                                    controller.removeItem(index);
                                    calculateTotalPrice();
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Price", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("\Rs:${totalPrice}",
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent)),
                      ],
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.showBottomSheetFunc(context, totalPrice);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Center(
                        child: Text(
                          "Order Now",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
