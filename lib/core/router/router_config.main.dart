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
            (context, state) => BlocProvider(
              create: (context) => AuthBloc(serviceLocater<AuthRepo>()),
              child: const LoginScreen(),
            ),
        // builder:
        //     (context, state) => BlocProvider.value(
        //       value: serviceLocater<AuthBloc>(),
        //       child: const LoginScreen(),
        //     ),
      ),
      GoRoute(
        path: AppRoutes.kCampaignsScreen,
        builder:
            (context, state) => BlocProvider(
              create:
                  (context) => CampaignsBloc(serviceLocater<CampaignsRepo>()),
              child: const CampaignsScreen(),
            ),
        // builder:
        //     (context, state) => BlocProvider.value(
        //       value: serviceLocater<CampaignsBloc>(),
        //       child: const CampaignsScreen(),
        //     ),
      ),
      GoRoute(
        path: AppRoutes.kGroupsScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => GroupsBloc(serviceLocater<GroupsRepo>()),
              child: const GroupsScreen(),
            ),
        // builder:
        //     (context, state) => BlocProvider.value(
        //       value: serviceLocater<GroupsBloc>(),
        //       child: const GroupsScreen(),
        //     ),
      ),
      GoRoute(
        path: AppRoutes.kRoomScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => RoomBloc(serviceLocater<RoomRepo>()),
              child: RoomScreen(group: state.extra as GroupModel),
            ),
        // builder:
        //     (context, state) => BlocProvider.value(
        //       value: serviceLocater<RoomBloc>(),
        //       child: RoomScreen(group: state.extra as GroupModel),
        //     ),
      ),
      // GoRoute(
      //   path: AppRoutes.kSessionScreen,
      //   builder:
      //       (context, state) => BlocProvider.value(
      //         value: serviceLocater.get<ListeningBloc>(),
      //         child: SessionScreen(student: state.extra as StudentModel),
      //       ),
      // ),
      GoRoute(
        path: AppRoutes.kSessionScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: serviceLocater.get<SessionBloc>(),
              child: const SessionScreen(),
            ),
      ),
      GoRoute(
        path: AppRoutes.kStudentScreen,
        builder:
            (context, state) => BlocProvider(
              create: (context) => StudentBloc(serviceLocater<StudentRepo>()),
              child: StudentDetailsScreen(student: state.extra as StudentModel),
            ),

        // builder:
        //     (context, state) => BlocProvider.value(
        //       value: serviceLocater<StudentBloc>(),
        //       child: StudentDetailsScreen(student: state.extra as StudentModel),
        //     ),
      ),
      GoRoute(
        path: AppRoutes.kSurahsScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: serviceLocater.get<SessionBloc>(),
              // create:
              //     (context) => SessionBloc(serviceLocater.get<SessionRepo>()),
              child: SurahsScreen(
                student:
                    // serviceLocater.get<SessionBloc>().selectedStudent ??
                    state.extra as StudentModel,
              ),
            ),
      ),
      GoRoute(
        path: AppRoutes.kSurahPagesScreen,
        builder:
            (context, state) => BlocProvider.value(
              value: serviceLocater.get<SessionBloc>(),
              child: SurahPagesScreen(surah: state.extra as SurahModel),
            ),
      ),
    ],
  );
}
