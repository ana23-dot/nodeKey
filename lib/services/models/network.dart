class Network {
  final int id;
  final String name;
  final String chainId;
  final bool mainnet;
  final String currency;
  final String logo;
  final String rpc;
  final String blockExplorer;
  final String etherscanUrl;

  Network({
    required this.id,
    required this.name,
    required this.chainId,
    required this.mainnet,
    required this.currency,
    required this.logo,
    required this.rpc,
    required this.blockExplorer,
    required this.etherscanUrl,
  });
}

