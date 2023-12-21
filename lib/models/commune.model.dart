class Commune
{
  final String nom;
  final String code;
  final String codeDepartement;
  final String siren;
  final String codeEpci;
  final String codeRegion;
  final int population;
  final List<String> codesPostaux;

  Commune({
    required this.nom,
    required this.code,
    required this.codeDepartement,
    required this.siren,
    required this.codeEpci,
    required this.codeRegion,
    required this.population,
    required this.codesPostaux
  });

  factory Commune.fromJson(Map<String, dynamic> json){
    return Commune(
      nom: json['nom'].toString(),
      code: json['code'],
      codeDepartement:json['codeDepartement'],
      siren:json['siren'],
      codeEpci:json['codeEpci'],
      codeRegion:json['codeRegion'],
      population:json['population'],
      codesPostaux:(json['codesPostaux'] as List).map((e)=> e as String).toList()
    );
  }
}

class CommuneList
{
  final List<Commune> communes;

  CommuneList({
    required this.communes
  });

  factory CommuneList.fromJson(List<dynamic> parsedJson) {

    List<Commune> communes = <Commune>[];

    communes = parsedJson.map((i)=>Commune.fromJson(i)).toList();

    return CommuneList(
       communes: communes,
    );
  }
}