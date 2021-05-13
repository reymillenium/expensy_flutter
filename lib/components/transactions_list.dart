// Packages:
import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:expensy_flutter/models/_models.dart';

// Components:
import 'package:expensy_flutter/components/_components.dart';

// Helpers:

// Utilities:

class TransactionsList extends StatelessWidget {
  // Properties:
  final _listViewScrollController = ScrollController();

  // Constructor:

  @override
  Widget build(BuildContext context) {
    TransactionsData transactionsData = Provider.of<TransactionsData>(context, listen: true);
    List<MonetaryTransaction> transactions = transactionsData.transactions;

    return Container(
      child: transactions.isEmpty
          ? EmptyWidget(
              packageImage: 1,
              title: 'We are sorry',
              subTitle: 'There is no transactions',
            )
          : ListView.builder(
              padding: const EdgeInsets.only(left: 0, top: 0, right: 0),
              controller: _listViewScrollController,
              itemBuilder: (context, index) {
                return TransactionTile(
                  id: transactions[index].id,
                  index: index,
                  transaction: transactions[index],
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
