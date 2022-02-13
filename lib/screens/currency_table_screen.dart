import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:market_app/models/currency.dart';
import 'package:market_app/providers/currency_provider.dart';
import 'package:provider/provider.dart';

class CurrencyTableScreen extends StatefulWidget {
  final String? listType;

  const CurrencyTableScreen({Key? key, this.listType}) : super(key: key);

  @override
  _CurrencyTableScreenState createState() => _CurrencyTableScreenState();
}

class _CurrencyTableScreenState extends State<CurrencyTableScreen> {
  late CurrencyProvider _currencyProvider;
  late List<Currency> _currencyList;
  late List<Widget> _table;
  late List<Widget> _tableBody;
  late Widget _tableHeader;
  bool didChange = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!didChange) {
      _currencyProvider = Provider.of<CurrencyProvider>(context, listen: true);
      _currencyProvider.getCurrencyTable(type: widget.listType);
    }
    didChange = true;
  }

  @override
  Widget build(BuildContext context) {
    var length = _currencyProvider.filteredCurrencyTable.length;
    if (length == 0) {
      return const Center(child: Text("No results found."));
    }

    _tableBody = List.generate(length, (index) {
      var pair = _currencyProvider.filteredCurrencyTable[index];

      return SizedBox(
        height: 70,
        child: Row(
          children: [
            Flexible(
              flex: 1,
              child: Text(pair.displayName,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 1,
              child: Text(
                  "\$${NumberFormat.currency(name: "").format(pair.lastPrice)}",
                  style: const TextStyle(color: Colors.grey),
                  textAlign: TextAlign.right),
              fit: FlexFit.tight,
            ),
            Flexible(
              flex: 1,
              child: Text("\$${NumberFormat.compact().format(pair.volume)}",
                  textAlign: TextAlign.right),
              fit: FlexFit.tight,
            ),
          ],
        ),
      );
    });

    return Consumer<CurrencyProvider>(builder: (context, state, widget) {
      return Column(children: _tableBody);
    });
  }
}
