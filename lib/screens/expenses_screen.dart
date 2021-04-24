// Packages:
import 'package:flutter/material.dart';

// Screens:

// Models:
import 'package:expensy_flutter/models/transaction.dart';

// Components:

// Helpers:

// Utilities:

class ExpensesScreen extends StatefulWidget {
  // Properties
  final String title;

  // Constructor:
  ExpensesScreen({Key key, this.title}) : super(key: key);

  @override
  _ExpensesScreenState createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  // Properties:

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            width: double.infinity,
            child: Card(
              color: Colors.blue,
              elevation: 5,
              child: Text(
                'CHART',
                style: TextStyle(
                  color: Colors.red,
                  backgroundColor: Colors.green,
                ),
              ),
            ),
          ),
          Card(
            color: Colors.red,
            child: Text('LIST OF EXPENSES'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
