import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/commune.model.dart';
import 'package:flutter_examen1/pages/404_page.dart';
import 'package:flutter_examen1/services/departement.service.dart';

class InfoDepartement extends StatefulWidget {
  const InfoDepartement({super.key, required this.config, required this.departementName, required this.departementCode});

  final Config config;
  final String departementName;
  final String departementCode;

  @override
  State<InfoDepartement> createState() => _InfoDepartementState();
}

class _InfoDepartementState extends State<InfoDepartement> {

  late Future<CommuneList?> communes;

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  @override
  void didUpdateWidget(covariant InfoDepartement oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.departementCode != oldWidget.departementCode) {
      loadDepartments();
    }
  }

  loadDepartments() {
    setState(() {
        communes = DepartementService.getCommunes(widget.departementCode);
    });
    
  }

  void _showCommuneDetails(Commune commune) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Détails de la commune'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nom: ${commune.nom}'),
              Text('Code: ${commune.code}'),
              Text('Code Dep.: ${commune.codeDepartement}'),
              Text('Siren.: ${commune.siren}'),
              Text('Code Epci.: ${commune.codeEpci}'),
              Text('Population: ${commune.population}'),
              Text('Codes Postaux: ${commune.codesPostaux.join(', ')}'),
              // Ajoutez d'autres champs selon vos besoins
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Ferme la modale
              },
              child: Text('Fermer'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<CommuneList?>(
      future: communes,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data!.departements[0].nom);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Le département: ${widget.departementName}(${widget.departementCode}), compte ${snapshot.data!.communes.length} communes.\nCliquez sur l\'une des communes suivantes pour en savoir plus...\n\n',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.communes.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        print('Ligne cliquée : ${snapshot.data!.communes[index].nom}');
                        _showCommuneDetails(snapshot.data!.communes[index]);
                      },
                      child: Card(
                        elevation: 2.0,
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(snapshot.data!.communes[index].nom),
                          subtitle: Text('Population: ${snapshot.data!.communes[index].population}, Cde.Post.: ${snapshot.data!.communes[index].codesPostaux.join(',')}'),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ]
          );
        } else if (snapshot.hasError) {
          print(snapshot.error);
          Future.delayed(
            Duration.zero, 
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) 
                  => Page404(
                    config: widget.config
                  )
                )
              );
            }
          );
        }

        // By default, show a loading spinner.
        return const Expanded(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}