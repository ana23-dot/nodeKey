import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:crypto_wallet/services/providers/walletprovider.dart';
import 'package:crypto_wallet/utils/credential.dart';

import '../models/transaction_model.dart';

class TransactionProvider with ChangeNotifier {
  // variable
  bool _isLoading = false;
  List<TransactionModel> _transactionsList = [];

  // getter
  bool get isLoading => _isLoading;
  List<TransactionModel> get transactionsList => _transactionsList;

  //methods
  Future<void> fetch(WalletProvider walletProvider) async {
    _isLoading = true;
    notifyListeners();
    String chainId = walletProvider.getNetwork.chainId;
    Uri endpoint = Uri.https(
      walletProvider.getNetwork.etherscanUrl,
      '/api',
      {
        'module': 'account',
        'action': 'txlist',
        'address': walletProvider.getPublicAddress.hex,
        'startblock': '0',
        'endblock': '99999999',
        'page': '1',
        'offset': '0',
        'sort': 'desc',
        'apiKey': chainId == '1' || chainId == '5'
            ? etherscanApi
            : polygonscanApi,
      },
    );
    var response = await http.get(endpoint);
    if (response.statusCode == 200) {
      _transactionsList = [];
      var jsonData = jsonDecode(response.body);
      if (jsonData['result'] is List) {
        for (var item in jsonData['result']) {
          _transactionsList.add(TransactionModel.fromMap(item));
        }
      }
    } else {
      if (kDebugMode) {
        // print(response.reasonPhrase);
      }
    }
    _isLoading = false;
    notifyListeners();
  }
}

