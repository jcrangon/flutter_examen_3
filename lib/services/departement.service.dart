import 'package:flutter_examen1/models/commune.model.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DepartementService
{
  static String departmentUrl = 'https://geo.api.gouv.fr/regions/@@/departements';
  static String communeUrl = 'https://geo.api.gouv.fr/departements/@@/communes';

  static Future<DepartementList?> getDepartments(String regionCode) async {
    try {
      final response = await http.get(Uri.parse(departmentUrl.replaceAll(RegExp(r'@@'), regionCode)), headers: {"Accept": "application/json"});    

      if (response.statusCode == 200) {

        if (response.body.isNotEmpty) {

          final jsonResponse = json.decode(response.body);

          final DepartementList departements = DepartementList.fromJson(jsonResponse);

          if (departements.departements.isNotEmpty) {
            return departements;

          } else {
            return null; // Aucun département n'a été retourné
          }

        } else {
          return null; // La réponse est vide
        }

      } else {
        throw Exception('Impossible de charger les départements');
      }

    } catch (e) {
      throw Exception('Impossible de charger les départements');
    }
  }

  static Future<CommuneList?> getCommunes(String departementCode) async {
    try {
      final response = await http.get(Uri.parse(communeUrl.replaceAll(RegExp(r'@@'), departementCode)), headers: {"Accept": "application/json"});    

      if (response.statusCode == 200) {

        if (response.body.isNotEmpty) {

          final jsonResponse = json.decode(response.body);

          final CommuneList communes = CommuneList.fromJson(jsonResponse);

          if (communes.communes.isNotEmpty) {
            return communes;

          } else {
            return null; // Aucun département n'a été retourné
          }

        } else {
          return null; // La réponse est vide
        }

      } else {
        throw Exception('Impossible de charger les communes');
      }

    } catch (e) {
      print(e.runtimeType);
      print(e.toString());
      throw Exception('Impossible de charger les communes');
    }
  }

}