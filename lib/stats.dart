import 'package:date_field/date_field.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'db.dart';
import 'navigationDrawer.dart';

class stats extends StatefulWidget {
  const stats({Key? key}) : super(key: key);
  @override
  State<stats> createState() => _statsState();
}

class _statsState extends State<stats> {
  final TextEditingController cherche = new TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  dbConfig dbconfig = dbConfig();
  final GlobalKey<FormState> formState = new GlobalKey<FormState>();
  var vid = '0';
  DateTime _selectedDate = DateTime.now();
  late DatePicker datePicker;
  late DateTimeFormField datefield;
  DateTime chercheDate = DateTime.now();

  var snackbar;
  Future<List<Map>> readData(var date) async {
    List<Map> response = await dbconfig.readData(
        "SELECT * FROM vente WHERE addedDate LIKE '" +
            date.toString().substring(0, 10) +
            "%'");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Statistique'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/nabilLogo.png'),
            radius: 30.0,
          )
        ],
      ),
      body: Container(
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    //color: Colors.blue,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(12.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "تاريخ اليوم",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              fontStyle: FontStyle.italic),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.green,
                  size: 40,
                ),
                Flexible(
                  child: datefield = DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.redAccent),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'بحث عن يوم',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,

                    //  selectedDate: selectedDate,
                    onDateSelected: (DateTime value) {
                      setState(() {
                        chercheDate = value;
                        datePicker.onDateChange!(chercheDate);
                      });
                    },
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20),
              height: 150,
              color: Colors.white10,
              child: datePicker = DatePicker(
                DateTime(2022, 10, 20),
                height: 100,
                width: 80,
                initialSelectedDate: DateTime.now(),
                selectionColor: Colors.deepPurple,
                selectedTextColor: Colors.white,
                dateTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                ),
                dayTextStyle: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey),
                monthTextStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                onDateChange: (date) async {
                  setState(() {
                    _selectedDate = date;
                  });
                },
              ),
            ),
            FutureBuilder(
              future: readData(_selectedDate),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      controller: ScrollController(),
                      itemCount: snapshot.data!.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        return Card(
                            child: ListTile(
                          title: Text(
                            "${snapshot.data![i]['total']} DA",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontSize: 25),
                          ),
                          subtitle: Text(
                            "${snapshot.data![i]['addedDate'].toString()}",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic),
                          ),
                          trailing: Icon(
                            Icons.add_shopping_cart,
                            size: 30,
                            color: Colors.black,
                          ),
                          leading: Text("${snapshot.data![i]['vid']}"),
                          hoverColor: Colors.deepPurpleAccent,
                          tileColor: Colors.green,
                        ));
                      });
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.teal,
              child: IconButton(
                  color: Colors.white,
                  onPressed: () async {
                    List<Map> response1 = await dbconfig.readData(
                        "SELECT * FROM vente WHERE addedDate LIKE '" +
                            _selectedDate.toString().substring(0, 10) +
                            "%'");

                    if (response1.isEmpty) {
                      var snackbar = SnackBar(
                        content: Text(
                          "!! غير متوفر مبيعات لهذا اليوم",
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
                    } else {
                      print("Les vente du jour");
                      print(response1);

                      List<Map> response2;
                      List<Map> response3;
                      int count = 0;
                      int total = 0;
                      int nbArticle = 0;
                      int total1 = 0;
                      while (count < response1.length) {
                        response2 = await dbconfig.readData(
                            "SELECT * FROM ligneCommande WHERE vid='" +
                                response1
                                    .asMap()[count]!
                                    .values
                                    .toList()
                                    .asMap()[0]
                                    .toString() +
                                "'");
                        if (response2.isNotEmpty) {
                          print("Ligne commande");
                          print(response2);
                          int count2 = 0;
                          while (count2 < response2.length) {
                            nbArticle = nbArticle +
                                int.parse(response2
                                    .asMap()[count2]!
                                    .values
                                    .toList()
                                    .asMap()[2]
                                    .toString());

                            response3 = await dbconfig.readData(
                                "SELECT * FROM produit WHERE pid='" +
                                    response2
                                        .asMap()[count2]!
                                        .values
                                        .toList()
                                        .asMap()[1]
                                        .toString() +
                                    "'");

                            total1 = total1 +
                                int.parse(response3
                                        .asMap()[0]!
                                        .values
                                        .toList()
                                        .asMap()[6]
                                        .toString()) *
                                    int.parse(response2
                                        .asMap()[count2]!
                                        .values
                                        .toList()
                                        .asMap()[2]
                                        .toString());
                            count2++;
                          }
                        }

                        total = total +
                            int.parse(response1
                                .asMap()[count]!
                                .values
                                .toList()
                                .asMap()[3]
                                .toString());

                        count++;
                      }
                      print(total.toString());
                      //print(count2.toString());
                      print(total1.toString());

                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                            backgroundColor: Colors.lime,
                            title: Center(
                              child: Text(
                                "مداخيل اليوم",
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
                                    child: Column(children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Center(
                                          child: Text(
                                            _selectedDate
                                                .toString()
                                                .substring(0, 10),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 26,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Flexible(
                                          child: Text(
                                            ": التاريخ و الوقت ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
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
                                          total.toString() + " DA",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.normal),
                                        )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Center(
                                            child: const Text(
                                          ": مدخول اليوم",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
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
                                          nbArticle.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 26,
                                              fontWeight: FontWeight.normal),
                                        )),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Center(
                                            child: const Text(
                                          ": عدد المنتوجات المباعة ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
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
                                            (int.parse(total.toString()) -
                                                        int.parse(
                                                            total1.toString()))
                                                    .toString() +
                                                " DA",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 26,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Center(
                                            child: const Text(
                                          ": الربح الصافي ",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )),
                                      ],
                                    ),
                                  ]))),
                      );
                    }
                  },
                  icon: Icon(
                    Icons.account_balance_wallet,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
