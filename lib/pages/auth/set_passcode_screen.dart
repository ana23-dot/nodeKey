import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'package:crypto_wallet/pages/home.dart';
import 'package:crypto_wallet/services/providers/walletprovider.dart';

import '../../utils/theme.dart';

class SetPasscodeScreen extends StatefulWidget {
  SetPasscodeScreen(this._recovery, {super.key, this.hide = false});
  final String _recovery;
  final bool hide;

  @override
  State<SetPasscodeScreen> createState() => _SetPasscodeScreenState();
}

class _SetPasscodeScreenState extends State<SetPasscodeScreen> {
  String n = '';
  void addN(String nn) {
    if (n.length < 6) {
      setState(() => n += nn);
    }
  }

  void clear() => setState(() => {n = ''});

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.hide
          ? null
          : AppBar(
              backgroundColor: AppTheme.appBarColor,
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (int i = 1; i <= 2; i++)
                    Container(
                      height: 4,
                      width: 20,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: i <= 2 ? Colors.white : Colors.white12,
                        borderRadius: const BorderRadius.horizontal(
                          right: Radius.circular(2),
                        ),
                      ),
                    )
                ],
              ),
              centerTitle: true,
            ),
      backgroundColor: AppTheme.bodyBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                'Create Passcode',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'This extra layer of security helps prevent someone with your phone from accessing your funds.',
                style: GoogleFonts.inter(
                  color: Colors.white70,
                  fontSize: 15,
                  height: 1.5,
                  letterSpacing: 0.1,
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          for (int i = 1; i <= 6; i++)
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: n.length >= i
                                      ? Colors.white
                                      : Colors.white24,
                                  width: 2,
                                ),
                                color: n.length >= i
                                    ? Colors.white
                                    : Colors.transparent,
                              ),
                              child: n.length >= i
                                  ? Container(
                                      margin: const EdgeInsets.all(3),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                      ),
                                    )
                                  : null,
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Row 1-3
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => addN('1'),
                                child: NumberButton(1),
                              ),
                              GestureDetector(
                                onTap: () => addN('2'),
                                child: NumberButton(2),
                              ),
                              GestureDetector(
                                onTap: () => addN('3'),
                                child: NumberButton(3),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Row 4-6
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => addN('4'),
                                child: NumberButton(4),
                              ),
                              GestureDetector(
                                onTap: () => addN('5'),
                                child: NumberButton(5),
                              ),
                              GestureDetector(
                                onTap: () => addN('6'),
                                child: NumberButton(6),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Row 7-9
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => addN('7'),
                                child: NumberButton(7),
                              ),
                              GestureDetector(
                                onTap: () => addN('8'),
                                child: NumberButton(8),
                              ),
                              GestureDetector(
                                onTap: () => addN('9'),
                                child: NumberButton(9),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Row 0 and Clear
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(
                                width: 80,
                                height: 80,
                              ),
                              GestureDetector(
                                onTap: () => addN('0'),
                                child: NumberButton(0),
                              ),
                              GestureDetector(
                                onTap: () => clear(),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Colors.redAccent.shade400,
                                        Colors.red.shade600,
                                      ],
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.redAccent.withOpacity(0.3),
                                        blurRadius: 12,
                                        offset: const Offset(0, 6),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.backspace_outlined,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (n.length == 6)
                GestureDetector(
                  onTap: () async {
                    if (n.length != 6) return;
                    setState(() {
                      isLoading = true;
                    });
                    await Provider.of<WalletProvider>(context, listen: false)
                        .storage
                        .write(key: 'loginPasscode', value: n);
                    await Provider.of<WalletProvider>(context, listen: false)
                        .getLoggedFirstTime(widget._recovery);
                    if (mounted) {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: HomeScreen(),
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                        ),
                      );
                    }
                    if (mounted) {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  child: Container(
                    height: 64,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.blue.shade400,
                          Colors.purple.shade600,
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Center(
                      child: isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : Text(
                              'Create Passcode',
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),
                )
              else
                Container(
                  height: 64,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white10,
                    border: Border.all(
                      color: Colors.white12,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Enter 6-digit passcode',
                      style: GoogleFonts.inter(
                        color: Colors.white38,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget NumberButton(int n) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.12),
            Colors.white.withOpacity(0.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$n',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.5,
          ),
        ),
      ),
    );
  }
}

