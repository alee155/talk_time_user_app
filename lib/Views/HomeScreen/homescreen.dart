import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:talk_time/Models/CategoryModel.dart';
import 'package:talk_time/Models/UserModel.dart';
import 'package:talk_time/Views/Drawer/drawerscreen.dart';
import 'package:talk_time/Views/ExploreCategory/explorecategory.dart';
import 'package:talk_time/Views/MyBookings/NotificationScreen/notificationscreen.dart';
import 'package:talk_time/constants/colors.dart';
import 'package:talk_time/utility/user_service.dart';
import 'package:talk_time/widgets/image_carousel.dart';
import 'package:talk_time/widgets/sectiontitle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  final List<String> _imagePaths = [
    'assets/images/homepics/slider1.jpg',
    'assets/images/homepics/slider4.jpg',
    'assets/images/homepics/slider2.jpg',
    'assets/images/homepics/slider3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _fetchCategories();
    _pageController.addListener(() {
      setState(() {});
    });
  }

  UserModel? currentUser;
  Future<void> _loadUserData() async {
    UserService userService = UserService(); // Initialize the UserService
    UserModel? user = await userService.getUserDetails();
    setState(() {
      currentUser = user;
    });
  }

  List<Category> _categories = [];

  Future<void> _fetchCategories() async {
    try {
      QuerySnapshot adminSnapshot =
          await FirebaseFirestore.instance.collection('Admin').get();

      List<Category> categoryList = [];

      for (var adminDoc in adminSnapshot.docs) {
        QuerySnapshot categorySnapshot =
            await adminDoc.reference.collection('categories').get();

        for (var categoryDoc in categorySnapshot.docs) {
          String categoryId = categoryDoc.id; // Getting the document ID
          String? catename = categoryDoc['catename'] as String?;
          String? catedisname = categoryDoc['catedisname'] as String?;

          // Handle Timestamp correctly
          Timestamp? createdAtTimestamp =
              categoryDoc['createdAt'] as Timestamp?;
          String createdAt = createdAtTimestamp != null
              ? createdAtTimestamp.toDate().toString()
              : '';

          String? description = categoryDoc['description'] as String?;
          String? imageURL = categoryDoc['imageURL'] as String?;
          String? uid = categoryDoc['uid'] as String?;

          if (catename != null) {
            categoryList.add(Category(
              categoryId: categoryId,
              catename: catename,
              catedisname: catedisname ?? '',
              createdAt: createdAt, // Now it's a String
              description: description ?? '',
              imageURL: imageURL ?? '',
              uid: uid ?? '',
            ));
          }
        }
      }

      setState(() {
        _categories = categoryList; // Update the state with fetched categories
      });
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.bgcolor,
      drawer: const DrawerView(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            SizedBox(height: 20.h),
            ImageCarousel(
              pageController: _pageController,
              imagePaths: _imagePaths,
            ),
            SizedBox(height: 10.h),
            SectionTitle(
              title: 'Categories',
              actionText: 'See all',
              onActionTap: () {},
            ),
            SizedBox(height: 5.h),
            GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 1 / 1.2,
              ),
              itemCount: _categories.isNotEmpty
                  ? _categories.length
                  : 6, // Show 6 shimmer placeholders if loading
              itemBuilder: (context, index) {
                if (_categories.isEmpty) {
                  // Shimmer loading effect
                  return Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      height: 80.h,
                      width: 90.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        color: Colors.white,
                      ),
                    ),
                  );
                }

                // Actual category item when data is fetched
                final category = _categories[index];

                return GestureDetector(
                  onTap: () {
                    // Handle tap here, navigate to another screen or show details
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExploreCategory(
                          category: category,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 80.h,
                    width: 90.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4.r,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.h, left: 5.w, right: 3.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Image.network(
                              category.imageURL,
                              fit: BoxFit.cover,
                              color: Colors.black,
                              height: 40.h,
                              width: 40.w,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error, size: 40);
                              },
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            category.catename,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Urbanist',
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 250.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.r),
          bottomRight: Radius.circular(20.r),
        ),
        gradient: const LinearGradient(
          colors: [AppColors.logocolor, AppColors.logocolor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30.h,
          ),
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Text(
              'Welcome',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white,
                fontFamily: 'Urbanist',
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  currentUser != null ? currentUser!.name : 'Loading...',
                  style: TextStyle(
                    fontSize: 19.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Urbanist',
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen()),
                      );
                    },
                    child:
                        const Icon(Icons.notifications, color: Colors.white)),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Colors.white),
                SizedBox(width: 8.w),
                Text(
                  'Lahore, Pakistan',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    fontFamily: 'Urbanist',
                  ),
                ),
                SizedBox(width: 8.w),
                const Icon(Icons.arrow_drop_down, color: Colors.white),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 15.w,
            ),
            child: _buildSearchBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.white, width: 1),
        color: Colors.white,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
          children: [
            const Icon(Icons.search, color: AppColors.logocolor),
            SizedBox(width: 8.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search...',
                  hintStyle: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                    fontFamily: 'Urbanist',
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            const Icon(Icons.filter_list, color: AppColors.logocolor),
          ],
        ),
      ),
    );
  }
}
