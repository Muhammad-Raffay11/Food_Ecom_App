// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, prefer_is_empty, prefer_const_constructors, file_names, unnecessary_string_interpolations

import 'package:ecom_app/Controller/UserController/OrderViewController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserOrders extends StatefulWidget {
  var status;
  UserOrders({super.key, required this.status});

  @override
  State<UserOrders> createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
  var orderController = Get.put(viewAllController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getOrder();
    });
  }

  getOrder() async {
    await orderController.getOrders(widget.status);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<viewAllController>(builder: (controller) {
      return orderController.orders.length ==0 ?
      Text("No Order"):
      ListView.builder(
          itemCount: orderController.orders.length,
          itemBuilder: (context, index) {
            return ExpansionTile(
              leading: Icon(Icons.ac_unit),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${orderController.orders[index]["orderkey"].toString().substring(0,15)}',
                    style:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                 Text(
                    orderController.orders[index]["totalPrice"].toString(),
                    style:
                        TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                  ),

                ],
              ),
              backgroundColor: Colors.grey[200],
              children: <Widget>[
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: orderController.orders[index]["orders"].length,
                  itemBuilder: (context,index2){
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage( orderController.orders[index]["orders"][index2]["DishImage"]),
                    ),
                    title: Text(
                   orderController.orders[index]["orders"][index2]["DishName"]
                    ),
                    trailing: 
                    Text('per Dish \$ ${orderController.orders[index]["orders"][index2]["DishPrice"]}'),
                    subtitle: Text("Quantity : ${orderController.orders[index]["orders"][index2]["quantity"]}"),
                  );
                })
              ],
              onExpansionChanged: (bool expanding) {
                // setState(() {
                //   expansionStateList[index] =
                //       expanding; // Update the expansion state for the given tile
                // });
              },
              // trailing: expansionStateList[index]
              //     ? Icon(Icons.keyboard_arrow_up)
              //     : Icon(Icons
              //         .keyboard_arrow_down), // Use the state list to determine the icon
            );
          });
    });
  }
}