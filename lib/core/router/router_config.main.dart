part of 'router_config.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.kSplashScreen,
        builder: (context, state) => SplashScreen(serviceLocater()),
      ),
      GoRoute(
        path: AppRoutes.kLoginScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: serviceLocater<AuthBloc>(),
              child: const LoginScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.kCampaignsScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: serviceLocater<CampaignsBloc>()..add(GetCampaigns()),
              child: const CampaignsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.kGroupsScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: serviceLocater<GroupsBloc>()..add(GetGroups()),
              child: const GroupsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.kRoomScreen,
        builder:
            (context, state) => RoomScreen(group: state.extra as GroupModel),
      ),
      GoRoute(
        path: AppRoutes.kSessionScreen,
        builder: (context, state) => const SessionScreen(),
      ),
      GoRoute(
        path: AppRoutes.kStudentScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: serviceLocater<StudentBloc>(),
              child: StudentDetailsScreen(student: state.extra as StudentModel),
            ),
      ),
    ],
  );
}
