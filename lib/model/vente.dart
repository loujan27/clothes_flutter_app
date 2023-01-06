class VenteModel {
  String? vid;
  String? nombreArticle;
  String? numFacture;
  String? codeProduit;
  String? reference;
  String? prixVente;
  String? stockSortie;
  String? total;
  String? addedDate;
  VenteModel(
      {this.vid,
      this.nombreArticle,
      this.numFacture,
      this.codeProduit,
      this.reference,
      this.prixVente,
      this.stockSortie,
      this.total,
      this.addedDate});
  // static UserModel? current;
  // Data from server "Getters"
  factory VenteModel.fromMap(map) {
    return VenteModel(
      vid: map['vid'],
      nombreArticle: map['nbrArticle'],
      numFacture: map['numFacture'],
      codeProduit: map['codeProduit'],
      reference: map['ref'],
      prixVente: map['prixVente'],
      stockSortie: map['stockSortie'],
      total: map['total'],
      addedDate: map['addedDate'],
    );
  }
  // Sending data to server "Setters"
  Map<String, dynamic> toMap() {
    return {
      'vid': vid,
      'nbrArticle': nombreArticle,
      'numFacture': numFacture,
      'codeProduit': codeProduit,
      'ref': reference,
      'prixVente': prixVente,
      'stockSortie': stockSortie,
      'total': total,
      'addedDate': addedDate,
    };
  }
}
