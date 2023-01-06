import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'db.dart';
import 'model/vente.dart';

class newCommande extends StatefulWidget {
  const newCommande({Key? key}) : super(key: key);

  @override
  State<newCommande> createState() => _newCommandeState();
}

class _newCommandeState extends State<newCommande> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _isLoading = false;
  final List<RoundedLoadingButtonController> _btnControllers = [];
  List<TextEditingController> _controllerQTT = [];
  List<TextEditingController> _controllerQTT1 = [];

  List<TextEditingController> _controllerPrice = [];

  List<TextFormField> _Autre = [];
  List<TextFormField> _Autre1 = [];
  List<CheckboxListTile> _CheckBoxLists = [];

  List<bool> _valuesCheck = [];
  List<String> _AutreNames = [];
  List<String> _AutrePrice = [];
  dbConfig dbconfig = dbConfig();
  final TextEditingController pname = new TextEditingController();
  final GlobalKey<FormState> formState = new GlobalKey<FormState>();

  final TextEditingController numFact = new TextEditingController();
  int overal = 0;
  List prodList = [
    ["فيستا", 0],
    ["سروال سبور (كلاسيك)", 0],
    ["سروال نطوال", 0],
    ["سروال جين", 0],
    ["سروال سرفات (كتان)", 0],
    ["سروال سرفات (كاوي)", 0],
    ["سرفات كومبلي", 0],
    ["دودن", 0],
    ["دودن(جليا)", 0],
    ["تريكو", 0],
    ["قمجا", 0],
    ["تنيسا", 0],
    ["بلغا", 0],
    ["سبتا", 0],
    ["بنطكور", 0],
    ["شورت", 0]
  ];
  Future<List<Map>> readData1() async {
    List<Map> response1 = await dbconfig.readData("SELECT * FROM produit");
    return response1;
  }

  int nbrArticle1 = 0;
  @override
  Widget build(BuildContext context) {
    _btnControllers.add(RoundedLoadingButtonController());
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text(
          'Nouvelle Vente',
          style: TextStyle(color: Colors.white, fontSize: 33),
        ),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/nabilLogo.png'),
            radius: 30.0,
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: ListView(
          children: [
            Center(
              child: Container(
                width: double.infinity,
                child: Center(
                  child: Container(
                    color: Colors.pinkAccent,
                    width: 500,
                    height: 50,
                    alignment: Alignment.center,
                    child: Text(
                      "إختر المنتج",
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          //backgroundColor: Colors.teal,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  //    border: Border.all(color: Colors.green, width: 5)
                ),
                child: Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder(
                      future: readData1(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Map>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              controller: ScrollController(),
                              itemCount: snapshot.data!.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, i) {
                                _controllerQTT.add(TextEditingController());
                                _controllerPrice.add(TextEditingController());

                                _valuesCheck.add(false);
                                _controllerQTT1
                                    .add(new TextEditingController());
                                _CheckBoxLists.add(CheckboxListTile(
                                  value: false,
                                  onChanged: (val) {},
                                ));
                                _Autre.add(TextFormField());
                                _Autre1.add(TextFormField());
                                _AutreNames.add("nil");
                                _AutrePrice.add("nil");
                                return Container(
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.greenAccent),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: _CheckBoxLists[i] =
                                            CheckboxListTile(
                                          title: Text(
                                            "${snapshot.data![i]['pname']}",
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                //fontStyle: FontStyle.italic,
                                                fontSize: 14),
                                          ),

                                          /*                      subtitle: const Text(
                                            'يرجى التحقق من كمية المنتج المخزنة',
                                            textDirection: TextDirection.rtl,
                                            textAlign: TextAlign.left,
                                          ),

                                          secondary: const Icon(
                                            Icons.production_quantity_limits,
                                            color: Colors.indigo,
                                          ),
                    */

                                          autofocus: false,
                                          activeColor: Colors.green,
                                          checkColor: Colors.white,
                                          selected: _valuesCheck[i],
                                          value: _valuesCheck[i],
                                          onChanged: (val) {
                                            setState(() {
                                              _valuesCheck[i] = val!;
                                              //_valuesCheck.insert(i, val);
                                              _AutreNames.insert(i,
                                                  "${snapshot.data![i]['pname']}");
                                              _AutrePrice.insert(i,
                                                  "${snapshot.data![i]['prixVente']}");
                                            });
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        width: 3,
                                      ),
                                      Flexible(
                                        child: _Autre[i] = TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _controllerQTT1[i],
                                          enabled:
                                              _valuesCheck[i] ? true : false,
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.teal,
                                                ),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.balance,
                                                color: Colors.teal,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              hintText: "Quantité",
                                              hintStyle: TextStyle(
                                                  color: Colors.blueAccent),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )),
                                        ),
                                      ),
                                      Flexible(
                                        child: _Autre1[i] = TextFormField(
                                          keyboardType: TextInputType.number,
                                          controller: _controllerPrice[i],
                                          enabled:
                                              _valuesCheck[i] ? true : false,
                                          style: TextStyle(
                                              color: Colors.deepOrange),
                                          decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.teal,
                                                ),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.balance,
                                                color: Colors.teal,
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                borderSide: BorderSide(
                                                  color: Colors.black,
                                                ),
                                              ),
                                              hintText: "Prix",
                                              hintStyle: TextStyle(
                                                  color: Colors.blueAccent),
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              )),
                                        ),
                                      ),
                                    ],
                                    //    hoverColor: Colors.deepPurpleAccent,
                                    //  tileColor: Colors.blueGrey,
                                  ),
                                );
                              });
                        }
                        return Center(child: CircularProgressIndicator());
                      })
                ])),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ajouter',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 27,
                      fontWeight: FontWeight.w700),
                ),
                Flexible(
                  child: RoundedLoadingButton(
                      child: Text('تأكيد !',
                          style: TextStyle(color: Colors.white)),
                      controller: _btnControllers.elementAt(0),
                      onPressed: () async {
                        int countAutre = 0;
                        int q;
                        VenteModel v = new VenteModel();
                        var date = new DateTime.now();
                        v.addedDate = date.toString();
                        int response3 = await dbconfig.insertData(
                            "INSERT INTO 'vente' ('addedDate') VALUES('" +
                                v.addedDate.toString() +
                                "')");

                        print("insert vente");

                        for (q = 0; q < _valuesCheck.length; q++) {
                          if (_valuesCheck[q] == true) countAutre++;
                        }

                        if (q < 1) {
                          var snackbar = SnackBar(
                            content: Text(
                              "يرجى إختيار منتج محدد",
                              textDirection: TextDirection.rtl,
                              textAlign: TextAlign.left,
                            ),
                            backgroundColor: Colors.red,
                          );

                          scaffoldKey.currentState!.showSnackBar(snackbar);

                          _btnControllers.elementAt(0).error();
                        } else {
                          _isLoading = true;

////////////////////////////////////////AUTRE/////////////////////////////////////////////////////////////////////
                          if (countAutre > 0) {
                            int p = 0;

                            while (p < _AutreNames.length) {
                              if (_AutreNames[p].toString().isNotEmpty &&
                                  _AutreNames[p].toString() != "nil" &&
                                  _controllerQTT1[p].text.isNotEmpty &&
                                  int.parse(
                                          _controllerQTT1[p].text.toString()) >
                                      0) {
                                print("Autre produit" + p.toString() + ": ");

                                print("Nom: " + _AutreNames[p].toString());

                                print("Quantité: " +
                                    _controllerQTT1[p].text.toString());

                                if (_controllerPrice[p]
                                    .text
                                    .toString()
                                    .isNotEmpty)
                                  print("Prix spéciale: " +
                                      _controllerPrice[p].text.toString());
                                else
                                  print("Prix réel: " +
                                      _AutrePrice[p].toString());

                                List<Map> response1 = await dbconfig.readData(""
                                        "SELECT * FROM produit WHERE pname='" +
                                    _AutreNames[p].toString() +
                                    "'");

                                if (response1.isNotEmpty) {
                                  int currentStock = int.parse(response1
                                      .asMap()[0]!
                                      .values
                                      .toList()
                                      .asMap()[7]
                                      .toString());

                                  int qtt = int.parse(
                                      _controllerQTT1[p].text.toString());
                                  if (qtt > currentStock) {
                                    var snackbar = SnackBar(
                                      content: Text(
                                        "يرجي التحقق من كمية المنتج !!!",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            //backgroundColor: Colors.teal,
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                      backgroundColor: Colors.red,
                                    );
                                    scaffoldKey.currentState!
                                        .showSnackBar(snackbar);
                                  } else {
                                    nbrArticle1++;

                                    if (_controllerPrice[p]
                                        .text
                                        .toString()
                                        .isNotEmpty) {
                                      overal = overal +
                                          int.parse(_controllerQTT1[p]
                                                  .text
                                                  .toString()) *
                                              int.parse(_controllerPrice[p]
                                                  .text
                                                  .toString());
                                    } else {
                                      overal = overal +
                                          int.parse(_controllerQTT1[p]
                                                  .text
                                                  .toString()) *
                                              int.parse(
                                                  _AutrePrice[p].toString());
                                    }

                                    currentStock = currentStock - qtt;

                                    int response2 = await dbconfig.updateData(
                                        "UPDATE produit set stock='" +
                                            currentStock.toString() +
                                            "' WHERE pname='" +
                                            _AutreNames[p].toString() +
                                            "'");
                                    print("update stock");

                                    List<Map> response4 = await dbconfig.readData(
                                        ""
                                        "SELECT * FROM vente ORDER BY vid DESC LIMIT 1");
                                    if (response2 > 0 && response4.isNotEmpty) {
                                      print("OK");
                                      int response5 = await dbconfig.insertData(
                                          "INSERT INTO 'ligneCommande' ('vid','pid','quantité') VALUES('" +
                                              response4
                                                  .asMap()[0]!
                                                  .values
                                                  .toList()
                                                  .asMap()[0]
                                                  .toString() +
                                              "','" +
                                              response1
                                                  .asMap()[0]!
                                                  .values
                                                  .toList()
                                                  .asMap()[0]
                                                  .toString() +
                                              "','" +
                                              _controllerQTT1[p]
                                                  .text
                                                  .toString() +
                                              "')");
                                      print("Lingne de commande: " +
                                          response5.toString());
                                    }
                                  }

                                  //   }

                                }
                                //print("$response1");

                                //
                              }
                              p++;
                            }
                          }
///////////////////////////////////////Autre//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////

                          print("le nombre d'article vendue: " +
                              nbrArticle1.toString());

                          print("Le prix globale des produits vendue: " +
                              overal.toString());

                          v.nombreArticle = nbrArticle1.toString();

                          int response2 = await dbconfig.updateData(
                              "UPDATE vente set nbrArticle='" +
                                  v.nombreArticle.toString() +
                                  "' , total='" +
                                  overal.toString() +
                                  "' WHERE addedDate='" +
                                  v.addedDate.toString() +
                                  "'");

                          if (response2 > 0) {
                            var snackbar = SnackBar(
                              content: Text("Ajout avec succès!!!!!!"),
                              backgroundColor: Colors.green,
                            );
                            scaffoldKey.currentState!.showSnackBar(snackbar);
                            Navigator.of(context).pushNamed('VenteManagement');
                          } else {
                            var snackbar = SnackBar(
                              content: Text("Erreur d'ajout!!!!!!"),
                              backgroundColor: Colors.red,
                            );
                            scaffoldKey.currentState!.showSnackBar(snackbar);
                          }

/*




    */
                        }

                        _btnControllers.elementAt(0).success();
                        await Future.delayed(const Duration(seconds: 1));
                        _isLoading = false;
                      }),
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
