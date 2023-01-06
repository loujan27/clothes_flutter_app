import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'navigationDrawer.dart';

class about extends StatefulWidget {
  const about({Key? key}) : super(key: key);

  @override
  State<about> createState() => _aboutState();
}

class _aboutState extends State<about> {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: NavigationDrawer(),
      appBar: AppBar(
        title: Text('About'),
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
            height: 8,
          ),
          Text(
            "Hadjame Mohammed",
            style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 28,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            "Software engineer",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                child: Center(
                  child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        hoverColor: Colors.blueGrey,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            titleTextStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            headerAnimationLoop: false,
                            dialogType: DialogType.noHeader,
                            title: 'Facebook',
                            descTextStyle: TextStyle(
                                fontSize: 22, fontStyle: FontStyle.italic),
                            desc: 'Mohamed Hadjame',
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                            },
                            btnOkIcon: Icons.check_circle,
                          ).show();
                        },
                        child: Center(
                            child: Icon(FontAwesomeIcons.facebook, size: 32)),
                      )),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              CircleAvatar(
                radius: 25,
                child: Center(
                  child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        hoverColor: Colors.blueGrey,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.noHeader,
                            titleTextStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            title: 'Linkedin',
                            descTextStyle: TextStyle(
                                fontSize: 22, fontStyle: FontStyle.italic),
                            desc:
                                'https://www.linkedin.com/in/hadjame-mohammed-272014',
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                            },
                            btnOkIcon: Icons.check_circle,
                          ).show();
                        },
                        child: Center(
                            child: Icon(FontAwesomeIcons.linkedin, size: 32)),
                      )),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              CircleAvatar(
                radius: 25,
                child: Center(
                  child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        hoverColor: Colors.blueGrey,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.noHeader,
                            titleTextStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            title: 'Email',
                            descTextStyle: TextStyle(
                                fontSize: 22, fontStyle: FontStyle.italic),
                            desc: 'm.hadjame@hotmail.com',
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                            },
                            btnOkIcon: Icons.check_circle,
                          ).show();
                        },
                        child: Center(
                            child: Icon(FontAwesomeIcons.mailBulk, size: 32)),
                      )),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              CircleAvatar(
                radius: 25,
                child: Center(
                  child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        hoverColor: Colors.blueGrey,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.noHeader,
                            titleTextStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            title: 'Phone number',
                            descTextStyle: TextStyle(
                                fontSize: 22, fontStyle: FontStyle.italic),
                            desc: '+213659750756',
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                            },
                            btnOkIcon: Icons.check_circle,
                          ).show();
                        },
                        child: Center(
                            child: Icon(FontAwesomeIcons.phone, size: 32)),
                      )),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              CircleAvatar(
                radius: 25,
                child: Center(
                  child: Material(
                      shape: CircleBorder(),
                      clipBehavior: Clip.hardEdge,
                      color: Colors.transparent,
                      child: InkWell(
                        hoverColor: Colors.blueGrey,
                        onTap: () {
                          AwesomeDialog(
                            context: context,
                            headerAnimationLoop: false,
                            dialogType: DialogType.noHeader,
                            titleTextStyle: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                            title: 'Adresse',
                            descTextStyle: TextStyle(
                                fontSize: 22, fontStyle: FontStyle.italic),
                            desc: 'Algeria, Mostaganem',
                            btnOkOnPress: () {
                              debugPrint('OnClcik');
                            },
                            btnOkIcon: Icons.check_circle,
                          ).show();
                        },
                        child:
                            Center(child: Icon(FontAwesomeIcons.map, size: 32)),
                      )),
                ),
              ),
            ],
          ),
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
                "About",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                color: Colors.blueGrey,
                padding: EdgeInsets.only(left: 40, right: 40),
                child: Text(
                  "A computer engineer specializing in computer systems engineering with a master 2 degree from the National School of Computer Science of Sidi Bel Abbès, and an experience in network and security and system evaluation, also in the field of embedded and robotics, I am very competent in information system design, and coding with different programming languages such as java, c++ and python, also in mobile, database, web and desktop development, with different framework. Teamwork is one of my strengths to reach a specific goal in time with a reliable and well organized personality. ",
                  style: TextStyle(fontSize: 18, height: 1.4),
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
            top: 220,
          ),
        ],
      );

  Widget buildCoverImage() => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/programming-laptop.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: 300,
      );
  Widget buildProfileImage() => CircleAvatar(
        radius: 75,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage('assets/moh.png'),
      );
}
