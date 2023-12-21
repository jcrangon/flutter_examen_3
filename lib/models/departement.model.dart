class Departement
{
  final String nom;
  final String code;
  final String codeRegion;

  Departement({
    required this.nom,
    required this.code,
    required this.codeRegion
  });

  factory Departement.fromJson(Map<String, dynamic> json){
    return Departement(
      nom: json['nom'].toString(),
      code: json['code'],
      codeRegion: json['codeRegion'],
    );
  }
}

class DepartementList
{
  final List<Departement> departements;

  DepartementList({
    required this.departements
  });

  factory DepartementList.fromJson(List<dynamic> parsedJson) {

    List<Departement> departements = <Departement>[];

    departements = parsedJson.map((i)=>Departement.fromJson(i)).toList();

    return DepartementList(
       departements: departements,
    );
  }
}