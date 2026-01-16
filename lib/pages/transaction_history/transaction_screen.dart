import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:crypto_wallet/services/providers/transaction_provider.dart';
import 'package:crypto_wallet/utils/theme.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bodyBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        title: const Text(
          'Transactions',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, transactionProvider, child) {
          if (transactionProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (transactionProvider.transactionsList.isEmpty) {
            return const Center(
              child: Text(
                'No transactions found',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: transactionProvider.transactionsList.length,
            itemBuilder: (context, index) {
              final transaction = transactionProvider.transactionsList[index];
              return ListTile(
                leading: const Icon(Icons.swap_horiz, color: Colors.white),
                title: Text(
                  transaction.from,
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  transaction.value,
                  style: const TextStyle(color: Colors.white70),
                ),
                trailing: Text(
                  transaction.timeStamp,
                  style: const TextStyle(color: Colors.white70),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

