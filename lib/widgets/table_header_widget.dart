import 'package:flutter/material.dart';
import 'package:market_app/providers/currency_provider.dart';
import 'package:provider/provider.dart';

class TableHeaderWidget extends StatefulWidget {
  const TableHeaderWidget({Key? key}) : super(key: key);

  @override
  _TableHeaderWidgetState createState() => _TableHeaderWidgetState();
}

class _TableHeaderWidgetState extends State<TableHeaderWidget> {
  late CurrencyProvider _currencyProvider;

  @override
  void initState() {
    _currencyProvider = Provider.of<CurrencyProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle _headerTextStyle =
        TextStyle(fontSize: 12, fontWeight: FontWeight.bold);
    return Center(
        child: SizedBox(
            height: 60,
            child: Row(
              children: [
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      _currencyProvider.sortBySymbol();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text("Symbol",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: (Provider.of<CurrencyProvider>(context,
                                                listen: true)
                                            .sortingColumn ==
                                        "symbol")
                                    ? Colors.amber
                                    : Colors.grey),
                            textAlign: TextAlign.left),
                        const Icon(Icons.arrow_drop_down, size: 14),
                      ],
                    ),
                  ),
                  fit: FlexFit.tight,
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      _currencyProvider.sortByLastPrice();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Last Price",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: (Provider.of<CurrencyProvider>(context,
                                                listen: true)
                                            .sortingColumn ==
                                        "lastPrice")
                                    ? Colors.amber
                                    : Colors.grey),
                            textAlign: TextAlign.right),
                        const Icon(Icons.arrow_drop_down, size: 14),
                      ],
                    ),
                  ),
                  fit: FlexFit.tight,
                ),
                Flexible(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      _currencyProvider.sortByVolume();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text("Volume",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: (Provider.of<CurrencyProvider>(context,
                                                listen: true
                                )
                                            .sortingColumn ==
                                        "volume")
                                    ? Colors.amber
                                    : Colors.grey),
                            textAlign: TextAlign.right),
                        const Icon(Icons.arrow_drop_down, size: 14),
                      ],
                    ),
                  ),
                  fit: FlexFit.tight,
                ),
              ],
            )));
  }
}
