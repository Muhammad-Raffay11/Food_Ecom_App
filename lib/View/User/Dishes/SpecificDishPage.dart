// // ignore_for_file: prefer_const_constructors, sized_box_for_whitespace


// import 'package:ecom_app/Controller/UserController/AddToCartController.dart';
// import 'package:ecom_app/Controller/UserController/homecontroller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class ViewSpecificDishPage extends StatefulWidget {
//   const ViewSpecificDishPage({super.key});

//   @override
//   State<ViewSpecificDishPage> createState() => _ViewSpecificDishPageState();
// }

// class _ViewSpecificDishPageState extends State<ViewSpecificDishPage> {

//   var homeController = Get.put(HomeController());
//   var controller = Get.put(AddToCartController());

//    @override
//   void initState() {
//     super.initState();
//      WidgetsBinding.instance.addPostFrameCallback((_) { 
//       getAddToCart();
//     });
//   }

//   getAddToCart(){
//     print(controller.userCart.toList());
//   }
  
//   @override
//   Widget build(BuildContext context) {
    

//     return Scaffold(
//       appBar: AppBar(),
//       body: GetBuilder<AddToCartController>(builder: (controller) {
//           return homeController.dishLoading?
//           Center(child: CircularProgressIndicator()):
//           Column(
//             children: [
//                ListView.builder(
//               shrinkWrap: true,
//               itemCount: controller.userCart.length,
//               itemBuilder: (context,index){
//                 return Padding(
//                   padding: const EdgeInsets.all(3.0),
//                   child: Card(
//                     elevation: 15,
//                     child: Container(
//                       color: Colors.red,
//                       // margin: EdgeInsets.all(5),
//                       height: 85,
//                       child: Center(
//                         child: ListTile(
//                              leading:CircleAvatar(
//                                radius: 30,
//                              backgroundImage: NetworkImage(controller.userCart[index]['DishImage'])),
//                              title: Text(controller.userCart[index]['DishName']),
//                              subtitle: Text(controller.userCart[index]['DishPrice']),
                              
                        
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//             }),
//               Padding(
//                 padding: const EdgeInsets.only(top: 16),
//                 child: Container(
//                    height: MediaQuery.of(context).size.height*0.50,
//                   width: MediaQuery.of(context).size.width*0.99,
//                   decoration: BoxDecoration(
//                     image: DecorationImage(image: NetworkImage(homeController.SelectDish[0]['DishImage'],
//                   ),fit: BoxFit.cover
//                   ),
//                   border: Border.all(color: Colors.black,width: 3),
//                     borderRadius: BorderRadius.circular(23),
//                   ),
//                   // child:  Text(controller.userCart[]['DishName']),
//                 ),
//               ),
//               ListTile(
//                   title: Text(controller.userCart[0]['DishName']),
//                              subtitle: Text(controller.userCart[0]['DishPrice']),
//               ),
//             ],
//           );
//       }
//     ));
//   }
// }