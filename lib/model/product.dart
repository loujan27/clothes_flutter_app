class ProdModel {
  String? pid;
  String? pname;
  String? uid;
  String? code;
  String? reference;
  String? fournisseur;
  String? category;
  String? prix;
  String? prixVente;
  String? stock;
  String? designation;
  String? addedDate;
  String? ImageUrl;
// ignore: non_constant_identifier_names
  ProdModel(
      {this.pid,
      this.pname,
      this.code,
      this.reference,
      this.fournisseur,
      this.category,
      this.prix,
      this.prixVente,
      this.stock,
      this.designation,
      this.addedDate,
      this.ImageUrl});
  // static UserModel? current;
  // Data from server "Getters"
  factory ProdModel.fromMap(map) {
    return ProdModel(
      pid: map['pid'],
      pname: map['pname'],
      code: map['code'],
      reference: map['ref'],
      fournisseur: map['fournisseur'],
      category: map['cat'],
      prix: map['prix'],
      prixVente: map['prixVente'],
      stock: map['stock'],
      designation: map['designation'],
      addedDate: map['addedDate'],
      ImageUrl: map['ImageUrl'],
    );
  }
  // Sending data to server "Setters"
  Map<String, dynamic> toMap() {
    return {
      'pid': pid,
      'pname': pname,
      'code': code,
      'ref': reference,
      'fournisseur': fournisseur,
      'cat': category,
      'prix': prix,
      'prixVente': prixVente,
      'stock': stock,
      'designation': designation,
      'addedDate': addedDate,
      'ImageUrl': ImageUrl,
    };
  }
}
