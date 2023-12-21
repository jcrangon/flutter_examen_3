import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/models/departement.model.dart';
import 'package:flutter_examen1/pages/404_page.dart';
import 'package:flutter_examen1/pages/commune_page.dart';
import 'package:flutter_examen1/services/departement.service.dart';

class InfoRegion extends StatefulWidget {
  const InfoRegion({super.key, required this.config, required this.regionName, required this.regionCode});

  final Config config;
  final String regionName;
  final String regionCode;

  @override
  State<InfoRegion> createState() => _InfoRegionState();
}

class _InfoRegionState extends State<InfoRegion> {

  late Future<DepartementList?> departements;

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  @override
  void didUpdateWidget(covariant InfoRegion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.regionCode != oldWidget.regionCode) {
      loadDepartments();
    }
  }

  loadDepartments() {
    setState(() {
        departements = DepartementService.getDepartments(widget.regionCode);
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DepartementList?>(
      future: departements,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          // print(snapshot.data!.departements[0].nom);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'La région ${widget.regionName}(${widget.regionCode}) compte ${snapshot.data!.departements.length} départements.\nCliquez sur l\'un des département pour en savoir plus...\n\n',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.departements.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Ajoutez ici la logique à exécuter lorsqu'une ligne est cliquée
                        print('Ligne cliquée : ${snapshot.data!.departements[index].nom}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) 
                            => CommunePage(
                              config: widget.config, 
                              departementName: snapshot.data!.departements[index].nom, 
                              departementCode: snapshot.data!.departements[index].code,
                            )
                          )
                        );
                      },
                      child: Card(
                        elevation: 2.0,
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(snapshot.data!.departements[index].nom),
                          subtitle: Text('Code du département: ${snapshot.data!.departements[index].code}'),
                        ),
                      ),
                    );
                  }
                ),
              ),
            ]
          );
        } else if (snapshot.hasError) {
          Future.delayed(
            Duration.zero, 
            () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) 
                  => Page404(
                    config: widget.config,
                    backUrl: 'regionSearch',
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