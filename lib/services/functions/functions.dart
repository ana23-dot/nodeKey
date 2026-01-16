import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import 'package:crypto_wallet/services/providers/walletprovider.dart';
import 'package:crypto_wallet/utils/theme.dart';

void snackBar(String message, BuildContext context, {double vertical = 200}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      margin: EdgeInsets.symmetric(horizontal: 100, vertical: vertical),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppTheme.textColor),
      ),
      backgroundColor: Colors.white60,
    ),
  );
}
