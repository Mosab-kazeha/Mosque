// import 'package:flutter/material.dart';
// import 'package:saas_mosque/core/style/app_palette.dart';

// class LoginButton extends StatelessWidget {
//   final VoidCallback onPressed;
//   final bool isLoading;

//   const LoginButton({
//     super.key,
//     required this.onPressed,
//     required this.isLoading,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: ElevatedButton(
//         onPressed: isLoading ? null : onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: AppPalette.white,
//           foregroundColor: AppPalette.backgroundColor,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//           elevation: 0,
//         ),
//         child:
//             isLoading
//                 ? const CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     AppPalette.backgroundColor,
//                   ),
//                 )
//                 : const Text(
//                   "تسجيل الدخول",
//                   style: TextStyle(
//                     color:  AppPalette.backgroundColor,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Roboto',
//                   ),
//                   textDirection: TextDirection.rtl,
//                 ),
//       ),
//     );
//   }
// }
