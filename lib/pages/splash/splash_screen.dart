import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:crypto_wallet/pages/auth/password_screen.dart';
import 'package:crypto_wallet/pages/splash/welcome_splash_screen.dart';
import 'package:crypto_wallet/services/providers/walletprovider.dart';
import 'package:crypto_wallet/utils/theme.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/splash';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? pref;
  bool isLogged = false;
  Timer? _timer;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    WalletProvider walletProvider =
        Provider.of<WalletProvider>(context, listen: false);
    await walletProvider.initialize();
    isLogged = walletProvider.pref?.getBool('isLogged') ?? false;
    _timer = Timer(
      const Duration(seconds: 3),
      () {
        Navigator.push(
          context,
          PageTransition(
            child: isLogged ? const PasswordScreen() : const WelcomeSplashScreen(),
            type: PageTransitionType.bottomToTop,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bodyBackgroundColor,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 20),
              child: Image.asset('assets/images/logo.png'),
            ),
            Text(
              "Crypto Wallet",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

