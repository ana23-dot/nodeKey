import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:crypto_wallet/pages/auth/login_screen.dart';
import 'package:crypto_wallet/pages/home.dart';
import 'package:crypto_wallet/pages/splash/splash_screen.dart';
import 'package:crypto_wallet/pages/splash/welcome_splash_screen.dart';
import 'package:crypto_wallet/services/providers/transaction_provider.dart';
import 'package:crypto_wallet/services/providers/walletprovider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('crypto');
  var pref = await SharedPreferences.getInstance();
  var isLogged = pref.getBool('isLogged') ?? false;
  runApp(MyApp(isLogged: isLogged));
}

class MyApp extends StatelessWidget {
  final bool isLogged;
  const MyApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<WalletProvider>(
          create: (context) => WalletProvider(),
        ),
        ChangeNotifierProvider<TransactionProvider>(
          create: (context) => TransactionProvider(),
        ),
     
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Crypto Wallet',
        theme: ThemeData.dark(useMaterial3: true),
        initialRoute: isLogged ? SplashScreen.route : WelcomeSplashScreen.route,
        routes: {
          SplashScreen.route: (context) => const SplashScreen(),
          WelcomeSplashScreen.route: (context) => const WelcomeSplashScreen(),
          HomeScreen.route: (context) => HomeScreen(),
          LoginScreen.route: (context) => const LoginScreen(),
        },
      ),
    );
  }
}
