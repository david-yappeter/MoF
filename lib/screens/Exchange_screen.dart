import 'package:flutter/material.dart';
import 'package:mof/http/Http.Helper.dart';
import 'package:mof/screens/detailCurrency.dart';

import '../http/currency.dart';

class ExchangeRateScreen extends StatefulWidget {
  static const routeName = '/set-pin';
  // const ExchangeRateScreen({super.key});
  const ExchangeRateScreen({Key? key}) : super(key: key);

  @override
  State<ExchangeRateScreen> createState() => _ExchangeRateScreen();
}

class _ExchangeRateScreen extends State<ExchangeRateScreen> {
  HttpHelper? helper;
  Currency? currency;

  Future initialize() async {
    currency = await helper?.getCurrency();
    setState(() {
      currency = currency;
    });
  }

  @override
  void initState() {
    helper = HttpHelper();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> myList = [];
    if (currency != null) {
      for (int i = 0; i < currency!.rates.keys.toList().length; i++) {
        var data = {
          'keys': currency!.rates.keys.toList()[i],
          'values': currency!.rates.values.toList()[i]
        };

        myList.add(data);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Exchange Rates"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text(
                    "Based Code ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  currency != null
                      ? Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: Colors.red),
                          height: 25,
                          width: 75,
                          child: Text(
                            currency!.baseCode,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                        )
                      : Container()
                ],
              )),
          const SizedBox(height: 10),
          Expanded(
              child: ListView.builder(
                  itemCount: (currency?.rates.keys.toList().length == null)
                      ? 0
                      : currency?.rates.keys.toList().length,
                  itemBuilder: (BuildContext context, int position) {
                    return Card(
                      elevation: 2.0,
                      child: ListTile(
                        onTap: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (_) => DetailCurrency(
                              keys: myList[position]['keys'],
                              value: myList[position]['values'],
                            ),
                          );
                          Navigator.push(context, route);
                        },
                        title: Text(myList[position]['keys'].toString()),
                        subtitle: Text('${myList[position]['values']} USD'),
                        trailing: const Icon(Icons.arrow_right_sharp),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
