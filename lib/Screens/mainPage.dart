// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:whisper/Models/userModel.dart';
// import 'package:whisper/Screens/homeScreen.dart';
// import 'package:whisper/Screens/searchScreen.dart';
// import 'package:whisper/Screens/signInScreen.dart';
// import 'package:whisper/Screens/signUpScreen.dart';
// import 'package:whisper/Utils/colors.dart';
// import 'package:whisper/Utils/whispIcons.dart';
// import 'package:whisper/Widgets/appHead.dart';

// class MainPage extends StatefulWidget {
  
//   // MainPage(this.user);
//   const MainPage({super.key});

//   @override
//   State<MainPage> createState() => _MainPageState();
// }

// class _MainPageState extends State<MainPage> {
//   // late UserModel user;
//   // static get user => user;
//   // UserModel user = UserModel.instance();
//   List<Widget> screens = [HomeScreen(), SearchScreen()];
//   int selectIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: dashboardHead(context),
//       body: screens[selectIndex],
//       bottomNavigationBar: CurvedNavigationBar(
//         backgroundColor: AppColors.backgroundColorLight,
//         buttonBackgroundColor: AppColors.backgroundColorLight,
//         color: AppColors.primaryColor,
//         items: const <Widget>[
//           Icon(WhispIcons.whisper4, size: 30),
//           Icon(Icons.search, size: 30),
//         ],
//         onTap: (index) {
//           setState(() {
//             selectIndex = index;
//           });
//         },
//       ),
//     );
//   }
// }
