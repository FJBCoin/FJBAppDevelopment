import 'package:fjb_coin/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../app.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({Key? key}) : super(key: key);

  @override
  _MarketplaceScreenState createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  //late Map<String, dynamic> currencies = widget._currencies;
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  late Map<String, dynamic> currencies;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(40, 20, 20, 0),
              child: const Text(
                'Marketplace',
                style: TextStyle(
                    fontSize: 36,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(40, 75, 150, 0),
              child: const Text(
                'View the featured crypto of FJB Coin',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.indigo),
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.fromLTRB(20, 120, 0, 0),
              child: cryptoMarketplace(),
            ),
          ],
        ),
      );

  Widget cryptoMarketplace() {
    return FutureBuilder(
      future: getCurrencies().then((ret) {
        currencies = ret;
      }),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Align(
            alignment: Alignment.topCenter,
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              Flexible(
                child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    final Map currency = currencies['data'][index];
                    final MaterialColor color = _colors[index % _colors.length];

                    return getListItemUi(currency, color);
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }

  ListTile getListItemUi(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 30,
        child: Image(
            image: AssetImage(
                'assets/img/${currency["symbol"].toString().toLowerCase()}_logo.png'),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 3),
        /*Text(
          currency['symbol'],
          textAlign: TextAlign.center,
        ),*/
      ),
      title: Text(
        currency['name'] + ' (' + currency['symbol'] + ')',
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
      ),
      subtitle: getSubtitleText(
        currency['quote']['USD']['price'].toStringAsFixed(2),
        currency['quote']['USD']['percent_change_1h'].toStringAsFixed(3),
      ),
      isThreeLine: true,
      minVerticalPadding: 20,
    );
  }

  Widget getSubtitleText(String price, String percent) {
    TextSpan priceWidget = TextSpan(
      text: "\$$price\n",
      style: const TextStyle(color: Colors.black, fontSize: 20),
    );

    String percentText = "1 hour: $percent%";
    TextSpan percentWidget;

    if (double.parse(percent) > 0) {
      percentWidget = TextSpan(
        text: percentText,
        style: const TextStyle(color: Colors.green),
      );
    } else {
      percentWidget = TextSpan(
        text: percentText,
        style: const TextStyle(color: Colors.red),
      );
    }

    return RichText(text: TextSpan(children: [priceWidget, percentWidget]));
  }
}

Future<Map<String, dynamic>> getCurrencies() async {
  String cryptoURL =
      "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5&convert=USD&CMC_PRO_API_KEY=579b0f05-6703-42c5-beae-7d404a34c3f4";
  http.Response response = await http.get(Uri.parse(cryptoURL));
  return json.decode(response.body);
  //}
}
