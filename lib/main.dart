
import 'dart:convert';
import 'dart:developer';
// import 'dart:js';



import 'package:apijeson/datailpage.dart';
import 'package:apijeson/products.dart';
import 'package:apijeson/student.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main()
{
  runApp(MaterialApp(
    routes: {
      "detail":(context) => datailspage(),
      "first":(context) => first(),

    },
    home: first(),
  ));
}
class first extends StatefulWidget {
  const first({super.key});

  @override
  State<first> createState() => _firstState();
}

class _firstState extends State<first> {
  final dio = Dio();

  // Future getHttp()
  // async {
  //     final response = await dio.get('https://syflutter.000webhostapp.com/view_data_api.php');
  //     log("${response.data}");
  //     dynamic m=response.data;
  //     log("${m}");
  //     return m;
  // }


  Future getdata()
  async {
    var url = Uri.https('dummyjson.com','products');
    var response = await http.get(url);
    Map m=jsonDecode(response.body);
    log("${m}");
    return m;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getHttp();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body:
      FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
       if(snapshot.connectionState==ConnectionState.done)
         {
            if(snapshot.hasData)
              {
                Map m=snapshot.data;
                List l=m['products'];
                log("${m}");
                return ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    print("${jsonEncode(l[index])}");
                    //student s=student.fromMap(l[index]);
                    Products p= Products.fromJson(l[index]);
                    //print(s);
                    print(p);
                  return InkWell(onTap: () {
                    Navigator.pushNamed(context, "detail",arguments: p);
                  },
                    child: ListTile(

                      // title: Text("${s.name}"),
                      // subtitle: Text ("${s.contact}"),
                      // trailing: Text("${s.id}"),

                      title: Text("${p.title}"),
                      subtitle: Text ("${p.description}"),
                      trailing: Text("💲${p.price}"),
                      leading: CircleAvatar(child: Image(image: NetworkImage("${p.thumbnail}"),fit: BoxFit.fill,),)
                    ),
                  );
                },);
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
      },
      ),
    );
  }
}
