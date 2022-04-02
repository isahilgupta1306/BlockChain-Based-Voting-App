import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:voting_app/screens/election_info.dart';
import 'package:voting_app/services/functions.dart';
import 'package:voting_app/utils/constants.dart';
import 'package:web3dart/web3dart.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Client? httpClient;
  Web3Client? ethClient;
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    httpClient = Client();
    ethClient = Web3Client(infura_url, httpClient!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Start Election'),
      ),
      body: Container(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 45,
              width: double.infinity,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    filled: true, hintText: "Enter Election Name"),
              ),
            ),
            Container(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (controller.text.length > 0) {
                    await startElection(controller.text, ethClient!);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ElectionInfo(
                            ethClient: ethClient!,
                            electionName: controller.text,
                          ),
                        ));
                  }
                },
                child: const Text('Start Elections'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
