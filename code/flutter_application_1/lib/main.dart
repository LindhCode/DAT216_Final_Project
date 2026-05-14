import 'package:flutter/material.dart';
import 'package:imat_app/core/theme/app_theme.dart';
import 'package:imat_app/features/history/history_page.dart';
import 'package:imat_app/features/home/main_view.dart';
import 'package:imat_app/model/imat_data_handler.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ImatDataHandler(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMat',
      debugShowCheckedModeBanner:
          false, // Valfritt: tar bort debug-flaggan i hörnet
      // Vi använder ditt färdiga tema från AppTheme
      theme: AppTheme.lightTheme,

      // Vi tar bort 'home' och använder 'initialRoute' + 'routes' istället
      initialRoute: '/',
      routes: {
        '/': (context) => const MainView(),
        '/history': (context) => const HistoryPage(),
      },
    );
  }
}
