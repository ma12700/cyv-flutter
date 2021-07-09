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
    String contractAddress = "0x0305Fb935b21D10d2DB80d5c9a46E526565A4049";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "Election"),
        EthereumAddress.fromHex(contractAddress));
    return contract;
  }

  static Future<bool> getResult() async {
    final contract = await loadContract();
    final ethFunction = contract.function('returnResult');

    CandidatesModel.tracks.forEach((key, _) async {
      final response = await ethClient.call(
        contract: contract,
        function: ethFunction,
        params: [key],
      );
      print(response);
      int len = (response[0] as List<dynamic>).length;
      for (int i = 0; i < len; i++) {
        CandidatesModel.tracks[key].candidates[response[0][i]].votesNumber =
            response[2][i];
      }
    });
    return true;
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
