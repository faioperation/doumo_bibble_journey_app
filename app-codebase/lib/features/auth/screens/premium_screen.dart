// import 'package:bible_journey/features/auth/screens/trial_expired_payment_screen.dart';
// import 'package:bible_journey/main_bottom_nav_screen.dart';
// import 'package:flutter/material.dart';
//
// class GoPremiumScreen extends StatelessWidget {
//   const GoPremiumScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F5E9),
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFF9F5E9),
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         centerTitle: true,
//         title: const Text(
//           "Go Premium",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text(
//               "Unlock Your Full Journey",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             const SizedBox(height: 12),
//             const Text(
//               "Gain access to our complete library of guided plans, studies, and an ad-free experience.",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black54,
//               ),
//             ),
//             const SizedBox(height: 32),
//
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>TrialExpiredPaymentScreen()));
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF8BC48A),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Subscription",
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             SizedBox(
//               width: double.infinity,
//               height: 50,
//               child: OutlinedButton(
//                 onPressed: () {
//                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainBottomNavScreen()), (route)=>false);
//                 },
//                 style: OutlinedButton.styleFrom(
//                   side: const BorderSide(color: Color(0xFF8BC48A)),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: const Text(
//                   "Start 7-Day Free Trial",
//                   style: TextStyle(
//                     fontSize: 16,
//                     color: Color(0xFF8BC48A),
//                   ),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 12),
//             const Text(
//               "You can use the app for free for 7 days. The 7-day free period ends. Subscription required after the trial ends.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 12, color: Colors.black45),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
