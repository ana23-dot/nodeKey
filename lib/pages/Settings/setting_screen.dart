import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_wallet/services/providers/walletprovider.dart';
import 'package:crypto_wallet/utils/constants.dart';
import 'package:crypto_wallet/utils/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bodyBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        automaticallyImplyLeading: false,
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<WalletProvider>(
        builder: (context, walletProvider, child) {
          return ListView(
            children: [
              ListTile(
                leading: const Icon(Icons.account_balance_wallet, color: Colors.white),
                title: const Text(
                  'Network',
                  style: TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  walletProvider.getNetwork.name,
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white70),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      backgroundColor: Colors.grey[900],
                      title: const Text(
                        'Select Network',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: network.map((net) {
                          return ListTile(
                            title: Text(
                              net.name,
                              style: const TextStyle(color: Colors.white),
                            ),
                            onTap: () {
                              walletProvider.changeNetwork(net.id - 1);
                              Navigator.pop(context);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.white),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () async {
                  await walletProvider.signOut();
                  // Navigate to login
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

