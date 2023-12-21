import 'package:flutter/material.dart';
import 'package:flutter_examen1/components/config.dart';
import 'package:flutter_examen1/pages/home_page.dart';
import 'package:flutter_examen1/pages/regions_page.dart';

class Page404 extends StatelessWidget {
  const Page404({super.key, required this.config, this.backUrl});

  final Config config;
  final String? backUrl;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Page non trouvée'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'web/assets/img/404.png', // Remplacez cela par le chemin de votre propre image
                width: 150.0,
                height: 150.0,
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Erreur 404',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10.0),
              const Text(
                'Page non trouvée',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  if(backUrl != null) {
                    switch (backUrl) {
                      case "regionSearch":
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) 
                            => RegionPage(
                              config: config,
                            )
                          )
                        );
                      break;
                    }
                  } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) 
                          => HomePage(
                            config: config,
                          )
                        )
                      );
                  }
                  
                },
                child: LayoutBuilder(builder: (context, constraints) { 
                    if(backUrl != null) {
                      switch (backUrl) {
                        case "regionSearch":
                          return const Text('Retour à la Recherche');
                      } 
                    }
                    return const Text('Retour à la page d\'accueil');
                  }
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}