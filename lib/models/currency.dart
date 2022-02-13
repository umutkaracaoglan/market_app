class Currency {
  String? base;
  String? quote;
  String? type;
  double lastPrice;
  double volume;
  late int priority;

  String get displayName {
    var val = (type == "FUTURES"
        ? "${base.toString()}-PREP"
        : "${base.toString()} / ${quote.toString()}");

    return val;
  }

  Currency(
      {this.base,
      this.quote,
      this.type,
      required this.lastPrice,
      required this.volume});

  factory Currency.fromJson(Map<String, dynamic> json) {
    var currency = Currency(
        base: json['base'],
        quote: json['quote'],
        type: json['type'],
        lastPrice: json['lastPrice'].toDouble(),
        volume: json['volume'].toDouble());

    /// Sorting priorities
    int p = 0;

    if (currency.base == "BTC") {
      p += 100;
    } else if (currency.base == "ETH") {
      p += 50;
    } else if (currency.base == "WOO") {
      p += 10;
    }

    if (p > 0) {
      if (currency.quote == "USDT" && currency.type == "SPOT") {
        p += 3;
      }
      if (currency.quote == "USDC" && currency.type == "SPOT") {
        p += 2;
      }
      if (currency.type == "FUTURES") {
        p += 1;
      }
    }
    currency.priority = p;
    return currency;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base'] = base;
    data['quote'] = quote;
    data['type'] = type;
    data['lastPrice'] = lastPrice;
    data['volume'] = volume;
    return data;
  }
}
