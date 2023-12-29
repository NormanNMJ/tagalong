import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'manager/user_manager.dart';
import 'provider/userProvider.dart';
import 'screens/home/root_screen.dart';
import 'screens/intro/welcome_screen.dart';
import 'theme/themenotifier.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);
  await UserManager().fetchUserData();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider<UserProfileProvider>(create: (_) => UserProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeNotifier>(context).getTheme(),
      home: StreamBuilder(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasData && snapshot.data != ConnectivityResult.none) {
            // Internet connection exists, check user authentication
            return const AuthChecker();
          } else {
            // No internet connection, show a snackbar
            return const Scaffold(
              body: Center(
                child: Text('No internet connection'),
              ),
            );
          }
        },
      ),
    );
  }
}

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasData) {
          // User is authenticated
          // Check if the user has data (for example, by checking a specific field in the user document)
          // Replace this logic with your actual data-checking logic
          bool hasUserData = snapshot.data!.email != null;

          if (hasUserData) {
            // User has data, navigate to the root screen
            return const RootScreen();
          } else {
            // User is authenticated but doesn't have data, navigate to the welcome screen
            return const WelcomeScreen();
          }
        } else {
          // User is not authenticated, navigate to the login/register screen
          return const WelcomeScreen();
        }
      },
    );
  }
}
