import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nu_alura_challenge1/models/start.dart';
import 'package:nu_alura_challenge1/pages/grid_page.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Start _start;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Start>(
        future: _initConfig(),
        builder: (ctx, AsyncSnapshot<Start> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator(),);
          _start = snapshot.data;
          return _body();
        },),
    );
  }

  Future<Start> _initConfig() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/start.json");
    final jsonResult = json.decode(data);
    return Start.fromJson(jsonResult);
  }

  _body() {
    return Stack(
      children: [
        _background(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(width: 200,
                padding: EdgeInsets.only(top: 50),
                child: Image.asset(_start.logoPath)),
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.5, 1.0],
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              tileMode: TileMode.repeated,
              colors: <Color>[
                Colors.transparent,
                Colors.black,
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _title(),
              _subtitle(),
              _button(),
            ],
          ),
        )
      ],
    );
  }

  _background() {
    return Container(
      width: double.maxFinite,
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
            _start.backgroundPath,
            fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  _title() {
    return Text(
      _start.title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _subtitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        _start.subtitle,
        style: TextStyle(color: Colors.white70),
      ),
    );
  }

  _button() {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () =>
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => GridPage())),
        child: Text(
          _start.textButton.toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
