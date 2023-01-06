import 'dart:math';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'adminAccount.dart';
import 'db.dart';
import 'model/product.dart';

class addProd extends StatefulWidget {
  @override
  State<addProd> createState() => _addProdState();
}

class _addProdState extends State<addProd> {
  dbConfig dbconfig = dbConfig();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formState = new GlobalKey<FormState>();
  final TextEditingController pname = new TextEditingController();
  final TextEditingController Autrepname = new TextEditingController();
  final TextEditingController code = new TextEditingController();
  final TextEditingController ref = new TextEditingController();
  final TextEditingController fournisseur = new TextEditingController();
  final TextEditingController cat = new TextEditingController();
  final TextEditingController prix = new TextEditingController();
  final TextEditingController prixVente = new TextEditingController();
  final TextEditingController stock = new TextEditingController();
  //final TextEditingController designation = new TextEditingController();
  final TextEditingController addedDate = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? myPwd, myEmail, myName, myFname, myGender;
  var selectedProd = "فيستا";
  @override
  Widget build(BuildContext context) {
    final DropdownButton NomProd = DropdownButton(
      dropdownColor: Colors.indigo,
      borderRadius: BorderRadius.circular(30),
      focusColor: Colors.lightBlue,
      icon: Icon(
        Icons.done,
        color: Colors.white,
      ),
      underline: Divider(
        thickness: 0,
      ),
      isExpanded: true,
      hint: Container(
        padding: EdgeInsets.only(right: 10),
        width: double.infinity,
        child: Text(
          "إختر إسم المنتج",
          textDirection: TextDirection.rtl,
          textAlign: TextAlign.left,
        ),
      ),
      items: [
        "فيستا",
        "سروال سبور (كلاسيك)",
        "سروال نطوال",
        "سروال جين",
        "سروال سرفات (كتان)",
        "سروال سرفات (كاوي)",
        "سرفات كومبلي",
        "دودن",
        "دودن(جليا)",
        "تريكو",
        "قمجا",
        "تنيسا",
        "بلغا ",
        "سبتا",
        "بنطكور",
        "شورت",
        "أخرى"
      ]
          .map((e) => DropdownMenuItem(
                child: Text(
                  "$e",
                  textDirection: TextDirection.ltr,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 20),
                ),
                value: e,
              ))
          .toList(),
      onChanged: (val) {
        setState(() {
          selectedProd = val;
        });
      },
      value: selectedProd,
    );

    final DropdownSearch prodName = DropdownSearch(
      items: ["Brazil", "France", "Tunisia", "Canada"],
      dropdownSearchDecoration: InputDecoration(
        labelText: "Nom d'article",
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
      ),
      onChanged: print,
      selectedItem: "Tunisia",
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select Product Code';
        }
        return null;
      },
    );

    final TextFormField AddedDate = TextFormField(
      controller: addedDate,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "Date",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
/*
    final TextFormField Designation = TextFormField(
      controller: designation,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "معلومات إضافية",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
*/
    final TextFormField Stock = TextFormField(
      keyboardType: TextInputType.number,
      controller: stock,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "كمية بالوحدة",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final TextFormField PrixVente = TextFormField(
      keyboardType: TextInputType.number,
      controller: prixVente,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "ثمن البيع",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    final TextFormField Prix = TextFormField(
      keyboardType: TextInputType.number,
      controller: prix,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "ثمن الشراء",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final TextFormField Cat = TextFormField(
      controller: cat,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "Catégory",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final TextFormField Prodname = TextFormField(
      controller: pname,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "إسم المنتج",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final TextFormField Ref = TextFormField(
      controller: ref,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: "Référence",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    return Container(
      decoration: BoxDecoration(color: Colors.indigo),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2,
                  top: MediaQuery.of(context).size.height * 0.01),
              child: Text(
                'إضافة منتج جديد',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 33,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          //NomProd,
                          Prodname,
                          SizedBox(
                            height: 20,
                          ),
                          Prix,
                          SizedBox(
                            height: 20,
                          ),
                          PrixVente,
                          SizedBox(
                            height: 20,
                          ),
                          Stock,
                          SizedBox(
                            height: 20,
                          ),
                          //Designation,
                          SizedBox(
                            height: 20,
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
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    hoverColor: Colors.green,
                                    color: Colors.white,
                                    onPressed: () async {
                                      if (pname.text.toString().isEmpty ||

                                              // NomProd.value.isEmpty ||
                                              //                    code.text.toString().isEmpty ||
                                              //                  ref.text.toString().isEmpty ||
                                              //                fournisseur.text.toString().isEmpty ||
                                              //              cat.text.toString().isEmpty ||
                                              prix.text.toString().isEmpty ||
                                              prixVente.text
                                                  .toString()
                                                  .isEmpty ||
                                              stock.text.toString().isEmpty
                                          //|| designation.text.toString().isEmpty

                                          ) {
                                        var snackbar = SnackBar(
                                          content: Text(
                                              "Ajout échouée! champs vide"),
                                          backgroundColor: Colors.red,
                                        );
                                        scaffoldKey.currentState!
                                            .showSnackBar(snackbar);
                                      } else {
                                        ProdModel p = new ProdModel();
                                        p.pname = pname.text.toString();
                                        //p.pname = NomProd.value;
/*
                                        switch (p.pname) {
                                          case "فيستا":
                                            {
                                              p.code = "1";
                                            }
                                            break;
                                          case "سروال سبور (كلاسيك)":
                                            {
                                              p.code = "2";
                                            }
                                            break;
                                          case "سروال نطوال":
                                            {
                                              p.code = "3";
                                            }
                                            break;

                                          case "سروال جين":
                                            {
                                              p.code = "4";
                                            }
                                            break;
                                          case "سروال سرفات (كتان)":
                                            {
                                              p.code = "5";
                                            }
                                            break;
                                          case "سروال سرفات (كاوي)":
                                            {
                                              p.code = "6";
                                            }
                                            break;

                                          case "سرفات كومبلي":
                                            {
                                              p.code = "7";
                                            }
                                            break;
                                          case "دودن":
                                            {
                                              p.code = "8";
                                            }
                                            break;
                                          case "دودن(جليا)":
                                            {
                                              p.code = "9";
                                            }
                                            break;

                                          case "تريكو":
                                            {
                                              p.code = "10";
                                            }
                                            break;
                                          case "قمجا":
                                            {
                                              p.code = "11";
                                            }
                                            break;
                                          case "تنيسا":
                                            {
                                              p.code = "12";
                                            }
                                            break;

                                          case "بلغا":
                                            {
                                              p.code = "13";
                                            }
                                            break;
                                          case "سبتا":
                                            {
                                              p.code = "14";
                                            }
                                            break;
                                          case "بنطكور":
                                            {
                                              p.code = "15";
                                            }
                                            break;

                                          case "شورت":
                                            {
                                              p.code = "16";
                                            }
                                            break;

                                          default:
                                            {
                                              p.code = "17";
                                            }
                                            break;
                                        }*/

                                        Random random = new Random();
                                        int randomNumber =
                                            random.nextInt(90000) *
                                                    random.nextInt(90000) +
                                                18;
                                        p.code = randomNumber.toString();
                                        //p.code = code.text.toString();
                                        p.reference = ref.text.toString();
                                        p.fournisseur =
                                            fournisseur.text.toString();
                                        p.category = cat.text.toString();
                                        p.prix = prix.text.toString();
                                        p.prixVente = prixVente.text.toString();
                                        p.stock = stock.text.toString();
                                        //p.designation = designation.text.toString();
                                        var date = new DateTime.now();
                                        p.addedDate = date.toString();

                                        if (p.pname.toString() == 'أخرى') {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: Form(
                                                      child: Column(
                                                          children: <Widget>[
                                                            Center(
                                                              child: Container(
                                                                child: Text(
                                                                  'إسم منتج جديد',
                                                                  textDirection:
                                                                      TextDirection
                                                                          .rtl,
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                            ),
                                                            TextFormField(
                                                              controller:
                                                                  Autrepname,
                                                              decoration:
                                                                  const InputDecoration(
                                                                icon: Icon(Icons
                                                                    .production_quantity_limits_rounded),
                                                              ),
                                                              maxLength: 50,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            )
                                                          ]),
                                                    ),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                        onPressed: () async {
                                                          if (Autrepname.text
                                                              .isNotEmpty) {
                                                            p.pname = Autrepname
                                                                .text
                                                                .toString();
                                                            Random random =
                                                                new Random();
                                                            int randomNumber = random
                                                                        .nextInt(
                                                                            90000) *
                                                                    random.nextInt(
                                                                        90000) +
                                                                18;
                                                            p.code =
                                                                randomNumber
                                                                    .toString();

                                                            int response = await dbconfig.insertData("INSERT INTO 'produit' ('pname','code','ref','fournisseurID','cat','prix','prixVente','stock','designation','addedDate') VALUES('" +
                                                                p.pname
                                                                    .toString() +
                                                                "','" +
                                                                p.code
                                                                    .toString() +
                                                                "','" +
                                                                p.reference
                                                                    .toString() +
                                                                "','" +
                                                                p.fournisseur
                                                                    .toString() +
                                                                "','" +
                                                                p.category
                                                                    .toString() +
                                                                "','" +
                                                                p.prix
                                                                    .toString() +
                                                                "','" +
                                                                p.prixVente
                                                                    .toString() +
                                                                "','" +
                                                                p.stock
                                                                    .toString() +
                                                                "','" +
                                                                p.designation
                                                                    .toString() +
                                                                "','" +
                                                                p.addedDate
                                                                    .toString() +
                                                                "')");
                                                            print(response);

                                                            if (response > 0) {
                                                              Navigator.of(
                                                                      context)
                                                                  .push(MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              adminAccount()));
                                                            } else {
                                                              var snackbar =
                                                                  SnackBar(
                                                                content: Text(
                                                                  "!! خطأ في الإضافة",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      color: Colors.white,
                                                                      //backgroundColor: Colors.teal,
                                                                      fontSize: 25,
                                                                      fontWeight: FontWeight.bold,
                                                                      letterSpacing: 1),
                                                                ),
                                                                backgroundColor:
                                                                    Colors.red,
                                                              );
                                                              setState(() {
                                                                scaffoldKey
                                                                    .currentState!
                                                                    .showSnackBar(
                                                                        snackbar);
                                                              });
                                                            }

                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            adminAccount()));
                                                          }

                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'تأكيد',
                                                          textDirection:
                                                              TextDirection.rtl,
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        color: Colors.blue,
                                                      ),
                                                      FlatButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            adminAccount()));
                                                          },
                                                          child: Text(
                                                            'رجوع',
                                                            textDirection:
                                                                TextDirection
                                                                    .rtl,
                                                            textAlign:
                                                                TextAlign.left,
                                                          )),
                                                    ]);
                                              });
                                        } else {
                                          int response = await dbconfig.insertData(
                                              "INSERT INTO 'produit' ('pname','code','ref','fournisseurID','cat','prix','prixVente','stock','designation','addedDate') VALUES('" +
                                                  p.pname.toString() +
                                                  "','" +
                                                  p.code.toString() +
                                                  "','" +
                                                  p.reference.toString() +
                                                  "','" +
                                                  p.fournisseur.toString() +
                                                  "','" +
                                                  p.category.toString() +
                                                  "','" +
                                                  p.prix.toString() +
                                                  "','" +
                                                  p.prixVente.toString() +
                                                  "','" +
                                                  p.stock.toString() +
                                                  "','" +
                                                  p.designation.toString() +
                                                  "','" +
                                                  p.addedDate.toString() +
                                                  "')");

                                          if (response > 0) {
                                            var snackbar = SnackBar(
                                              content: Text("إضافة بنجاح!!!!!"),
                                              backgroundColor: Colors.green,
                                            );
                                            scaffoldKey.currentState!
                                                .showSnackBar(snackbar);

                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        adminAccount()));
                                          } else {
                                            var snackbar = SnackBar(
                                              content: Text(
                                                "!! خطأ في الإضافة",
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
                                          }
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      Icons.add_shopping_cart_outlined,
                                    )),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
