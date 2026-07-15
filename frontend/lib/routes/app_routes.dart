import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/shared/splash_screen.dart';
import '../screens/fan/fan_dashboard.dart';
import '../screens/volunteer/volunteer_dashboard.dart';
import '../screens/admin/admin_dashboard.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String fanDashboard = '/fan';
  static const String volunteerDashboard = '/volunteer';
  static const String adminDashboard = '/admin';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.fanDashboard,
      builder: (context, state) => const FanDashboard(),
    ),
    GoRoute(
      path: AppRoutes.volunteerDashboard,
      builder: (context, state) => const VolunteerDashboard(),
    ),
    GoRoute(
      path: AppRoutes.adminDashboard,
      builder: (context, state) => const AdminDashboard(),
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri}'),
    ),
  ),
);
