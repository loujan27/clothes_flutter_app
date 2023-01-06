class FournModel {
  String? fid;
  String? fname;
  String? fcode;
  String? adresse;
  String? debit;
  String? credit;
  String? balance;
// ignore: non_constant_identifier_names
  FournModel(
      {this.fid,
      this.fname,
      this.fcode,
      this.adresse,
      this.debit,
      this.credit,
      this.balance});
  // static UserModel? current;
  // Data from server "Getters"
  factory FournModel.fromMap(map) {
    return FournModel(
      fid: map['fid'],
      fname: map['fname'],
      fcode: map['fcode'],
      adresse: map['adresse'],
      debit: map['debit'],
      credit: map['credit'],
      balance: map['balance'],
    );
  }
  // Sending data to server "Setters"
  Map<String, dynamic> toMap() {
    return {
      'fid': fid,
      'fname': fname,
      'fcode': fcode,
      'adresse': adresse,
      'debit': debit,
      'credit': credit,
      'balance': balance,
    };
  }
}
