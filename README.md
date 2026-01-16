# NodeKey - Crypto Wallet

A cryptocurrency wallet built with Flutter, supporting Ethereum and Polygon networks. Manage, send, and receive assets with a sleek, secure, and user-friendly interface.

## Features

- **Multi-Network Support**: Ethereum and Polygon Mainnets
- **Secure Wallet Creation**: Generate wallets using BIP39 mnemonic phrases
- **Transaction History**: View all your transactions on supported networks
- **Secure Storage**: Uses Flutter Secure Storage for sensitive data
- **Modern UI**: Beautiful dark theme with smooth animations

## Prerequisites

- Flutter SDK (>= 3.0.0)
- Android Studio / Xcode (for mobile development)




## Project Structure

```
lib/
├── main.dart                 # App entry point
├── pages/
│   ├── auth/                 # Authentication screens
│   ├── dashboard/            # Wallet dashboard
│   ├── splash/               # Splash screens
│   ├── transaction_history/  # Transaction screens
│   ├── qr/                   # QR Code scanning and showing
│   └── Settings/             # Settings screens
├── services/
│   ├── functions/            # Helper functions
│   ├── models/               # Data models
│   └── providers/            # State management
└── utils/                    # Utilities and constants
```

## Dependencies

- **web3dart**: Ethereum blockchain interaction
- **bip39/bip32**: Wallet generation and key derivation




