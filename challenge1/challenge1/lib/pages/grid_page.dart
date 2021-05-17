import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nu_alura_challenge1/components/grid_item_component.dart';
import 'package:nu_alura_challenge1/models/feeling.dart';

class GridPage extends StatelessWidget {
  const GridPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: FutureBuilder<List<Feeling>>(
        future: _getFeelings(context),
        builder: (ctx, AsyncSnapshot<List<Feeling>> snap) {
          if (!snap.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return _body(snap.data);
        },
      ),
    );
  }

  Future<List<Feeling>> _getFeelings(BuildContext context) async {
    List<Feeling> list = [];

    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/feelings.json");
    List<dynamic> jsonResult = json.decode(data);

    for (Map<String, dynamic> json in jsonResult) {
      list.add(Feeling.fromJson(json));
    }

    return list;
  }

  _appBar() {
    return AppBar(
      title: Text("Como se sente?"),
      centerTitle: true,
    );
  }

  _body(List<Feeling> feelings) {
    return Column(
      children: [
        SizedBox(height: 16),
        Text(
          "De 1 a ${feelings.length}, como está o seu vigor hoje?",
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: feelings.length,
                itemBuilder: (BuildContext context, int index) {
                  Feeling feeling = feelings[index];
                  feeling.index = index;
                  return GridItemComponent(
                    feeling: feeling,
                  );
                }),
          ),
        )
      ],
    );
  }
}
