import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'addProd.dart';
import 'db.dart';
import 'navigationDrawer.dart';
import 'updateProd.dart';

class adminAccount extends StatefulWidget {
  @override
  State<adminAccount> createState() => _adminAccountState();
}

class _adminAccountState extends State<adminAccount> {
  var snackbar;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  final List<RoundedLoadingButtonController> _btnControllers = [];
  final TextEditingController chercheController = new TextEditingController();
  final TextEditingController titleController = new TextEditingController();
  final GlobalKey<FormState> _keyDialogForm = new GlobalKey<FormState>();
  final TextEditingController prixControl = new TextEditingController();
  final TextEditingController prixVenteControl = new TextEditingController();
  final TextEditingController stockControl = new TextEditingController();
  late TextFormField prixText;
  late TextFormField prixVenteText;
  late TextFormField stockText;
  dbConfig dbconfig = dbConfig();
  Future<List<Map>> readData() async {
    List<Map> response = await dbconfig.readData("SELECT * FROM produit");
    return response;
  }

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 17; i++)
      _btnControllers.add(RoundedLoadingButtonController());
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Gestion des articles'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.red,
              size: 50,
            ),
            hoverColor: Colors.red,
            onPressed: () async {
              return AwesomeDialog(
                context: context,
                headerAnimationLoop: false,
                dialogType: DialogType.noHeader,
                titleTextStyle: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                title: 'مسح',
                descTextStyle: TextStyle(fontSize: 22),
                desc: 'هل تريد حقا مسح جميع المنتوجات',
                btnOkOnPress: () async {
                  int response12 = await dbconfig
                      .deleteData("Delete FROM produit WHERE pid>0");

                  if (response12 > 0) {
                    var snackbar = SnackBar(
                      content: Text(
                        "!! تم المسح",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            //backgroundColor: Colors.teal,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                      backgroundColor: Colors.orange,
                    );
                    setState(() {
                      scaffoldKey.currentState!.showSnackBar(snackbar);
                    });
                  }
                },
                btnOkIcon: Icons.check_circle,
                btnCancelOnPress: () {
                  Navigator.of(context).pop();
                },
                btnCancelIcon: Icons.cancel_rounded,
              ).show();
            },
          ),
          SizedBox(
            width: 40,
          ),
          CircleAvatar(
            backgroundImage: AssetImage('images/nabilLogo.png'),
            radius: 30.0,
          ),
        ],
      ),
      floatingActionButton: Center(
        child: FloatingActionButton(
          hoverColor: Colors.teal,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => addProd()));
          },
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  color: Colors.greenAccent,
                  hoverColor: Colors.teal,
                  iconSize: 50,
                  icon: Icon(
                    Icons.search,
                    color: Colors.green,
                    size: 40,
                  ),
                  onPressed: () async {
                    if (chercheController.text.isNotEmpty) {
                      List<Map> response1 =
                          await dbconfig.readData("SELECT * FROM produit "
                                  "WHERE pname = '" +
                              chercheController.text.toString() +
                              "'");
                      if (response1.isNotEmpty) {
                        AwesomeDialog(
                          context: context,
                          headerAnimationLoop: false,
                          dialogType: DialogType.noHeader,
                          titleTextStyle: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            //    fontStyle: FontStyle.italic
                          ),
                          title: response1
                              .asMap()[0]!
                              .values
                              .toList()
                              .asMap()[1]
                              .toString(),
                          descTextStyle: TextStyle(
                            fontSize: 22,
                            //    fontStyle: FontStyle.italic
                          ),
                          desc: "الكمية: " +
                              response1
                                  .asMap()[0]!
                                  .values
                                  .toList()
                                  .asMap()[7]
                                  .toString(),
                          btnOkOnPress: () {
                            debugPrint('OnClcik');
                          },
                          btnOkIcon: Icons.check_circle,
                        ).show();
                      } else {
                        AwesomeDialog(
                          context: context,
                          headerAnimationLoop: false,
                          dialogType: DialogType.noHeader,
                          titleTextStyle: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                          title: "Produit non disponible !!!",
                          descTextStyle: TextStyle(
                              fontSize: 22, fontStyle: FontStyle.italic),
                          btnOkOnPress: () {
                            debugPrint('OnClcik');
                          },
                          btnOkIcon: Icons.check_circle,
                        ).show();
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 40,
                ),
                Flexible(
                  child: TextField(
                    controller: chercheController,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'Rechercher',
                        hintStyle: TextStyle(color: Colors.indigo),
                        //filled=true,
                        fillColor: Colors.white12,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: BorderSide(color: Colors.white),
                        )),
                  ),
                )
              ],
            ),
            FutureBuilder(
                future: readData(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        controller: ScrollController(),
                        itemCount: snapshot.data!.length,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, i) {
                          return Dismissible(
                            onDismissed: (direction) async {
                              int response12 = await dbconfig
                                  .deleteData("Delete FROM produit WHERE "
                                          "pname='" +
                                      snapshot.data![i]['pname'].toString() +
                                      "'");
                              if (response12 > 0) {
                                var snackbar = SnackBar(
                                  content: Text(
                                    "!! تم المسح",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        //backgroundColor: Colors.teal,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1),
                                  ),
                                  backgroundColor: Colors.orange,
                                );
                                scaffoldKey.currentState!
                                    .showSnackBar(snackbar);
                              }
                            },
                            key: UniqueKey(),
                            child: Card(
                              child: ListTile(
                                title: Text(
                                  "${snapshot.data![i]['pname'].toString()}",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22),
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.left,
                                ),
                                leading: Text(
                                  "${snapshot.data![i]['prixVente']}DA",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontStyle: FontStyle.italic),
                                ),
                                subtitle:
                                    Text("${snapshot.data![i]['stock']} unité"),
                                trailing: CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.green,
                                  child: IconButton(
                                      color: Colors.white,
                                      onPressed: () async {
                                        List<Map> response1 = await dbconfig
                                            .readData("SELECT * FROM produit "
                                                    "WHERE pname = '" +
                                                snapshot.data![i]['pname']
                                                    .toString() +
                                                "'");
                                        if (response1.isEmpty) {
                                          var snackbar = SnackBar(
                                            content: Text(
                                              "!! غير متوفر",
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
                                          var nomProd = response1
                                                  .asMap()[0]!
                                                  .values
                                                  .toList()
                                                  .asMap()[1]
                                                  .toString(),
                                              prix = response1
                                                  .asMap()[0]!
                                                  .values
                                                  .toList()
                                                  .asMap()[6]
                                                  .toString(),
                                              prixVente = response1
                                                  .asMap()[0]!
                                                  .values
                                                  .toList()
                                                  .asMap()[8]
                                                  .toString(),
                                              stockProd = response1
                                                  .asMap()[0]!
                                                  .values
                                                  .toList()
                                                  .asMap()[7]
                                                  .toString();
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      updateProd(
                                                        prixProd: prix,
                                                        prixVenteProd:
                                                            prixVente,
                                                        StockProd: stockProd,
                                                        nomProd: nomProd,
                                                      )));
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                      )),
                                ),
                                hoverColor: Colors.deepPurpleAccent,
                                tileColor: Colors.redAccent,
                                onTap: () async {
                                  List<Map> response = await dbconfig.readData(
                                      "SELECT * FROM produit WHERE pname='" +
                                          snapshot.data![i]['pname']
                                              .toString() +
                                          "'" //+
                                      //  "and "
                                      //      "stock='" +
                                      //stockProd.toString() +
                                      //"'"
                                      );

                                  showDialog(
                                    //barrierColor: Colors.teal,
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      backgroundColor: Colors.lightBlueAccent,
                                      title: const Text(
                                        "معلومات حول المنتج",
                                        textDirection: TextDirection.rtl,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: Colors.white,
                                            //backgroundColor: Colors.teal,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1),
                                      ),
                                      content: response.isEmpty
                                          ? const Text(
                                              "You have raised a Alert Dialog Box")
                                          : Container(
                                              child: Column(
                                                children: [
                                                  const Text("إسم المنتج "),
                                                  Text(response
                                                      .asMap()[0]!
                                                      .values
                                                      .toList()
                                                      .asMap()[1]
                                                      .toString()),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text("رقم المنتج "),
                                                  Text(response
                                                      .asMap()[0]!
                                                      .values
                                                      .toList()
                                                      .asMap()[2]
                                                      .toString()),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text("سعر المنتج "),
                                                  Text(response
                                                      .asMap()[0]!
                                                      .values
                                                      .toList()
                                                      .asMap()[6]
                                                      .toString()),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                      "سعر البيع المنتج "),
                                                  Text(response
                                                      .asMap()[0]!
                                                      .values
                                                      .toList()
                                                      .asMap()[8]
                                                      .toString()),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                      "الكمية المخزنة المنتج "),
                                                  Text(response
                                                      .asMap()[0]!
                                                      .values
                                                      .toList()
                                                      .asMap()[7]
                                                      .toString()),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  const Text(
                                                      "تاريخ إضافة المنتج "),
                                                  Text(response
                                                      .asMap()[0]!
                                                      .values
                                                      .toList()
                                                      .asMap()[10]
                                                      .toString()),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                ],
                                              ),
                                            ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(ctx).pop();
                                          },
                                          child: Container(
                                            color: Colors.green,
                                            padding: const EdgeInsets.all(14),
                                            child: const Text(
                                              "رجوع",
                                              textDirection: TextDirection.rtl,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  //backgroundColor: Colors.teal,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),

/////////////////////////////////EDIT///////////////////////////////////////////////////////////////////////////
                              /*
                                Expanded(
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.green,
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () async {},
                                        icon: Icon(
                                          Icons.edit,
                                        )),
                                  ),
                                  flex: 1,
                                ),



*/
//////////////////////////////////////////DELETE/////////////////////////////////////////////////////////////////////
                              /*Expanded(
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.redAccent,
                                    child: IconButton(
                                        hoverColor: Colors.red,
                                        color: Colors.white,
                                        onPressed: () async {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  actions: [
                                                    FlatButton(
                                                        onPressed: () async {
                                                          int response = await dbconfig.deleteData(
                                                              "Delete FROM produit WHERE "
                                                                      "pname='" +
                                                                  snapshot
                                                                      .data![i][
                                                                          'pname']
                                                                      .toString() +
                                                                  "'");

                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          venteManagement()));
                                                        },
                                                        hoverColor:
                                                            Colors.deepOrange,
                                                        child: Text(
                                                          "تأكيد",
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              //backgroundColor: Colors.teal,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              letterSpacing: 1),
                                                        )),
                                                    FlatButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        hoverColor:
                                                            Colors.deepOrange,
                                                        child: Text(
                                                          "رجوع",
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.left,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              //backgroundColor: Colors.teal,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight.bold,
                                                              letterSpacing: 1),
                                                        ))
                                                  ],
                                                  title: Text(
                                                    "هل تريد حقا محو هذا المنتج",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1),
                                                  ),
                                                  backgroundColor: Colors.indigo,
                                                );
                                              });
                                        },
                                        icon: Icon(
                                          Icons.delete,
                                        )),
                                  ),
                                  flex: 1,
                                ),
                                */
                            ),
                          );
                        });
                  }
                  return Center(child: CircularProgressIndicator());
                }),
            SizedBox(
              height: 80,
            ),
            FlatButton(
              onPressed: () async {
                List<Map> response1 =
                    await dbconfig.readData("SELECT * FROM produit");
                int index = 0;
                int somme = 0;
                int somme1 = 0;
                int stock = 0;
                if (response1.isNotEmpty) {
                  while (index < response1.length) {
                    somme = somme +
                        int.parse(response1
                                .asMap()[index]!
                                .values
                                .toList()
                                .asMap()[6]
                                .toString()) *
                            int.parse(response1
                                .asMap()[index]!
                                .values
                                .toList()
                                .asMap()[7]
                                .toString());
                    somme1 = somme1 +
                        int.parse(response1
                                .asMap()[index]!
                                .values
                                .toList()
                                .asMap()[8]
                                .toString()) *
                            int.parse(response1
                                .asMap()[index]!
                                .values
                                .toList()
                                .asMap()[7]
                                .toString());

                    stock = stock +
                        int.parse(response1
                            .asMap()[index]!
                            .values
                            .toList()
                            .asMap()[7]
                            .toString());

                    index++;
                  }

                  print("La somme des prix des produits: " + somme.toString());
                  //print(count2.toString());
                  print("La somme des prix de vente des produits: " +
                      somme1.toString());
                  print("La somme des stock resté des produits: " +
                      stock.toString());

                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.lime,
                        title: Center(
                          child: Text(
                            "رأس المال المتبقى",
                            //textDirection: TextDirection.rtl,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                //backgroundColor: Colors.teal,
                                fontSize: 34,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1),
                          ),
                        ),
                        content: response1.isEmpty
                            ? const Text("غير متوفر")
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    children: [
                                      Center(
                                        child: Text(
                                          DateTime.now()
                                              .toString()
                                              .substring(0, 10),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Center(
                                        child: const Text(
                                          ": التاريخ و الوقت ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                        somme.toString() + " DA",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.normal),
                                      )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                          child: Text(
                                        ": قيمة المنتجات المتبقية بثمن الشراء",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                          child: Text(
                                        somme1.toString() + " DA",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 24,
                                            fontWeight: FontWeight.normal),
                                      )),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                          child: Text(
                                        ": قيمة المنتجات المتبقية بثمن البيع ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Text(
                                          stock.toString() + " وحدة ",
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Flexible(
                                          child: const Text(
                                        ": العدد الإجمالي للمنتجات المتبقية ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ],
                                  ),
                                ]))),
                  );
                } else {
                  var snackbar = SnackBar(
                    content: Text(
                      "!! غير متوفر منتجات",
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
                  scaffoldKey.currentState!.showSnackBar(snackbar);
                }

                await Future.delayed(const Duration(seconds: 1));
              },
              color: Colors.deepPurple,
              child:
                  Text('باقي رأس مالي', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ));
}
