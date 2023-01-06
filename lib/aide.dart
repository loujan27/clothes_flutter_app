import 'package:flutter/material.dart';

import 'navigationDrawer.dart';

class aide extends StatefulWidget {
  const aide({Key? key}) : super(key: key);

  @override
  State<aide> createState() => _aideState();
}

class _aideState extends State<aide> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('Aide'),
        centerTitle: true,
        backgroundColor: Colors.cyan,
        actions: <Widget>[
          CircleAvatar(
            backgroundImage: AssetImage('images/nabilLogo.png'),
            radius: 30.0,
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          buildTop(),
          buildContent(),
        ],
      ),
    );
  }

  Widget buildContent() => Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Divider(),
          const SizedBox(
            height: 16,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                "Application Gestion des vêtements",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.blueGrey,
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Text(
                  "Si vous avez besoin de tout type de question, vous pouvez appeler au +213659750756 ou vous pouvez envoyer un message dans ce mail 'm.hadjame@hotmail.com' ",
                  style: TextStyle(
                      fontSize: 18, height: 1.4, color: Colors.black87),
                ),
              ),
            ],
          )
        ],
      );

  Widget buildTop() => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 80), child: buildCoverImage()),
          Positioned(
            child: buildProfileImage(),
            top: 280,
          ),
        ],
      );

  Widget buildCoverImage() => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/nabilLogo.png'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: 300,
      );
  Widget buildProfileImage() => CircleAvatar(
        radius: 75,
        backgroundColor: Colors.green,
        child: Text(
          "?",
          style: TextStyle(
              fontSize: 60, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // backgroundImage: AssetImage('assets/moh.png'),
      );
}
