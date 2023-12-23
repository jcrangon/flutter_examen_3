import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/components/info_departement.dart';
import 'package:flutter_examen1/components/sliding_menu.dart';

class CommunePage extends StatelessWidget {
  const CommunePage({
    super.key, 
    required this.config, 
    required this.departementName, 
    required this.departementCode}
  );

  final String departementName;
  final String departementCode;
  final Config config;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:false,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Département: $departementName",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      drawer: SlideMenu(config: config, currentPage: config.get('page-name.info-departement')),
      body: InfoDepartement(config: config, departementName: departementName, departementCode: departementCode),
      
    );
  }
}