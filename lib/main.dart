import 'package:flutter_app/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/subscreen.dart';
import 'package:flexify/flexify.dart';
void main() {
  runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(

//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: MainScreen()
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize Flexify for responsive design
    return const Flexify(
      designWidth: 1440, // Design width for desktop
      designHeight: 1024, // Design height for desktop

      app: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AdminDashboardScreen(),
      ),
    );
  }
}