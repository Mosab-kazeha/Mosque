// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:saas_mosque/core/data/models/group_model.dart';
// import 'package:saas_mosque/core/widget/custom_app_bar.dart';
// import 'package:saas_mosque/features/room/features/attendance/presentation/bloc/attendance_bloc.dart';
// import 'package:saas_mosque/features/room/features/attendance/presentation/screens/attendance_screen.dart';
// import 'package:saas_mosque/features/room/features/home/presentation/presentation/screens/home_screen.dart';
// import 'package:saas_mosque/features/room/features/listening/presentation/bloc/listening_bloc.dart';
// import 'package:saas_mosque/features/room/features/listening/presentation/screens/listening_screen.dart';
// import 'package:saas_mosque/features/room/presentation/bloc/room_bloc.dart';
// import 'package:saas_mosque/features/room/presentation/widgets/custom_drawer.dart';
// import 'package:saas_mosque/features/room/presentation/widgets/custom_navigation_bar.dart';
// import 'package:saas_mosque/injection_container.dart';

// class RoomScreen extends StatefulWidget {
//   final GroupModel group;
//   const RoomScreen({super.key, required this.group});

//   @override
//   State<RoomScreen> createState() => _RoomScreenState();
// }

// class _RoomScreenState extends State<RoomScreen> {
//   int currentIndex = 1;

//   @override
//   void initState() {
//     serviceLocater<RoomBloc>().add(GetPermessions());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xfff3f6fb),
//       appBar: const CustomAppBar(title: 'منصة حلقات'),
//       bottomNavigationBar: CustomNavigationBar(
//         currentIndex: currentIndex,
//         onTap: (index) {
//           setState(() {
//             currentIndex = index;
//           });
//         },
//       ),
//       endDrawer: const CustomDrawer(),
//       body: BlocBuilder<RoomBloc, RoomState>(
//         builder: (context, state) {
//           if (state is RoomLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (state is RoomFailure) {
//             return Text(state.message);
//           }
//           if (state is PermessionsSuccess) {
//             return () {
//               switch (currentIndex) {
//                 case 0:
//                   return BlocProvider.value(
//                     value: serviceLocater.get<AttendanceBloc>(),
//                     child: AttendanceScreen(group: widget.group),
//                   );
//                 case 1:
//                   return HomeScreen(group: widget.group);
//                 case 2:
//                   return BlocProvider.value(
//                     value:
//                         serviceLocater.get<ListeningBloc>()
//                           ..add(FetchListeningData()),
//                     child: ListeningScreen(students: widget.group.students),
//                   );
//                 default:
//                   return const SizedBox();
//               }
//             }();
//           }
//           return const SizedBox();
//         },
//       ),
//     );
//   }
// }
