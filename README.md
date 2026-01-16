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
- RPC URLs from Alchemy or QuickNode
- API Keys from Etherscan and Polygonscan

## Installation

1. Clone the repository

   ```sh
   git clone https://github.com/ana23-dot/nodeKey.git
   cd nodeKey
   ```

2. Install dependencies

   ```sh
   flutter pub get
   ```

3. Configure API keys and RPC URLs

   Edit `lib/utils/credential.dart` and add your credentials:

   ```dart
   String get polygonscanApi => 'YOUR_POLYGONSCAN_API_KEY';
   String get etherscanApi => 'YOUR_ETHERSCAN_API_KEY';
   String get mainnetRPC => 'YOUR_ETHEREUM_MAINNET_RPC_URL';
   String get polygonRPC => 'YOUR_POLYGON_MAINNET_RPC_URL';
   ```

4. Add assets

   Place your assets in the following directories:

   - `assets/images/` - Logo and network images
   - `assets/lottie/` - Lottie animation files
   - `assets/icons/` - App icons

5. Run the application
   ```sh
   flutter run
   ```

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
- **provider**: State management
- **flutter_secure_storage**: Secure storage for sensitive data
- **shared_preferences**: Local settings storage
- **lottie**: Animations
- **google_fonts**: Typography

## Getting RPC URLs

### Alchemy

1. Sign up at [alchemy.com](https://www.alchemy.com)
2. Create a new app
3. Copy the HTTP URL

### QuickNode

1. Sign up at [quicknode.com](https://www.quicknode.com)
2. Create an endpoint
3. Copy the HTTP URL

## Getting API Keys

### Etherscan

1. Sign up at [etherscan.io](https://etherscan.io)
2. Go to API-KEYs section
3. Create a new API key

### Polygonscan

1. Sign up at [polygonscan.com](https://polygonscan.com)
2. Go to API-KEYs section
3. Create a new API key

## Security Notes

- Never commit your API keys or RPC URLs to version control
- Keep your recovery phrase secure and never share it
- This is a development project
- Always verify transactions before signing

## Roadmap

- [ ] Portfolio generator
- [ ] Live Market Feed
- [ ] Add network feature for other EVM-based chains
- [ ] Ability to interact with NFTs
- [ ] Creation of more accounts from same recovery phrase
- [ ] Multi-signature wallet support

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is provided as-is for educational purposes.

## Credits

Powered by:

- CoinGecko
- Etherscan
- QuickNode
- Alchemy
- FlatIcon
- LottieFiles
