// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors, prefer_is_empty, prefer_interpolation_to_compose_strings, must_be_immutable, prefer_typing_uninitialized_variables, avoid_print

import 'dart:developer';

import 'package:ecom_app/Controller/Admin/OrderController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewOrderType extends StatefulWidget {
  var type;
  ViewOrderType({super.key, required this.type});

  @override
  State<ViewOrderType> createState() => _ViewOrderTypeState();
}

class _ViewOrderTypeState extends State<ViewOrderType> {
  var controller = Get.put(AdminOrderController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      controller.getAllOrders(widget.type);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: Container(
                    height: 40, width: 40, child: CircularProgressIndicator()),
              )
            : controller.OrderType.length == 0
                ? NoResultsScreen()
                : Obx(()=>
                   ListView.builder(
                      itemCount: controller.OrderType.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        log(controller.OrderType[index].toString());
                        return Container(
                          margin: EdgeInsets.all(5),
                          child: Card(
                            elevation: 10,
                            color: Colors.white,
                            child: Column(
                              children: [
                                ListTile(
                                  title: Text(controller.OrderType[index]["email"]),
                                  subtitle: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(controller.OrderType[index]["address"]),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Icon(Icons.phone),
                                          Text(controller.OrderType[index]
                                              ["contact"]),
                                        ],
                                      ),
                                    ],
                                  ),
                                  trailing: Text("\$ " +
                                      controller.OrderType[index]["totalPrice"]
                                          .toString()),
                                ),
                                widget.type =="pending"?
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    ElevatedButton(
                                      onPressed: () async {
                                      await  controller.UpdateOrder(controller.OrderType[index]["orderkey"],"accepted",
                                        "",index);
                                        setState(() {
                                          
                                        });
                                        print(controller.OrderType[index]["orderkey"]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)))),
                                      child: Text("Accept".toUpperCase()),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)))),
                                      child: Text("Reject".toUpperCase()),
                                    ),
                                    SizedBox(),
                                  ],
                                )
                               :
                               widget.type =="inporgress"? 
                                 Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    ElevatedButton(
                                      onPressed: () async {
                                      await  controller.InProgressOrder(controller.OrderType[index]["orderkey"],"complete",
                                        "",index);
                                        setState(() {
                                          
                                        });
                                        print(controller.OrderType[index]["orderkey"]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)))),
                                      child: Text("Complete".toUpperCase()),
                                    ),
                                                                      SizedBox(),
                                  ],
                                ):
                                  Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(),
                                    ElevatedButton(
                                      onPressed: () async {
                                      await  controller.InProgressOrder(controller.OrderType[index]["orderkey"],"complete",
                                        "",index);
                                        setState(() {
                                          
                                        });
                                        print(controller.OrderType[index]["orderkey"]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          foregroundColor: Colors.white,
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(8)))),
                                      child: Text("Complete".toUpperCase()),
                                    ),
                                                                      SizedBox(),
                                  ],
                                ),


                                SizedBox(height: 10,)
                              ],
                            ),
                          ),
                        );
                      }),
                ),
      ),
    );
  }
}

class NoResultsScreen extends StatelessWidget {
  const NoResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const Spacer(flex: 2),
              ErrorInfo(
                title: "No Results!",
                description:
                    "We couldn't find any matches for your search. Try using different terms or browse our categories.",
                // button: you can pass your custom button,
                btnText: "Search again",
                press: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorInfo extends StatelessWidget {
  const ErrorInfo({
    super.key,
    required this.title,
    required this.description,
    this.button,
    this.btnText,
    required this.press,
  });

  final String title;
  final String description;
  final Widget? button;
  final String? btnText;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16 * 2.5),
            button ??
                ElevatedButton(
                  onPressed: press,
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)))),
                  child: Text(btnText ?? "Retry".toUpperCase()),
                ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}