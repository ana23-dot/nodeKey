import 'dart:convert';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import 'package:crypto_wallet/pages/qr/myqr_screen.dart';
import 'package:crypto_wallet/pages/send_transaction/send_transaction_screen.dart';
import 'package:crypto_wallet/services/functions/market.dart';
import 'package:crypto_wallet/services/providers/walletprovider.dart';
import 'package:crypto_wallet/utils/theme.dart';

import '../qr/scan_qr_screen.dart';

class CryptoTab extends StatefulWidget {
  const CryptoTab({super.key});

  @override
  State<CryptoTab> createState() => _CryptoTabState();
}

class _CryptoTabState extends State<CryptoTab> {
  @override
  Widget build(BuildContext context) {
    var walletProvider = Provider.of<WalletProvider>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppTheme.bodyBackgroundColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: RadialGradient(
                    colors: [
                      Colors.indigo.shade100,
                      Colors.indigo.shade200,
                      Colors.pink.shade200,
                      Colors.purple.shade200,
                      Colors.blue.shade400,
                    ],
                    radius: 2,
                    center: Alignment.topLeft,
                  ),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 200,
                      margin: const EdgeInsets.only(bottom: 50, top: 40),
                      child: FutureBuilder<List<double>>(
                          future: getMarketChart(walletProvider),
                          builder: (context, snapshot) {
                            return snapshot.hasData
                                ? Sparkline(
                                    data: snapshot.data!,
                                    lineColor: Colors.indigo.withOpacity(0.5),
                                    lineWidth: 2,
                                    fillGradient: LinearGradient(
                                      colors: [
                                        Colors.indigo.shade200,
                                        Colors.indigo.shade300,
                                        Colors.pink.shade300,
                                        Colors.purple.shade300,
                                        Colors.blue.shade500,
                                      ],
                                    ),
                                    fillMode: FillMode.below,
                                  )
                                : Container();
                          }),
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(width: 5),
                                  Opacity(
                                    opacity: 0.9,
                                    child: Image.asset(
                                      'assets/icons/chip.png',
                                      width: 40,
                                    ),
                                  ),
                                  const Spacer(),
                                  Opacity(
                                    opacity: 0,
                                    child: Image.asset(
                                      'assets/images/logo.png',
                                      width: 40,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    '  NETWORK',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const Text(
                                    '  PUBLIC ADDRESS',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '  ${walletProvider.getNetwork.name}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '  ${walletProvider.getPublicAddress.hex.substring(0, 6)}...${walletProvider.getPublicAddress.hex.substring(walletProvider.getPublicAddress.hex.length - 4)}',
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              FutureBuilder<List<dynamic>>(
                                future: getCurrentPrice(walletProvider),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final balance = snapshot.data![0];
                                    final price = snapshot.data![1];
                                    final balanceBigInt = BigInt.parse(balance);
                                    final weiPerEth = BigInt.from(1000000000000000000);
                                    final balanceInEth = (balanceBigInt.toDouble() / weiPerEth.toDouble())
                                        .toStringAsFixed(4);
                                    final balanceDouble = double.tryParse(balanceInEth) ?? 0.0;
                                    final priceDouble = double.tryParse(price) ?? 0.0;
                                    final usdValue = (balanceDouble * priceDouble).toStringAsFixed(2);

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$$usdValue',
                                          style: GoogleFonts.poppins(
                                            fontSize: 32,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${walletProvider.getNetwork.currency} $balanceInEth',
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.white70,
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 50,
                                      width: 200,
                                      color: Colors.white,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton(
                    context,
                    icon: Icons.send,
                    label: 'Send',
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const SendTransactionScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.qr_code_scanner,
                    label: 'Scan',
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        PageTransition(
                          child: const ScanQRScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                      if (result != null) {
                        Navigator.push(
                          context,
                          PageTransition(
                            child: SendTransactionScreen(),
                            type: PageTransitionType.rightToLeft,
                          ),
                        );
                      }
                    },
                  ),
                  _buildActionButton(
                    context,
                    icon: Icons.qr_code,
                    label: 'Receive',
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const MyQRScreen(),
                          type: PageTransitionType.rightToLeft,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white10,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.white, size: 30),
            const SizedBox(height: 5),
            Text(
              label,
              style: const TextStyle(color: Colors.white, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

