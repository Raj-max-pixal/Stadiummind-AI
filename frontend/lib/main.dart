import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'core/config/firebase_config.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await FirebaseConfig.initialize();
  
  runApp(
    const ProviderScope(
      child: StadiumMindAI(),
    ),
  );
}

class StadiumMindAI extends StatelessWidget {
  const StadiumMindAI({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StadiumMind AI',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: appRouter,
    );
  }
}
