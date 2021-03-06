// Packages:
import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Screens:
import 'package:expensy_flutter/screens/edit_transaction_screen.dart';

// Models:
import 'package:expensy_flutter/models/_models.dart';

// Components:

// Helpers:

// Utilities:

class TransactionTile extends StatelessWidget {
  // Properties:
  final MonetaryTransaction transaction;
  final int id;
  final int index;

  // Constructor:
  TransactionTile({
    Key key,
    this.transaction,
    this.id,
    this.index,
  }) : super(key: key);

  // Runtime constants:
  final DateFormat formatter = DateFormat().add_yMMMMd();
  final currencyFormat = new NumberFormat("#,##0.00", "en_US");

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentCurrency = appData.currentCurrency;

    TransactionsData transactionsData = Provider.of<TransactionsData>(context, listen: true);
    Function onDeleteTransactionHandler = (id, context) => transactionsData.deleteTransactionWithConfirm(id, context);

    final String formattedDate = formatter.format(transaction.executionDate);
    final String amountLabel = '${currentCurrency['symbol']}${currencyFormat.format(transaction.amount)}';
    final double amountFontSize = (84 / amountLabel.length);

    return Card(
      // shadowColor: Colors.purpleAccent,
      elevation: 2,
      color: Colors.white70,
      // margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.white70, width: 1),
        // side: BorderSide(color: Colors.red, width: 1),
        // borderRadius: BorderRadius.circular(10),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          // visualDensity: VisualDensity.standard,
          leading: CircleAvatar(
            radius: 32,
            child: FittedBox(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Text(
                  amountLabel,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    fontSize: amountFontSize,
                  ),
                ),
              ),
            ),
          ),

          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transaction.title,
                // style: TextStyle(
                //   fontSize: 18,
                //   fontWeight: FontWeight.bold,
                // ),
                style: Theme.of(context).textTheme.headline6,
              ),
              Text(
                formattedDate,
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          // subtitle: Text('testing'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Tooltip(
                message: 'Delete',
                child: IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.black,
                  ),
                  onPressed: () => onDeleteTransactionHandler(transaction.id, context),
                ),
              ),
              Tooltip(
                message: 'Edit',
                child: IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => EditTransactionScreen(
                        id: id,
                        index: index,
                        title: transaction.title,
                        amount: transaction.amount,
                        executionDate: transaction.executionDate,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
