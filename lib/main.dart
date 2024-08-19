import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/auth/login_screen.dart';
import 'package:todo/auth/register_screen.dart';
import 'package:todo/home_screen.dart';
import 'package:todo/tabs/tasks/task_update.dart';
import 'package:todo/tabs/tasks/tasks_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyAwIjoinouNqr5iVYj_YVG4cJP-iIKAHLY',
    appId: 'id',
    messagingSenderId: '16135219339',
    projectId: 'todo-app-6efb3',
    storageBucket: 'todo-app-6efb3.appspot.com',
  ));

  runApp(
    ChangeNotifierProvider(
      create: (_) => TasksProvider()..getTasks(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    TasksProvider provider = Provider.of(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        TaskUpdate.routeName: (_) => TaskUpdate(),
        RegisterScreen.routeName: (_) => const RegisterScreen(),
        LoginScreen.routeName: (_) => LoginScreen(),
      },
      initialRoute: RegisterScreen.routeName,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.language),
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.themeMode,
    );
  }
}
