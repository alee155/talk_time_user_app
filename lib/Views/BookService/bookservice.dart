import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // For formatting date and time
import 'package:talk_time/Views/BookService/bookingsummary.dart';
import 'package:talk_time/constants/colors.dart';
import 'package:talk_time/constants/reusable_button.dart';
import 'package:talk_time/widgets/customcontainer.dart';

class BookServiceScreen extends StatefulWidget {
  const BookServiceScreen({super.key});

  @override
  _BookServiceScreenState createState() => _BookServiceScreenState();
}

class _BookServiceScreenState extends State<BookServiceScreen> {
  bool isAsSoonAsPossibleSelected = false;
  DateTime? selectedDateTime;

  // Function to show Date and Time Picker
  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          isAsSoonAsPossibleSelected = false; // Deselect "As Soon As Possible"
        });
      }
    }
  }

  // Function to get the current formatted date and time
  String _getCurrentDateTime() {
    return DateFormat('EEEE, MMMM d, yyyy - hh:mm a').format(DateTime.now());
  }

  // Function to format the selected date and time
  String _getFormattedSelectedDateTime() {
    if (selectedDateTime != null) {
      return DateFormat('EEEE, MMMM d, yyyy - hh:mm a')
          .format(selectedDateTime!);
    }
    return '';
  }

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
            'Book This Service',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              CustomContainer(
                height: 100.h,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Your Address',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                          Container(
                            height: 25.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 209, 208, 208),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: Center(
                              child: Text(
                                'New',
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Urbanist',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Colors.black,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Lahore, Pakistan',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontFamily: 'Urbanist',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              CustomContainer(
                height: 80.h,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
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
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter text here',
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: 10.h),
                          ),
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: Colors.grey,
                            fontFamily: 'Urbanist',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),

              // "As Soon As Possible" button
              CustomElevatedButton(
                text: 'As Soon As Possible',
                onPressed: () {
                  setState(() {
                    isAsSoonAsPossibleSelected = true;
                    selectedDateTime = null;
                  });
                },
                height: 50.h,
                width: 300.w,
                backgroundColor: AppColors.logocolor,
                textColor: Colors.white,
                borderRadius: 10.r,
              ),
              SizedBox(height: 20.h),
              Container(
                height: 80.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.bgcolor,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 4.r,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Radio(
                        value: 1,
                        groupValue: isAsSoonAsPossibleSelected ? 0 : 1,
                        onChanged: (value) {
                          _selectDateTime(context);
                        },
                        activeColor: AppColors.logocolor,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Schedule an Order',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontFamily: 'Urbanist',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              if (isAsSoonAsPossibleSelected || selectedDateTime != null)
                Column(
                  children: [
                    Text(
                      'Requested Service on',
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                    Text(
                      isAsSoonAsPossibleSelected
                          ? _getCurrentDateTime()
                          : _getFormattedSelectedDateTime(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Urbanist',
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 50.h),
              // Inside the BookServiceScreen
              CustomElevatedButton(
                text: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingSummary(
                        address:
                            'Lahore, Pakistan', // Pass the actual address if dynamic
                        hint: '', // Retrieve the hint text from your TextField
                        selectedDateTime: isAsSoonAsPossibleSelected
                            ? _getCurrentDateTime()
                            : _getFormattedSelectedDateTime(),
                      ),
                    ),
                  );
                },
                height: 40.h,
                width: 300.w,
                backgroundColor: AppColors.logocolor,
                textColor: Colors.white,
                borderRadius: 10.r,
              )
            ],
          ),
        ),
      ),
    );
  }
}
