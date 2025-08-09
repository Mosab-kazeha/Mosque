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
      GoRoute(
        path: AppRoutes.kRoomScreen,
        builder: (context, state) => const RoomScreen(),
      ),
    ],
  );
}
