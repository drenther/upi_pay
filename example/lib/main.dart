import 'dart:math';

import 'package:flutter/material.dart';
import 'package:upi_pay/upi_pay.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _upiAddressController = TextEditingController();
  final _amountController = TextEditingController();

  bool _isUpiEditable = false;
  Future<List<ApplicationWithIcon>> _appsFuture;

  @override
  void initState() {
    super.initState();

    _amountController.text =
        (Random.secure().nextDouble() * 10).toStringAsFixed(2);
    _appsFuture = UpiApplications.getAllInstalledUpiApplications();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _upiAddressController.dispose();
    super.dispose();
  }

  void _generateAmount() {
    setState(() {
      _amountController.text =
          (Random.secure().nextDouble() * 10).toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('UPI Pay'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: ListView(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 32),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _upiAddressController,
                        enabled: _isUpiEditable,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'address@upi',
                          labelText: 'Receiving UPI Address',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: IconButton(
                        icon: Icon(
                          _isUpiEditable ? Icons.check : Icons.edit,
                        ),
                        onPressed: () {
                          setState(() {
                            _isUpiEditable = !_isUpiEditable;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _amountController,
                        readOnly: true,
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Amount',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 8),
                      child: IconButton(
                        icon: Icon(Icons.loop),
                        onPressed: _generateAmount,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 256),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Pay Using',
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ),
                    FutureBuilder<List<ApplicationWithIcon>>(
                      future: _appsFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState != ConnectionState.done) {
                          return Container();
                        }

                        return GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.6,
                          children: snapshot.data
                              .map((it) => Material(
                                    color: Colors.grey[200],
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Image.memory(
                                            it.icon,
                                            width: 64,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 4),
                                            child: Text(it.appName),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
