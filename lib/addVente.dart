import 'package:flutter/material.dart';

import 'db.dart';
import 'model/vente.dart';
import 'venteManagement.dart';

class addVente extends StatefulWidget {
  @override
  State<addVente> createState() => _addVenteState();
}

class _addVenteState extends State<addVente> {
  dbConfig dbconfig = dbConfig();

  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formState = new GlobalKey<FormState>();
  final TextEditingController numFact = new TextEditingController();
  final TextEditingController codeProduit = new TextEditingController();
  final TextEditingController ref = new TextEditingController();
  final TextEditingController prixVente = new TextEditingController();
  final TextEditingController stockSortie = new TextEditingController();
  final TextEditingController total = new TextEditingController();
  final TextEditingController addedDate = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? myPwd, myEmail, myName, myFname, myGender;
  @override
  Widget build(BuildContext context) {
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
    final TextFormField numfacture = TextFormField(
      controller: numFact,
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
          hintText: "Num facture",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final TextFormField Stock = TextFormField(
      controller: stockSortie,
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
          hintText: "Stock sortie",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );
    final TextFormField PrixVente = TextFormField(
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
          hintText: "Prix de vente",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    final TextFormField CodeProduit = TextFormField(
      controller: codeProduit,
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
          hintText: "Code du produit",
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

    final TextFormField Total = TextFormField(
      controller: total,
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
          hintText: "Total",
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/commerce.jpg'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Text(
            'Nouvelle\nVente',
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
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 35, right: 35),
                      child: Column(
                        children: [
                          numfacture,
                          SizedBox(
                            height: 30,
                          ),
                          CodeProduit,
                          SizedBox(
                            height: 30,
                          ),
                          Ref,
                          SizedBox(
                            height: 40,
                          ),
                          PrixVente,
                          SizedBox(
                            height: 40,
                          ),
                          Stock,
                          SizedBox(
                            height: 40,
                          ),
                          Total,
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
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Color(0xff4c505b),
                                child: IconButton(
                                    color: Colors.white,
                                    onPressed: () async {
                                      if (numFact.text.toString().isEmpty ||
                                          codeProduit.text.toString().isEmpty ||
                                          ref.text.toString().isEmpty ||
                                          prixVente.text.toString().isEmpty ||
                                          stockSortie.text.toString().isEmpty ||
                                          total.text.toString().isEmpty) {
                                        var snackbar = SnackBar(
                                          content: Text(
                                              "Ajout échouée! champs vide"),
                                          backgroundColor: Colors.red,
                                        );
                                        scaffoldKey.currentState!
                                            .showSnackBar(snackbar);
                                      } else {
                                        VenteModel v = new VenteModel();
                                        v.numFacture = numFact.text.toString();
                                        v.codeProduit =
                                            codeProduit.text.toString();
                                        v.reference = ref.text.toString();
                                        v.prixVente = prixVente.text.toString();
                                        v.stockSortie =
                                            stockSortie.text.toString();
                                        v.total = total.text.toString();
                                        var date = new DateTime.now();
                                        v.addedDate = date.toString();

                                        print(v.numFacture.toString() +
                                            "-" +
                                            v.codeProduit.toString() +
                                            "-" +
                                            v.prixVente.toString());

                                        int response = await dbconfig.insertData(
                                            "INSERT INTO 'vente' ('numFacture','codeProduit','ref','prixVente','stockSortie','total','addedDate') VALUES('" +
                                                v.numFacture.toString() +
                                                "','" +
                                                v.codeProduit.toString() +
                                                "','" +
                                                v.reference.toString() +
                                                "','" +
                                                v.prixVente.toString() +
                                                "','" +
                                                v.stockSortie.toString() +
                                                "','" +
                                                v.total.toString() +
                                                "','" +
                                                v.addedDate.toString() +
                                                "')");
                                        if (response > 0) {
                                          var snackbar = SnackBar(
                                            content:
                                                Text("Ajout avec succès!!!!!!"),
                                            backgroundColor: Colors.green,
                                          );
                                          scaffoldKey.currentState!
                                              .showSnackBar(snackbar);
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      venteManagement()));
                                        } else {
                                          var snackbar = SnackBar(
                                            content:
                                                Text("Erreur d'ajout!!!!!!"),
                                            backgroundColor: Colors.red,
                                          );
                                          scaffoldKey.currentState!
                                              .showSnackBar(snackbar);
                                        }
                                      }
                                    },
                                    icon: Icon(
                                      Icons.arrow_forward,
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
