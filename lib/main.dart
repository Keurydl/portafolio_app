import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:portafolio_app/core/theme.dart';
import 'package:portafolio_app/data/repositories/project_repository.dart';
import 'package:portafolio_app/ui/viewmodels/home_viewmodel.dart';
import 'package:portafolio_app/ui/screens/home_screen.dart';
import 'package:portafolio_app/ui/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ProjectRepository>(
          create: (_) => ProjectRepository(),
        ),
        ChangeNotifierProvider<HomeViewModel>(
          create: (context) => HomeViewModel(
            context.read<ProjectRepository>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Portfolio App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system, // Respect system theme
        home: const SplashScreen(),
      ),
    );
  }
}
