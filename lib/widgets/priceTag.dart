import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String price;

  PriceTag(this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(10)),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.monetization_on,
              color: Colors.indigo,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              price,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.purple),
            ),
          ],
        ));
  }
}
