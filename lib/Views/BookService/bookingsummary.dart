import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:talk_time/constants/colors.dart';
import 'package:talk_time/constants/reusable_button.dart';
import 'package:talk_time/constants/successscreen.dart';
import 'package:talk_time/widgets/customcontainer.dart';
import 'package:talk_time/widgets/customrow.dart';

class BookingSummary extends StatefulWidget {
  final String address;
  final String hint;
  final String selectedDateTime;

  const BookingSummary({
    super.key,
    required this.address,
    required this.hint,
    required this.selectedDateTime,
  });

  @override
  _BookingSummaryState createState() => _BookingSummaryState();
}

class _BookingSummaryState extends State<BookingSummary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            'Booking Summary',
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: 'Urbanist',
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            CustomContainer(
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomRow(
                      title: 'Booking Date',
                      value: '',
                      icon: Icons.date_range,
                    ),
                    Text(
                      widget.selectedDateTime,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: Colors.grey,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomContainer(
              height: 100.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomRow(
                      title: 'Your Address',
                      value: '',
                    ),
                    CustomRow(
                      title: widget.address,
                      value: '',
                      icon: Icons.location_on,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomContainer(
              height: 80.h,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hint',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                    const CustomRow(
                      title: 'Value',
                      value: '',
                      icon: Icons.note,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.h),
            CustomContainer(
              height: 300.h,
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomRow(
                      title: 'Hair Style Service',
                      value: '21.6s',
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 218, 217, 217),
                    ),
                    const CustomRow(
                      title: 'Quantity',
                      value: 'x1',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 218, 217, 217),
                    ),
                    const CustomRow(
                      title: 'Tax 10',
                      value: '10.0%',
                    ),
                    const CustomRow(
                      title: 'Maintenance',
                      value: '2.00s',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 218, 217, 217),
                    ),
                    const CustomRow(
                      title: 'Tax Amount',
                      value: '4.14s',
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomRow(
                      title: 'Sub Total',
                      value: '21.36s',
                    ),
                    const Divider(
                      color: Color.fromARGB(255, 218, 217, 217),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    const CustomRow(
                      title: 'Total Amount',
                      value: '2300s',
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 29.h,
            ),
            CustomElevatedButton(
              text: 'Confim & booking now',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CongratulationsScreen()),
                );
              },
              height: 40.h,
              width: 300.w,
              backgroundColor: AppColors.logocolor,
              textColor: Colors.white,
              borderRadius: 10.r,
            ),
          ],
        ),
      ),
    );
  }
}
