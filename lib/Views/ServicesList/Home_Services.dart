// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:talk_time/Views/UserScreen/userscreen.dart';
// import 'package:talk_time/constants/colors.dart';

// class Service {
//   final String imagePath;
//   final String name;
//   final String price;

//   Service({required this.imagePath, required this.name, required this.price});
// }

// final List<Service> services = [
//   Service(
//       imagePath: 'assets/images/homepics/home1.jpg',
//       name: 'Ac Repair',
//       price: '\$500'),
//   Service(
//       imagePath: 'assets/images/homepics/home2.jpg',
//       name: 'Cleaner',
//       price: '\$520'),
//   Service(
//       imagePath: 'assets/images/homepics/home4.jpg',
//       name: 'Painter',
//       price: '\$530'),
//   Service(
//       imagePath: 'assets/images/homepics/home6.jpg',
//       name: 'Decorator',
//       price: '\$550'),
//   Service(
//       imagePath: 'assets/images/homepics/home7.jpg',
//       name: 'Electrician',
//       price: '\$580'),
// ];

// class HomeServicesList extends StatelessWidget {
//   const HomeServicesList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200.h,
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 10.w),
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: services.length,
//           itemBuilder: (context, index) {
//             final service = services[index];
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => const UserScreen()),
//                 );
//               },
//               child: Padding(
//                 padding: EdgeInsets.all(5.r),
//                 child: Container(
//                   width: 200.w,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10.r),
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black12,
//                         blurRadius: 4.r,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(10.r),
//                         child: Image.asset(
//                           service.imagePath,
//                           fit: BoxFit.cover,
//                           height: 130.h,
//                           width: double.infinity,
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.all(8.w),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               service.name,
//                               style: TextStyle(
//                                 fontSize: 13.sp,
//                                 color: Colors.grey,
//                                 fontFamily: 'Urbanist',
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   'Starts From ',
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     color: Colors.black,
//                                     fontFamily: 'Urbanist',
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                                 Text(
//                                   service.price,
//                                   style: TextStyle(
//                                     fontSize: 14.sp,
//                                     fontFamily: 'Urbanist',
//                                     color: AppColors.logocolor,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             // Image.asset(
//                             //   AppImages.star,
//                             //   fit: BoxFit.cover,
//                             //   height: 20.h,
//                             //   width: 100.w,
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
