class TransactionModel {
  final String blockNumber;
  final String blockHash;
  final String timeStamp;
  final String hash;
  final String nonce;
  final String transactionIndex;
  final String from;
  final String to;
  final String gas;
  final String gasPrice;
  final String input;
  final String methodId;
  final String functionName;
  final String contractAddress;
  final String cumulativeGasUsed;
  final String txreceiptStatus;
  final String gasUsed;
  final String confirmations;
  final String isError;
  final String value;

  TransactionModel({
    required this.blockNumber,
    required this.blockHash,
    required this.timeStamp,
    required this.hash,
    required this.nonce,
    required this.transactionIndex,
    required this.from,
    required this.to,
    required this.gas,
    required this.gasPrice,
    required this.input,
    required this.methodId,
    required this.functionName,
    required this.contractAddress,
    required this.cumulativeGasUsed,
    required this.txreceiptStatus,
    required this.gasUsed,
    required this.confirmations,
    required this.isError,
    required this.value,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      blockNumber: map['blockNumber']?.toString() ?? '',
      blockHash: map['blockHash']?.toString() ?? '',
      timeStamp: map['timeStamp']?.toString() ?? '',
      hash: map['hash']?.toString() ?? '',
      nonce: map['nonce']?.toString() ?? '',
      transactionIndex: map['transactionIndex']?.toString() ?? '',
      from: map['from']?.toString() ?? '',
      to: map['to']?.toString() ?? '',
      gas: map['gas']?.toString() ?? '',
      gasPrice: map['gasPrice']?.toString() ?? '',
      input: map['input']?.toString() ?? '',
      methodId: map['methodId']?.toString() ?? '',
      functionName: map['functionName']?.toString() ?? '',
      contractAddress: map['contractAddress']?.toString() ?? '',
      cumulativeGasUsed: map['cumulativeGasUsed']?.toString() ?? '',
      txreceiptStatus: map['txreceiptStatus']?.toString() ?? '',
      gasUsed: map['gasUsed']?.toString() ?? '',
      confirmations: map['confirmations']?.toString() ?? '',
      isError: map['isError']?.toString() ?? '',
      value: map['value']?.toString() ?? '',
    );
  }
}

