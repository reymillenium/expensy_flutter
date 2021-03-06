// Packages:
import 'package:expensy_flutter/_inner_packages.dart';
import 'package:expensy_flutter/_external_packages.dart';

// Screens:

// Models:
import 'package:expensy_flutter/models/_models.dart';

// Components:

// Helpers:

// Utilities:
import 'package:expensy_flutter/utilities/constants.dart';

class ExpensyAppBar extends StatelessWidget with PreferredSizeWidget {
  // Properties:
  final String title;
  final Function showModalNewTransaction;

  const ExpensyAppBar({
    Key key,
    this.title,
    this.showModalNewTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppData appData = Provider.of<AppData>(context, listen: true);
    Map currentThemeFont = appData.currentThemeFont;

    return AppBar(
      title: Text(
        title,
        // style: TextStyle(
        //   fontSize: 24,
        //   fontWeight: FontWeight.bold,
        //   fontFamily: currentThemeFont['fontFamily'],
        // ),
        style: Theme.of(context).appBarTheme.textTheme.headline6.copyWith(
              fontFamily: currentThemeFont['fontFamily'],
            ),
      ),
      actions: [
        IconButton(
          iconSize: 40,
          icon: Icon(Icons.add_rounded),
          tooltip: 'Add Transaction',
          // onPressed: () => showModalNewTransaction(context),
          onPressed: showModalNewTransaction,
        ),
      ],
      // bottom: PreferredSize(
      //   preferredSize: Size.fromHeight(100.0),
      // ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolBarHeight);
}
