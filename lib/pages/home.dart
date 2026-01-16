import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_wallet/pages/Settings/setting_screen.dart';
import 'package:crypto_wallet/services/providers/transaction_provider.dart';
import 'package:crypto_wallet/services/providers/walletprovider.dart';
import 'package:crypto_wallet/utils/theme.dart';
import 'dashboard/wallet_screen.dart';
import 'transaction_history/transaction_screen.dart';

class HomeScreen extends StatefulWidget {
  static const route = '/home';
  HomeScreen({this.index = 0, super.key});
  final int index;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;

  @override
  void initState() {
    super.initState();
    page = widget.index;
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bodyBackgroundColor,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white10,
        destinations: const [
          NavigationDestination(
            icon: Icon(
              Icons.wallet,
              size: 25,
            ),
            selectedIcon: Icon(
              Icons.wallet,
              size: 25,
              color: Colors.white,
            ),
            label: 'Wallet',
          ),
          NavigationDestination(
              icon: Icon(
                Icons.list_alt,
                size: 25,
              ),
              selectedIcon: Icon(
                Icons.list_alt,
                size: 25,
                color: Colors.white,
              ),
              label: 'Transaction'),
          NavigationDestination(
              icon: Icon(
                Icons.settings,
                size: 25,
              ),
              selectedIcon: Icon(
                Icons.settings,
                size: 25,
                color: Colors.white,
              ),
              label: 'Settings'),
        ],
        onDestinationSelected: (value) {
          if (page != value)
            setState(() {
              page = value;
            });
        },
        selectedIndex: page,
      ),
      body: [
        const WalletScreen(),
        const TransactionScreen(),
        const SettingsScreen(),
      ][page],
    );
  }
}

