// import 'dart:convert';
// import 'package:bible_journey/app/Urls.dart';
// import 'package:bible_journey/app/constants.dart';
// import 'package:bible_journey/core/services/local_storage_service.dart';
// import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:webview_flutter/webview_flutter.dart';
// import '../../../main_bottom_nav_screen.dart';
//
// class TrialExpiredPaymentScreen extends StatefulWidget {
//   const TrialExpiredPaymentScreen({super.key});
//
//   @override
//   State<TrialExpiredPaymentScreen> createState() => _TrialExpiredPaymentScreenState();
// }
//
// class _TrialExpiredPaymentScreenState extends State<TrialExpiredPaymentScreen> {
//
//   Future<void> makePayment(BuildContext context, String plan, int packageId) async {
//     final url = Uri.parse(Urls.subscriptionUrl);
//     final body = jsonEncode({
//       "plan": plan.toLowerCase(),
//       "package_id": packageId,
//     });
//
//     try {
//       final token = await LocalStorage.getToken();
//       if (token == null || token.isEmpty) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("User not logged in")),
//         );
//         return;
//       }
//
//       final response = await http.post(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": token.startsWith("Bearer ")
//               ? token
//               : "Bearer $token",
//         },
//         body: body,
//       );
//
//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);
//         final checkoutUrl = data['checkout_url'] as String?;
//
//         if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => StripeWebViewScreen(url: checkoutUrl),
//             ),
//           );
//
//           if (result == true) {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (_) => const MainBottomNavScreen(),
//               ),
//                   (route) => false,
//             );
//             //Navigator.popUntil(context, (route) => route.isFirst);
//
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               const SnackBar(content: Text("Payment cancelled")),
//             );
//           }
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Stripe checkout URL missing")),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text("Payment failed: ${response.statusCode}"),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error: $e")),
//       );
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final packages = [
//       {"name": "Weekly", "price": 6.99, "plan": "weekly", "packageId": 2},
//       {"name": "Monthly", "price": 19.99, "plan": "monthly", "packageId": 2},
//       {"name": "Yearly", "price": 39.99, "plan": "yearly", "packageId": 2},
//     ];
//
//     return Scaffold(
//       appBar: CustomAppBar(title: "Choose a Plan", onTap: (){
//         Navigator.pop(context);
//       }),
//       backgroundColor: AppColors.bgColor,
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Image.asset(
//               AppImages.appLogo,
//               height: 100,
//             ),
//             const SizedBox(height: 20),
//             const Text(
//               "Complete your subscription to unlock The App.",
//               textAlign: TextAlign.center,
//               style: TextStyle(fontSize: 16),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: packages.length,
//                 itemBuilder: (context, index) {
//                   final pkg = packages[index];
//                   return PackageCard(
//                     name: pkg['name'] as String,
//                     price: pkg['price'] as double,
//                     plan: pkg['plan'] as String,
//                     packageId: pkg['packageId'] as int,
//                     onTap: () => makePayment(context, pkg['plan'] as String, pkg['packageId'] as int),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class PackageCard extends StatelessWidget {
//   final String name;
//   final double price;
//   final String plan;
//   final int packageId;
//   final VoidCallback onTap;
//
//   const PackageCard({
//     super.key,
//     required this.name,
//     required this.price,
//     required this.plan,
//     required this.packageId,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       elevation: 5,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               name,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueAccent),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               "\$$price",
//               style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               getPlanDescription(plan),
//               style: const TextStyle(fontSize: 14, color: Colors.black54),
//             ),
//
//             const SizedBox(height: 12),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: onTap,
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: AppColors.primary,
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//                 ),
//                 child: Text("Pay \$$price", style: const TextStyle(fontSize: 16)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class StripeWebViewScreen extends StatefulWidget {
//   final String url;
//   const StripeWebViewScreen({super.key, required this.url});
//
//   @override
//   State<StripeWebViewScreen> createState() => _StripeWebViewScreenState();
// }
//
// class _StripeWebViewScreenState extends State<StripeWebViewScreen> {
//   late final WebViewController _controller;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onPageFinished: (_) {
//             setState(() => isLoading = false);
//           },
//           onNavigationRequest: (request) {
//             final url = request.url;
//
//             if (url.contains("success")) {
//               Navigator.pop(context, true);
//               //return NavigationDecision.prevent;
//             }
//
//             if (url.contains("cancel")) {
//               Navigator.pop(context, false);
//               //return NavigationDecision.prevent;
//             }
//
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse(widget.url));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Stripe Payment"),
//         actions: [
//           if (isLoading)
//             const Padding(
//               padding: EdgeInsets.only(right: 16),
//               child: Center(
//                 child: CircularProgressIndicator(color: Colors.white),
//               ),
//             ),
//         ],
//       ),
//       body: WebViewWidget(controller: _controller),
//     );
//   }
// }
// String getPlanDescription(String plan) {
//   switch (plan.toLowerCase()) {
//     case 'weekly':
//       return "Get full access to the app for 1 week with weekly payment.";
//     case 'monthly':
//       return "Get full access to the app for the entire month with monthly payment.";
//     case 'yearly':
//       return "Get full access to the app for 1 year with yearly payment.";
//     default:
//       return "";
//   }
// }
