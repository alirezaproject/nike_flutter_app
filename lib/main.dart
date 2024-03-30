import 'package:flutter/material.dart';
import 'package:nike/config/theme.dart';
import 'package:nike/core/widgets/root.dart';
import 'package:nike/service_locator.dart';
import 'package:nike/features/feature_auth/domain/repository/auth_repository.dart';
import 'package:nike/services/theme_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  final IAuthRepository authRepository = sl<IAuthRepository>();
  authRepository.getAuthToken();
  runApp(ChangeNotifierProvider(
    create: (context) {
      return ThemeService();
    },
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(
      builder: (BuildContext context, ThemeService value, Widget? child) {
        return Consumer<ThemeService>(builder: (BuildContext context, ThemeService themeService, Widget? child) {
          return MaterialApp(
            title: 'Nike Online Shop',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            themeMode: ThemeMode.light,
            home: RootScreen(),
          );
        });
      },
    );
  }
}
