import 'dart:async';
import 'package:flutter/material.dart';

class DetailCurrency extends StatefulWidget {
  final double value;
  final String keys;
  // const DetailCurrency(this.value, this.keys, {super.key});
  const DetailCurrency({Key? key, required this.value, required this.keys})
      : super(key: key);

  @override
  State<DetailCurrency> createState() => _DetailCurrencyState();
}

class _DetailCurrencyState extends State<DetailCurrency> {
  TextEditingController _textEditingController = TextEditingController();
  StreamController<String> _streamController = StreamController();
  var _textString = '0';
  @override
  void initState() {
    super.initState();
    _streamController.stream.listen((event) {
      setState(() {
        _textString = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Convert"),
      ),
      body: Center(
          child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Convert USD to ${widget.keys}",
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  TextField(
                    controller: _textEditingController,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Input Value',
                      suffixText: 'USD',
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (_textEditingController.text == "") {
                              _streamController.add(0.toString());
                            } else {
                              _streamController.add(
                                  (double.parse(_textEditingController.text) *
                                          widget.value.toDouble())
                                      .toString());
                            }
                          },
                          child: const Text("Convert")),
                      const SizedBox(width: 50),
                      ElevatedButton(
                          onPressed: _textEditingController.clear,
                          child: const Text("Clear")),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text("Result",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  const Divider(),
                  Text("${_textString} ${widget.keys}",
                      style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent)),
                ],
              ))),
    );
  }
}
