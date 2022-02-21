import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:fjb_coin/src/app.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

const String API_BOX = "posts";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:137771926909:ios:fae252d636cd9a6dc0b814',
      apiKey: 'AIzaSyC3pOlQMfMPcIZwO8xveMNNBXhu8QGzEc4',
      messagingSenderId: '137771926909',
      projectId: 'fjbcoin-2f13b',
    ),
  );
  await Hive.initFlutter();
  await Hive.openBox(API_BOX);
  runApp(const FJBApp());
}

class ApiCaching {
  Future<Map<String, dynamic>> getCurrencies() async {
    /*final posts = await Hive.box(API_BOX).get(
      "posts",
      defaultValue: [],
    );

    if (posts.isNotEmpty) {
      //_MarketplaceScreenState.currencies = posts;
      print('posts = ' + posts);
      return posts;
    } else {*/
    String cryptoURL =
        "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=5&convert=USD&CMC_PRO_API_KEY=579b0f05-6703-42c5-beae-7d404a34c3f4";
    http.Response response = await http.get(Uri.parse(cryptoURL));

    String ret = json.decode(response.body);

    Hive.box(API_BOX).put("posts", ret);

    return json.decode(response.body);
    //}
  }
}
