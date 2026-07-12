// import 'package:flutter/material.dart';
//
// class CustomProfile extends StatelessWidget {
//   final String title;
//   final String box;
//   final TextEditingController controller;   // <-- Add this
//
//   const CustomProfile({
//     super.key,
//     required this.title,
//     required this.box,
//     required this.controller,              // <-- Receive controller
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(2),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 20),
//             child: Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//
//           const SizedBox(height: 8),
//
//           Padding(
//             padding: const EdgeInsets.only(left: 18, right: 10),
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Color(0xffDAD6D6)),
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               child: TextField(
//                 controller: controller,       // <-- Use passed controller
//                 decoration: InputDecoration(
//                   hintText: box,
//                   border: InputBorder.none,
//                   contentPadding: EdgeInsets.symmetric(
//                     horizontal: 10,
//                     vertical: 12,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CustomProfile extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final bool enabled;

  const CustomProfile({
    super.key,
    required this.title,
    required this.controller,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextField(
        controller: controller,
        enabled: enabled,
        decoration: InputDecoration(
          labelText: title,
          filled: true,
          fillColor: enabled ? Colors.white : Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
