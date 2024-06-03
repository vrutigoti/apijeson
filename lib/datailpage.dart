import 'dart:convert';
import 'dart:developer';

import 'package:apijeson/products.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/rating/gf_rating.dart';
import 'package:http/http.dart' as http;
import 'package:getwidget/getwidget.dart';

class datailspage extends StatefulWidget {
  const datailspage({super.key});

  @override
  State<datailspage> createState() => _datailspageState();
}

class _datailspageState extends State<datailspage> {
  double _rating = 3;
  final dio = Dio();
  @override
  Widget build(BuildContext context) {
    Products p= ModalRoute.of(context)!.settings.arguments as Products ;
    Future getdata()
    async {
      var url = Uri.https('dummyjson.com','products/${p.id}');
      var response = await http.get(url);
      Map m=jsonDecode(response.body);
      log("${m}");
      return m;
    }
    return Scaffold(
      appBar: AppBar(title: Text("Products"),),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if(snapshot.connectionState==ConnectionState.done)
            {
              if(snapshot.hasData)
                {
                  return Column(
                    children: [
                      SizedBox(height: 10,),
                      Container(
                          child: Center(child: Text("${p.title}",style: TextStyle(fontSize: 30),))
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 200,
                          width: 200,
                          decoration: BoxDecoration(image:DecorationImage(image: NetworkImage("${p.thumbnail}")),
                      )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Center(child: Text("${p.description}",style: TextStyle(fontSize: 20),),),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: Center(child: Text("💲 ${p.price}",style: TextStyle(fontSize: 20),),),
                      ),
                      Container(
                        child:  GFRating(
                          value: _rating,
                          onChanged: (value) {
                            setState(() {
                              _rating = value;
                            });
                          },
                        ),
                      )
                    ],
                  );
                }
              else
                {
                  return Center(child: CircularProgressIndicator(),);
                }
            }
          else
            {
              return Center(child: CircularProgressIndicator(),);
            }
      },),
    );
  }
}
