import 'package:flutter/material.dart';
import 'package:nu_alura_challenge1/models/feeling.dart';

class GridItemDetailPage extends StatelessWidget {
  const GridItemDetailPage({Key key, @required this.feeling}) : super(key: key);

  final Feeling feeling;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(feeling.title),),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Stack(
      children: [
        _background(),
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
              _description(),
              _button(context),
            ],
          ),
        )
      ],
    );
  }

  _background() {
    return Column(
      children: [
        Expanded(
          child: Hero(
            tag: feeling.image,
            child: Image.asset(
              "assets/images/${feeling.image}",
              fit: BoxFit.fitHeight,
            ),
          ),
        ),
      ],
    );
  }

  _description() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Text(
        feeling.description,
        style: TextStyle(color: Colors.white, fontSize: 24),
      ),
    );
  }

  _button(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          "Tentar de novo",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
