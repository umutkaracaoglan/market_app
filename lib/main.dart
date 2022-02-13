import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:market_app/widgets/search_widget.dart';
import 'package:market_app/widgets/table_header_widget.dart';
import 'package:provider/provider.dart';
import 'package:market_app/providers/currency_provider.dart';
import 'package:market_app/screens/currency_table_screen.dart';

void main() {
  runApp(const MarketApp());
}

class MarketApp extends StatelessWidget {
  const MarketApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme:
          ThemeData(primarySwatch: Colors.blue, backgroundColor: Colors.black),
      darkTheme: ThemeData(brightness: Brightness.dark),
      home: DashboardScreen(title: 'Market Dashboard'),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  final TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        textEditingController.text = "";
      }
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CurrencyProvider())],
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: TabBar(controller: tabController, tabs: const [
              Tab(text: "All"),
              Tab(text: "Spot"),
              Tab(text: "Futures")
            ]),
          ),
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
              //Provider.of<CurrencyProvider>(context, listen: false).currencyTable.length;
            },
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                //child: const CurrencyListListView(),
                child: Column(
                  children: [
                    SearchTextWidget(
                        textEditingController: textEditingController),
                    const TableHeaderWidget(),
                    Expanded(
                      child: TabBarView(
                          controller: tabController,
                          children: const [
                            SingleChildScrollView(
                                child: CurrencyTableScreen(listType: "ALL")),
                            SingleChildScrollView(
                                child: CurrencyTableScreen(listType: "SPOT")),
                            SingleChildScrollView(
                                child: CurrencyTableScreen(listType: "FUTURES"))
                          ]),
                    ),
                  ],
                )),
          )),
    );
  }
}
