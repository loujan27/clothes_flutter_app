class ProdModel {
  String? cid;
  String? cname;
  String? code;
  String? location;
  String? debit;
  String? credit;
  String? balance;
// ignore: non_constant_identifier_names
  ProdModel({
    this.cid,
    this.cname,
    this.code,
    this.location,
    this.debit,
    this.credit,
    this.balance,
  });
  // static UserModel? current;
  // Data from server "Getters"
  factory ProdModel.fromMap(map) {
    return ProdModel(
      cid: map['cid'],
      cname: map['cname'],
      code: map['code'],
      location: map['location'],
      debit: map['debit'],
      credit: map['credit'],
      balance: map['balance'],
    );
  }
  // Sending data to server "Setters"
  Map<String, dynamic> toMap() {
    return {
      'cid': cid,
      'cname': cname,
      'code': code,
      'location': location,
      'debit': debit,
      'credit': credit,
      'balance': balance,
    };
  }
}
