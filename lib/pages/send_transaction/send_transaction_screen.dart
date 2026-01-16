import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:web3dart/web3dart.dart';

import 'package:crypto_wallet/services/functions/functions.dart';
import 'package:crypto_wallet/services/providers/walletprovider.dart';
import 'package:crypto_wallet/utils/theme.dart';
import '../qr/scan_qr_screen.dart';

class SendTransactionScreen extends StatefulWidget {
  const SendTransactionScreen({super.key});

  @override
  State<SendTransactionScreen> createState() => _SendTransactionScreenState();
}

class _SendTransactionScreenState extends State<SendTransactionScreen> {
  final _addressController = TextEditingController();
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _addressController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _sendTransaction() async {
    if (_addressController.text.isEmpty || _amountController.text.isEmpty) {
      snackBar('Please fill all fields', context);
      return;
    }

    try {
      setState(() => _isLoading = true);

      final walletProvider = Provider.of<WalletProvider>(context, listen: false);
      
      // Validate recipient address
      if (!_addressController.text.startsWith('0x') || _addressController.text.length != 42) {
        snackBar('Invalid Ethereum address', context);
        setState(() => _isLoading = false);
        return;
      }

      final recipientAddress = EthereumAddress.fromHex(_addressController.text);
      
      // Parse amount - handle decimal numbers
      final amountValue = double.tryParse(_amountController.text);
      if (amountValue == null || amountValue <= 0) {
        snackBar('Invalid amount', context);
        setState(() => _isLoading = false);
        return;
      }

      // Convert to Wei (1 ETH = 10^18 Wei)
      final amountInWei = BigInt.from((amountValue * 1e18).toInt());
      final amount = EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        amountInWei,
      );

      final client = walletProvider.web3client;
      final credentials = walletProvider.privateKey;

      // Get the current gas price
      final gasPrice = await client.getGasPrice();
      
      // Estimate gas
      final gasEstimate = await client.estimateGas(
        sender: walletProvider.getPublicAddress,
        to: recipientAddress,
        data: null,
        value: amount,
      );

      // Create transaction
      final transaction = Transaction(
        to: recipientAddress,
        gasPrice: gasPrice,
        maxGas: gasEstimate.toInt(),
        value: amount,
      );

      // Send transaction
      final txHash = await client.sendTransaction(
        credentials,
        transaction,
        chainId: int.parse(walletProvider.getNetwork.chainId),
      );

      setState(() => _isLoading = false);

      if (mounted) {
        snackBar('Transaction sent! Hash: ${txHash.substring(0, 10)}...', context);
        Navigator.pop(context);
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        snackBar('Error: ${e.toString()}', context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: AppTheme.bodyBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.appBarColor,
        title: const Text(
          'Send Transaction',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Send ${walletProvider.getNetwork.currency}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _addressController,
                style: const TextStyle(color: Colors.white),
                enableInteractiveSelection: true,
                enableSuggestions: false,
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Recipient Address',
                  labelStyle: const TextStyle(color: Colors.white70),
                  hintText: '0x...',
                  hintStyle: const TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Paste button
                      IconButton(
                        icon: const Icon(Icons.paste, color: Colors.white),
                        tooltip: 'Paste',
                        onPressed: () async {
                          final clipboardData = await Clipboard.getData('text/plain');
                          if (clipboardData != null && clipboardData.text != null && mounted) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                _addressController.text = clipboardData.text!;
                              }
                            });
                          }
                        },
                      ),
                      // QR Scanner button
                      IconButton(
                        icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                        tooltip: 'Scan QR',
                        onPressed: () async {
                          final result = await Navigator.push(
                            context,
                            PageTransition(
                              child: const ScanQRScreen(),
                              type: PageTransitionType.rightToLeft,
                            ),
                          );
                          if (result != null && mounted) {
                            // Use addPostFrameCallback to avoid setState during build
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                _addressController.text = result.toString();
                              }
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _amountController,
                style: const TextStyle(color: Colors.white),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Amount (${walletProvider.getNetwork.currency})',
                  labelStyle: const TextStyle(color: Colors.white70),
                  hintText: '0.0',
                  hintStyle: const TextStyle(color: Colors.white38),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.blue),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _sendTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          'Send',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

