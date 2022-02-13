import 'package:flutter/material.dart';
import 'package:market_app/providers/currency_provider.dart';
import 'package:provider/provider.dart';

class SearchTextWidget extends StatefulWidget {
  const SearchTextWidget({Key? key, required this.textEditingController}) : super(key: key);
  final TextEditingController textEditingController;

  @override
  State<SearchTextWidget> createState() => _SearchTextWidgetState();
}

class _SearchTextWidgetState extends State<SearchTextWidget> {

  late CurrencyProvider _currencyProvider;
  bool didChange = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(!didChange){
      _currencyProvider = Provider.of<CurrencyProvider>(context, listen: true);
    }
    didChange = true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children:  [
        SizedBox(
          height: 40,
          child: TextField(
            controller: widget.textEditingController,
              onChanged: (value) {
                _currencyProvider.search(value);
              },
              style: const TextStyle(fontSize: 12, color: Colors.grey),
              textCapitalization: TextCapitalization.characters,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                border: OutlineInputBorder(),
                //border: InputBorder.none,
                labelText: 'Search Coin Pairs',
                floatingLabelBehavior: FloatingLabelBehavior.never,
                helperStyle: TextStyle(color: Colors.transparent),
              )
          ),
        ),
      ],
    );
  }
}
