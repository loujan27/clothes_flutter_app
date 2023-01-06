import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class UserModel {
  String? uid;
  String? userName;
  String? pword;
  String? firstName;
  String? Fname;
  String? gender;
  String? role;
  String? ImageUrl;
// ignore: non_constant_identifier_names
  UserModel(
      {this.uid,
      this.userName,
      this.firstName,
      this.Fname,
      this.gender,
      this.pword,
      this.role,
      this.ImageUrl});
  // static UserModel? current;
  // Data from server "Getters"
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      userName: map['username'],
      pword: map['pwd'],
      firstName: map['fname'],
      Fname: map['name'],
      gender: map['gender'],
      role: map['role'],
      ImageUrl: map['ImageUrl'],
    );
  }
  // Sending data to server "Setters"
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': userName,
      'pwd': pword,
      'fname': Fname,
      'name': firstName,
      'gender': gender,
      'role': role,
      'ImageUrl': ImageUrl,
    };
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    final Future<Database> database = openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: (db, version) {
        return db
            .execute("CREATE TABLE user( uid int(11) NOT NULL AUTO_INCREMENT, "
                "username varchar(50) NOT NULL,"
                "pwd varchar(50) NOT NULL,"
                "role varchar(50) NOT NULL,"
                "unique(username,pwd),"
                "PRIMARY KEY (uid)"
                ") ");
      },
      version: 1,
    );

    Future<void> insertUser(UserModel user) async {
      final Database db = await database;
      await db.insert(
        'user',
        user.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}
