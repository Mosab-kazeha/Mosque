part of 'router_config.dart';

abstract final class AppRouter {
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: AppRoutes.kSplashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.kLoginScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => serviceLocater<AuthBloc>(),
              child: const LoginScreen(),
            ),
      ),
      // GoRoute(
      //   path: AppRoutes.kHomeScreen,
      //   builder:
      //       (context, state) =>
      //       //  BlocProvider(
      //       //   create: (context) => serviceLocater<HomeBloc>(),
      //       //  // //! call the event setSelectedGroup
      //       //   // ..add(
      //       //   //   SetSelectedGroup(state.group, satae.group.students),
      //       //   // ),
      //       //   child:
      //       HomeScreen(group: state.extra as GroupModel),
      //   // ),
      // ),
      GoRoute(
        path: AppRoutes.kCampaignsScreen,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) =>
                      serviceLocater<CampaignsBloc>()..add(GetCampaigns()),
              child: const CampaignsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.kGroupsScreen,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => serviceLocater<GroupsBloc>()..add(GetGroups()),
              child: const GroupsScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.kRoomScreen,
        builder:
            (context, state) => RoomScreen(group: state.extra as GroupModel),
      ),
    ],
  );
}
