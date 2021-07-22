import 'package:cyv/models/candidates.dart';
import 'package:cyv/models/user.dart';
import 'package:flutter/services.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

class ContractCtr {
  static Client httpClient = Client();
  static Web3Client ethClient = Web3Client(
      "https://rinkeby.infura.io/v3/e97213d99e8b4d3397ddc351492c436b",
      httpClient);
  static final myAdress = User.etherumAddress;

  static Future<DeployedContract> loadContract() async {
    String abi = await rootBundle.loadString("assets/ABI.json");
    String contractAddress = "0x205532EceF642CF8d9EDD11766103a2fc7B25104";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "Election"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  static Future<void> getResult(String trackID, String dividedByValue) async {
    final contract = await loadContract();
    final ethFunction = contract.function('returnMobileResult');
    final response = await ethClient.call(
      contract: contract,
      function: ethFunction,
      params: [trackID, dividedByValue],
    );
    CandidatesModel.storeResult(response, trackID);
    /* int len = (response[0] as List<dynamic>).length;
      for (int i = 0; i < len; i++) {
        CandidatesModel.tracks[trackID].candidates[response[0][i]].votesNumber =
            response[2][i];
      } */
  }

  static Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey credentials = EthPrivateKey.fromHex(
        "df36cb6f8dde80c977896c2eaf0d51accd88adf1909c8db56add1eb9b32a7f27");
    DeployedContract contract = await loadContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
        credentials,
        Transaction.callContract(
            contract: contract,
            function: ethFunction,
            parameters: args,
            maxGas: 4000000),
        fetchChainIdFromNetworkId: true);
    return result;
  }
}
