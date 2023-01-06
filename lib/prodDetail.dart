import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'db.dart';
import 'navigationDrawer.dart';

class prodDetail extends StatefulWidget {
  @override
  State<prodDetail> createState() => _prodDetailState();
}

class _prodDetailState extends State<prodDetail> {
  var snackbar;
  dbConfig dbconfig = dbConfig();
  var nomProd = '0';
  var stockProd = '0';
  late List<Map> response;
  @override
  void initState() async {
    response = await dbconfig
        .readData("SELECT * FROM produit WHERE pname='" + nomProd.toString() //+
            //  "and "
            //      "stock='" +
            //stockProd.toString() +
            //"'"
            );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Info = ModalRoute.of(context)?.settings.arguments as List<String?>;
    if (kDebugMode) {
      nomProd = Info.first!;
      stockProd = Info.last!;
    }
    print(nomProd.toString());
    print(stockProd.toString());

    return Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: Text('Détaille du produit'),
          centerTitle: true,
          backgroundColor: Colors.cyan,
          actions: <Widget>[
            CircleAvatar(
              backgroundImage: AssetImage('images/nabilLogo.png'),
              radius: 30.0,
            ),
          ],
        ),
        body: Container(
          child: ListView(
            children: [
              Row(
                children: [
                  Text("Nom du produit: "),
                  SizedBox(
                    width: 30,
                  ),
                  Text(response.asMap()[0]!.values.toList().asMap()[1]),
                ],
              ),
              Row(
                children: [
                  Text("Prix du produit: "),
                  SizedBox(
                    width: 30,
                  ),
                  Text(response.asMap()[0]!.values.toList().asMap()[6]),
                ],
              ),
              Row(
                children: [
                  Text("Prix de vente du produit: "),
                  SizedBox(
                    width: 30,
                  ),
                  Text(response.asMap()[0]!.values.toList().asMap()[8]),
                ],
              ),
              Row(
                children: [
                  Text("Stock du produit: "),
                  SizedBox(
                    width: 30,
                  ),
                  Text(response.asMap()[0]!.values.toList().asMap()[7]),
                ],
              ),
              Row(
                children: [
                  Text("Date ajout du produit: "),
                  SizedBox(
                    width: 30,
                  ),
                  Text(response.asMap()[0]!.values.toList().asMap()[10]),
                ],
              ),
            ],
          ),
        ));
  }
}
