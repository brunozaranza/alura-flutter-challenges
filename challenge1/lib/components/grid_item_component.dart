import 'package:flutter/material.dart';
import 'package:nu_alura_challenge1/models/feeling.dart';
import 'package:nu_alura_challenge1/pages/grid_item_detail_page.dart';

class GridItemComponent extends StatelessWidget {
  const GridItemComponent({Key key, @required this.feeling}) : super(key: key);

  final Feeling feeling;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => GridItemDetailPage(
                      feeling: feeling,
                    ))),
        child: Card(
          color: Colors.amber,
          child: Stack(
            children: [
              SizedBox(
                width: double.maxFinite,
                height: double.maxFinite,
                child: Hero(
                  tag: feeling.image,
                  child: Image.asset(
                    "assets/images/${feeling.image}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned.directional(
                textDirection: TextDirection.ltr,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(64)),
                    child: Center(
                      child: Text(
                        '${feeling.index+1}',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ),
                bottom: 1,
                end: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}
