import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';

void main()
{
  runApp(MaterialApp(
    home: demo(),
  ));
}
class demo extends StatefulWidget {
  const demo({super.key});

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  double _rating = 3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GFRating(
        value: _rating,
        onChanged: (value) {
          setState(() {
            _rating = value;
          });
        },
      ),
    );
  }
}
