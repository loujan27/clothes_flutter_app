import 'package:flutter/material.dart';

import 'about.dart';
import 'adminAccount.dart';
import 'aide.dart';
import 'model/user.dart';
import 'stats.dart';
import 'venteManagement.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  bool currentUser = false;
  UserModel loggedInUser = UserModel();
  late final Info;
  var Name = 'Nabil Bouzid';
  var role = "Commerçant";
  var adresse = "Mostaganem - Mostaganem";
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {});
    //Info = ModalRoute.of(context)?.settings.arguments as List<String?>;
    //Name = Info.first!;
    //role = Info.last!;
  }

  @override
  Widget build(BuildContext context) {
    //var name = "Nom";
    //var email = "admin";

    var txt = "?";
    var urlImage = "images/user.PNG";

    final userAccountHeader = Container(
      height: 200,
      child: UserAccountsDrawerHeader(
          currentAccountPicture: currentUser && urlImage != null
              ? CircleAvatar(
                  child: Image.network(
                    "${urlImage}",
                    fit: BoxFit.fill,
                  ),
                )
              : CircleAvatar(
                  //backgroundColor: Colors.white,
                  //backgroundImage: AssetImage(urlImage),
                  backgroundImage: AssetImage('images/user.png'),
                  radius: 30.0,
                ),
          accountName: Text(Name),
          accountEmail: Column(
            children: [
              Text(adresse),
              SizedBox(
                height: 10,
              ),
              Text(
                role,
                style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.deepOrange,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          arrowColor: Colors.red,
          onDetailsPressed: () {}),
    );

    return Drawer(
      child: Material(
        color: Colors.indigoAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: userAccountHeader,
              ),
              const SizedBox(height: 10),
              //buildSearchItem(),
              const SizedBox(height: 50),
              buildMenuItem(
                  text: 'واجهة المبيعات',
                  icon: Icons.home,
                  onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => venteManagement()))),
              /*const SizedBox(height: 16),
              //if ((role == "admin") || (role == "manager"))
              buildMenuItem(
                  text: 'Gestion des utilisateurs',
                  icon: Icons.people,
                  onClicked: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => userManagement()))),
              const SizedBox(height: 16),*/

              buildMenuItem(
                  text: 'إدارة المنتجات',
                  icon: Icons.add_shopping_cart,
                  onClicked: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => adminAccount()))),
              const SizedBox(height: 16),
              buildMenuItem(
                  text: 'الاحصاءات',
                  icon: Icons.query_stats,
                  onClicked: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => stats()))),
              const SizedBox(height: 16),

              Divider(
                color: Colors.white,
              ),
              /*const SizedBox(height: 24),
              if ((role == "admin") || (role == "manager"))
                buildMenuItem(
                    text: 'Gestion des fournisseur',
                    icon: Icons.account_box_sharp,
                    onClicked: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => fourManagement()))),
              const SizedBox(height: 16),
              */
              buildMenuItem(
                  text: 'Aîde',
                  icon: Icons.help,
                  onClicked: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => aide()))),
              const SizedBox(height: 16),
              buildMenuItem(
                  text: 'À propos',
                  icon: Icons.help_center,
                  onClicked: () => Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => about()))),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchItem() {
    final color = Colors.white;
    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          hintText: 'Search',
          hintStyle: TextStyle(color: color),
          prefixIcon: Icon(Icons.search, color: color),
          //filled=true,
          fillColor: Colors.white12,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color.withOpacity(0.7)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: color.withOpacity(0.7)),
          )),
    );
  }

  Widget buildMenuItem(
      {required String text, IconData? icon, VoidCallback? onClicked}) {
    final color = Colors.white;
    final hoverColor = Colors.white70;
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(
        text,
        style: TextStyle(color: color),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

void selectedItem(BuildContext context, int i) {
  Navigator.of(context).pop();
  switch (i) {
    case 0:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => adminAccount()));
      break;
    case 1:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => adminAccount()));
      break;
    case 2:
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => adminAccount()));
      break;
  }
}
